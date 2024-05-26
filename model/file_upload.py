import os
import uuid
from datetime import datetime

from model.CORSMixin import CORSMixin
import tornado
import tornado.web
from model.connect_sqlsever import *
import json


class default_upload_Handler(tornado.web.RequestHandler, CORSMixin):
    conn = connMysql()
    sava_path = 'H:/web_preject/user_upload_file/'
    allowed_extensions = ['.jpg', '.jpeg', '.png', '.gif']

    def post(self):
        try:
            # 确保保存路径存在
            if not os.path.exists(self.save_path):
                os.makedirs(self.save_path)

            files = self.request.files.values()

            if files:
                for file_list in files:
                    for file in file_list:
                        file_body = file['body']
                        file_name = file['filename']
                        _, file_extension = os.path.splitext(file_name)
                        if file_extension.lower() in self.allowed_extensions:
                            # 避免文件重名冲突
                            unique_name = f"{datetime.now().strftime('%Y%m%d%H%M%S')}_{uuid.uuid4().hex}{file_extension}"
                            file_path = os.path.join(self.save_path, unique_name)
                            with open(file_path, 'wb') as f:
                                f.write(file_body)

                            print(f'文件 {file_name} 上传成功，保存为 {unique_name}')

                            # 文件拓展名
                            file_extension = file_extension.replace('.', '')

                            # 插入数据库
                            conn = self.conn.connect()
                            cursor = conn.cursor()
                            sql = ('INSERT INTO default_upload (file_name, file_extension, time, upload_user, '
                                   'upload_user_id)'
                                   'VALUES (%s, %s, %s, %s, %s)')
                            data = (
                                file_name, file_extension, datetime.now().strftime('%Y-%m-%d %H:%M:%S'), '用户名',
                                '111')
                            cursor.execute(sql, data)
                            conn.commit()
                            cursor.close()
                            conn.close()

                            self.write(json.dumps({"status": "success", "message": "文件上传成功"}))
                        else:
                            print(f'文件 {file_name} 类型不支持')
                            self.write(json.dumps({"status": "error", "message": "文件类型不支持"}))
            else:
                self.write(json.dumps({"status": "error"}))
                print('未上传文件')
        except Exception as e:
            self.set_status(500)
            self.write(json.dumps({"status": 'error', "message": "服务器内部错误"}))
            print(f"上传文件时发生错误: {e}")


class EditBackImgHandler(tornado.web.RequestHandler, CORSMixin):
    conn = connMysql()
    upload_path = "H:/web_preject/image"
    allowed_extensions = ['.jpg', '.jpeg', '.png', '.gif']

    def post(self):
        self.set_status(200)
        try:
            # 确保保存路径存在
            if not os.path.exists(self.upload_path):
                os.makedirs(self.upload_path)

            files = self.request.files.get('file')
            username = self.get_body_argument('user_name')
            user_id = self.get_body_argument('user_id')

            if files:
                for file in files:
                    file_body = file['body']
                    file_name = file['filename']
                    _, file_extension = os.path.splitext(file_name)
                    if file_extension.lower() in self.allowed_extensions:
                        # 避免文件重名冲突
                        unique_name = f"{datetime.now().strftime('%Y%m%d%H%M%S')}_{uuid.uuid4().hex}{file_extension}"
                        file_path = os.path.join(self.upload_path, unique_name)
                        with open(file_path, 'wb') as f:
                            f.write(file_body)
                        print(f'文件 {file_name} 上传成功，保存为 {unique_name}')

                        # 文件拓展名
                        file_extension = file_extension.replace('.', '')
                        saved_file_name = unique_name

                        # 更新数据库
                        conn = self.conn.connect()
                        cursor = conn.cursor()
                        sql = "UPDATE users SET user_back_img = %s WHERE userid = %s AND username = %s"
                        cursor.execute(sql, (saved_file_name, user_id, username))
                        conn.commit()
                        cursor.close()
                        conn.close()
                    else:
                        self.write(json.dumps({"status": "error", "message": "文件类型不支持"}))
                        print(f'文件 {file_name} 类型不支持')

            self.set_status(200)
            self.write(json.dumps({"status": "success", "message": "文件上传成功"}))

        except Exception as e:

            self.set_status(500)
            self.write(json.dumps({"status": 'error', "message": "服务器内部错误"}))
            print(f"上传文件时发生错误: {e}")


class delete_back_image(tornado.web.RequestHandler, CORSMixin):
    conn = connMysql()
    upload_path = "H:/web_preject/image"

    def post(self):
        self.set_status(200)
        try:
            conn = self.conn.connect()
            cursor = conn.cursor()
            user_id = self.get_body_argument('user_id')
            username = self.get_body_argument('user_name')
            get_filename_sql = "select user_back_img from users where userid=%s and username=%s"
            cursor.execute(get_filename_sql, (user_id, username))
            filename = cursor.fetchone()[0]

            if filename:
                file_path = os.path.join(self.upload_path, filename)
                if os.path.exists(file_path):
                    os.remove(file_path)
                    print(f'文件 {filename} 删除成功')
                else:
                    print(f'文件 {filename} 不存在')
                    self.write(json.dumps({"status": "error", "message": "文件不存在"}))
            # 更新数据库
            sql = "update users set user_back_img='' where userid=%s and username=%s"
            cursor.execute(sql, (user_id, username))
            conn.commit()
            self.write(json.dumps({"status": "success", "message": "文件删除成功"}))

        except Exception as e:
            print(e)
            self.write(json.dumps({"status": 'error', "message": "服务器内部错误"}))

class update_user_avatar(tornado.web.RequestHandler,CORSMixin):
    conn=connMysql
    def post(self):
        self.set_status(200)
        self.set_header('Content-Type', 'application/json')
        try:
            conn=self.conn.connect()
            cursor=conn.cursor()
            body=json.loads(self.request.body)
        except Exception as e:
            print(e)
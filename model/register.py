import os
import re
import uuid

from model.CORSMixin import CORSMixin
import tornado
import tornado.web
from model.connect_sqlsever import *
import json


class UploadFile(tornado.web.RequestHandler, CORSMixin):
    file_path = 'H:/web_project/image'
    allowed_extensions = ['.jpg', '.jpeg', '.png', '.gif']  # 添加更多类型如有需要

    async def post(self):
        files = self.request.files.get('avatar')
        self.set_status(200)
        self.write(json.dumps({"statusCode":200}))
        try:
            if files:
                for file in files:
                    file_body = file['body']
                    file_name = file['filename']
                    _, file_extension = os.path.splitext(file_name)
                    if file_extension.lower() in self.allowed_extensions:
                        # 调整文件路径，保存在指定目录中
                        file_path = os.path.join(self.file_path, file_name)
                        # 将文件写入磁盘
                        with open(file_path, 'wb') as f:
                            f.write(file_body)
                        self.write('文件上传成功')
                        print('文件上传成功')
                    else:
                        self.write('不支持的文件类型')
            else:
                self.write('未上传文件')
        except Exception as e:
            print(e)


class Register(tornado.web.RequestHandler, CORSMixin):
    conn = connMysql
    def get(self):
        self.render("../register_page/register.html")
    async def post(self):
        self.set_status(200)
        try:
            conn = self.conn.connect(self)
            cursor = conn.cursor()
            self.set_header('Content-Type', 'application/json')
            data = self.request.body.decode('utf-8')
            data = json.loads(data)
            print(data)
            username = data["username"]
            userid = str(uuid.uuid4())
            user_avatar = data["filename"]
            sex = data["sex"]
            email = data["email"]
            phone = data["phone"]
            password = data["password"]
            #对密码进行复杂度验证
            if len(password) < 8:
                self.write({'status': 'fail','message': '密码长度不能小于8位'})
                return
            password_pattern=re.compile(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$')
            if not password_pattern.match(password):
                self.write({'status': 'fail','message': '密码必须包含大小写字母和数字，且长度不能小于8位'})
                return
            sql = 'insert into users (username,userid,user_avatar,sex,email,phone,password) values(%s,%s,%s,%s,%s,%s,%s)'
            cursor.execute(sql, (username, userid, user_avatar, sex, email, phone, password))
            conn.commit()
            print("注册成功")
            self.write({'status': 'success', 'message': '注册成功'})

        except Exception as e:
            print(e)


class ResetPassword(tornado.web.RequestHandler, CORSMixin):
    conn = connMysql

    def get(self):
        try:
            self.render(os.path.join(os.path.dirname(__file__), '../reset_password/resetpasword.html'))
        except Exception as e:
            print(e)

    def post(self):
        self.set_status(200)
        try:
            conn = self.conn.connect(self)
            cursor = conn.cursor()
            data = self.request.body.decode('utf-8')
            data = json.loads(data)
            print(data)
            username = data["username"]
            password = data["password"]
            phone = data["phone"]
            email = data["email"]
            sql = 'update users set password=%s where username=%s and phone=%s and email=%s'
            cursor.execute(sql, (password, username, phone, email))
            conn.commit()
            if cursor.rowcount > 0:
                self.write(json.dumps({"msg": "success"}))
            else:
                self.write(json.dumps({"msg": "fail"}))

        except Exception as e:
            print(e)

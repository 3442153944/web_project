from model.CORSMixin import CORSMixin
import tornado
import tornado.web
from model.connect_sqlsever import *
import json


class get_all_userinfo(tornado.web.RequestHandler, CORSMixin):
    conn = connMysql()

    def post(self):
        self.set_status(200)
        self.set_header('Content-Type', 'application/json')

        try:
            body = json.loads(self.request.body)
            username = body['user_name']

            conn = self.conn.connect()
            cursor = conn.cursor()
            sql = "SELECT * FROM users WHERE username=%s"
            cursor.execute(sql, (username,))
            result = cursor.fetchone()

            if result:
                column_names = [desc[0] for desc in cursor.description]
                user_info = dict(zip(column_names, result))

                # 移除密码字段
                if 'password' in user_info:
                    del user_info['password']

                print(user_info)
                self.write(json.dumps({"status": "success", "data": user_info}))
            else:
                self.write(json.dumps({"status": "error", "message": "用户不存在"}))

            cursor.close()
            conn.close()

        except Exception as e:
            print(f"获取用户信息时发生错误: {e}")
            self.write(json.dumps({"status": "error", "message": "服务器内部错误", "error": str(e)}))


class update_user_info(tornado.web.RequestHandler, CORSMixin):
    conn = connMysql()

    def post(self):
        self.set_status(200)
        self.set_header('Content-Type', 'application/json')
        try:
            conn = self.conn.connect()
            cursor = conn.cursor()
            body = json.loads(self.request.body)
            user_id = body['user_id']
            username = body['user_name']
            user_self_introduction = body['user_self_introduction']
            sex = body['sex']
            user_address = body['user_address']
            user_self_website = body['user_self_website']
            birthday = body['birthday']
            print(birthday)
            occupation = body['occupation']
            sql = ("update users set username=%s,user_self_introduction=%s,sex=%s,user_address=%s,user_self_website=%s"
                   ",birthday=%s,occupation=%s where userid=%s")
            cursor.execute(sql, (username, user_self_introduction, sex, user_address, user_self_website, birthday,
                                 occupation, user_id))
            conn.commit()
            # 被更改行大于等于一
            if cursor.rowcount >= 1:
                self.write(json.dumps({"status": "success", "message": "更新成功"}))
            else:
                self.write(json.dumps({"status": "error", "message": "更新失败"}))
        except Exception as e:
            print(e)
            self.write(json.dumps({"status": "error", "message": "服务器内部错误"}))

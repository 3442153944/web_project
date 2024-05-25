from model.CORSMixin import CORSMixin
import tornado
import tornado.web
from model.connect_sqlsever import *
import json

class get_all_userinfo(tornado.web.RequestHandler,CORSMixin):
    conn=connMysql()

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

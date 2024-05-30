
from model.CORSMixin import CORSMixin
import tornado
import tornado.web
from model.connect_sqlsever import *
import json


class get_work_info(tornado.web.RequestHandler, CORSMixin):
    conn = connMysql()

    def post(self):
        try:
            self.set_status(200)
            self.set_header('Content-Type', 'application/json')
            conn = self.conn.connect()
            data = json.loads(self.request.body.decode('utf-8'))
            cursor = conn.cursor()
            user_id = data['user_id']
            user_name = data['user_name']
            sql = "select * from novel_work where belong_to_username=%s and belong_to_userid=%s"
            cursor.execute(sql, (user_name, user_id))
            result = cursor.fetchone()

            if result:
                column_names = [desc[0] for desc in cursor.description]
                result_dict = dict(zip(column_names, result))
            else:
                result_dict = None

            self.write(json.dumps({"status": "success", "data": result_dict}))
            print(result_dict)

        except Exception as e:
            self.write(json.dumps({"status": "error"}))
            print(e)

    def get(self):
        self.set_status(200)
        self.write(json.dumps({"status": "success"}))
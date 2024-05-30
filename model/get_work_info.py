from datetime import datetime, date

from model.CORSMixin import CORSMixin
import tornado
import tornado.web
from model.connect_sqlsever import *
import json


def json_serial(obj):
    """JSON serializer for objects not serializable by default json code"""
    if isinstance(obj, (datetime, date)):
        return obj.isoformat()
    raise TypeError("Type not serializable")


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
            results = cursor.fetchall()

            if results:
                column_names = [desc[0] for desc in cursor.description]
                results_dict = [dict(zip(column_names, row)) for row in results]
            else:
                results_dict = []

            self.write(json.dumps({"status": "success", "data": results_dict}, default=json_serial))
            print(results_dict)

        except Exception as e:
            self.write(json.dumps({"status": "error"}))
            print(e)

    def get(self):
        self.set_status(200)
        self.write(json.dumps({"status": "success"}))
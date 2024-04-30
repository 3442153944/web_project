import tornado.web
import json
from model.connect_sqlsever import *
from tornado.httpclient import AsyncHTTPClient


class send_comment(tornado.web.RequestHandler):
    conn = connMysql()

    def post(self):
        self.set_status(200)
        try:
            body = self.request.body.decode('utf-8')
            data = json.loads(body)
            result=self.conn.connect(self)
            sql='select * from comment'
            cursor= result.cursor()
        except Exception as e:
            print(e)

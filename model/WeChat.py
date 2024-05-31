from datetime import datetime, date

from model.CORSMixin import CORSMixin
import tornado
import tornado.web
from model.connect_sqlsever import *
import json


class Wechat(CORSMixin, tornado.web.RequestHandler):
    def post(self):
        self.set_status(200)
        self.set_header('Content-Type', 'application/json')
        data = json.loads(self.request.body.decode('utf-8'))
        self.write(json.dumps({"msg": "ok", "integral": "200"}))

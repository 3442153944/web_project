import os
import re

import tornado.ioloop
import tornado.web
import json
from model.connect_sqlsever import *
from tornado.httpclient import AsyncHTTPClient
from model.CORSMixin import *
from datetime import datetime
from docx import Document
from docx.shared import Pt

class get_workInfo(tornado.web.RequestHandler,CORSMixin):
    conn=connMysql
    def post(self):
        self.set_status(200)

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


class get_comment_section(tornado.web.RequestHandler, CORSMixin):
    conn = connMysql

    def post(self):
        self.set_status(200)
        self.set_header('Content-Type', 'application/json')
        try:
            data = json.loads(self.request.body.decode('utf-8'))
            work_id = data['work_id']
            print(work_id)
            conn = self.conn.connect(self)
            cursor = conn.cursor()
            sql = "select * from comment where work_id=%s"
            cursor.execute(sql, work_id)
            data = cursor.fetchall()
            print(data)
            comment_id_list = []
            is_root_comment_list = []
            send_username_list = []
            send_userid_list = []
            content_list = []
            date_list = []
            main_username_list = []
            main_userid_list = []
            main_comment_index_list = []
            main_comment_id_list = []
            reply_comment_id_list = []

            for i in data:
                comment_id_list.append(i[0])
                is_root_comment_list.append(i[2])
                send_username_list.append(i[3])
                send_userid_list.append(i[4])
                content_list.append(i[5])
                date_list.append(i[6])
                main_username_list.append(i[7])
                main_userid_list.append(i[8])
                main_comment_index_list.append(i[9])
                main_comment_id_list.append(i[10])
                reply_comment_id_list.append(i[11])
            self.write(json.dumps({"comment_id_list": comment_id_list, "is_root_comment_list": is_root_comment_list,
                                   "send_username_list": send_username_list, "send_userid_list": send_userid_list,
                                   "content_list": content_list, "date_list": date_list,
                                   "main_username_list": main_username_list,
                                   "main_userid_list": main_userid_list,
                                   "main_comment_index_list": main_comment_index_list,
                                   "main_comment_id_list": main_comment_id_list,
                                   "reply_comment_id_list": reply_comment_id_list}))

            print(data)

        except Exception as e:
            print(e)
            print('获取评论列表失败')


class add_comment_section(tornado.web.RequestHandler, CORSMixin):
    conn = connMysql

    def post(self):
        self.set_status(200)
        self.set_header('Content-Type', 'application/json')
        try:
            data = json.loads(self.request.body.decode('utf-8'))

            conn = self.conn.connect(self)
            cursor = conn.cursor()

        except Exception as e:
            print(e)


class delete_comment_section(tornado.web.RequestHandler, CORSMixin):
    conn = connMysql

    def post(self):
        self.set_status(200)
        self.set_header('Content-Type', 'application/json')
        try:
            data = json.loads(self.request.body.decode('utf-8'))

            conn = self.conn.connect(self)
            cursor = conn.cursor()

        except Exception as e:
            print(e)

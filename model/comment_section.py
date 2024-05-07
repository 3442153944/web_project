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
            work_id = ''
            is_root_comment = ''
            send_username = ''
            send_userid = ''
            content = ''
            current_time = datetime.now()
            date = current_time.strftime('%Y-%m-%d %H:%M:%S')
            main_username = ''
            main_comment_index = ''
            main_comment_id = ''
            reply_comment_id = ''
            main_userid = ''
            conn = self.conn.connect(self)
            cursor = conn.cursor()
            send_username = data["send_username"]
            # 获取用户ID
            sql = "select userid from users where username=%s"
            cursor.execute(sql, (send_username,))
            send_userid = cursor.fetchone()[0]
            # 获取传入评论信息
            work_id = data["work_id"]
            is_root_comment = data["is_root_comment"]

            send_userid = send_userid
            content = data["content"]
            send_time = date
            main_username = data["main_username"]
            main_comment_index = data["main_comment_index"]
            main_comment_id = data["main_comment_id"]
            reply_comment_id = data["reply_comment_id"]
            main_userid = data["main_userid"]
            # 插入评论
            sql_insert_comment = ("INSERT INTO comment "
                                  "(work_id, is_root_comment, send_username, send_userid, content, date, "
                                  "main_username, main_comment_index, main_comment_id, reply_comment_id, main_userid) "
                                  "VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)")
            cursor.execute(sql_insert_comment, (work_id, is_root_comment, send_username, send_userid, content,
                                                send_time, main_username, main_comment_index, main_comment_id,
                                                reply_comment_id, main_userid))
            conn.commit()
            self.write(json.dumps({"message": "success"}))
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


class get_comment_userAvatar(tornado.web.RequestHandler, CORSMixin):
    conn = connMysql()

    def post(self):
        self.set_status(200)
        self.set_header('Content-Type', 'application/json')
        try:
            data = json.loads(self.request.body.decode('utf-8'))
            username_arr = data["username_list_arr"]
            conn = self.conn.connect()
            cursor = conn.cursor()
            avatar_list = []
            sql = "select user_avatar from users where username=%s"
            for username in username_arr:
                cursor.execute(sql, (username,))

                avatar_list.append(cursor.fetchone()[0])

            self.write(json.dumps({"avatar_list": avatar_list}))
            print(avatar_list)

        except Exception as e:
            print(e)

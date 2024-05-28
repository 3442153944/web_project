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


#点赞，收藏，观看动作处理和统计
class CountWorkData(tornado.web.RequestHandler, CORSMixin):
    conn = connMysql()

    def post(self):
        try:
            self.set_status(200)
            data = json.loads(self.request.body.decode('utf-8'))
            body = json.loads(data['body'])
            conn = self.conn.connect()
            cursor = conn.cursor()
            work_id = body['work_id']
            username = body['username']
            user_id = body['user_id']
            if body['type'] == 'like':
                get_like_num_sql = "select like_num from novel_work where work_id=%s"
                get_like_user_list_sql = "select like_user_list from novel_work where work_id=%s"
                cursor.execute(get_like_num_sql, (work_id,))
                like_num = cursor.fetchone()[0]
                cursor.execute(get_like_user_list_sql, (work_id,))
                like_user_list = cursor.fetchone()[0]
                #如果点赞用户列表中没有执行操作的用户则向点赞列表中增加该用户并且点赞数加一
                if username not in like_user_list:
                    like_user_list = like_user_list + ',' + username
                    update_like_num_sql = "update novel_work set like_num=%s,like_user_list=%s where work_id=%s"
                    cursor.execute(update_like_num_sql, (like_num + 1, like_user_list, work_id,))
                #如果点赞用户列表中有执行点赞操作的用户则移除该列表中的执行点赞操作的用户，并且点赞数减一
                elif username in like_user_list:
                    like_user_list = like_user_list.replace(username, '')
                    update_like_num_sql = "update novel_work set like_num=%s,like_user_list=%s where work_id=%s"
                    cursor.execute(update_like_num_sql, (like_num - 1, like_user_list, work_id,))

        except Exception as e:
            print(e)

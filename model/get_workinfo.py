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
        try:
            self.set_status(200)
            self.set_header('Content-Type', 'application/json')
            body = self.request.body.decode('utf-8')
            data = json.loads(body)
            work_name = data['work_name']
            work_id = data['work_id']

            # 执行第一个查询，获取作者的信息
            sql_author = (
                "SELECT belong_to_username, belong_to_userid FROM"
                " novel_work WHERE work_name='%s' AND work_id='%s'")
            conn = self.conn.connect(self)  # 获取数据库连接
            cursor = conn.cursor()
            cursor.execute(sql_author % (work_name, work_id))
            author_result = cursor.fetchone()
            user_name = author_result[0]
            user_id = author_result[1]

            # 执行第二个查询，获取作者的作品信息
            sql_works = (
                "SELECT work_name, work_series, work_tags FROM"
                " novel_work WHERE belong_to_username='%s' AND belong_to_userid='%s'")
            cursor.execute(sql_works % (user_name, user_id))
            works_result = cursor.fetchall()

            # 初始化作品名称、系列和标签数组
            work_list = []
            series_list = []
            tag_list = []

            # 遍历查询结果并将作品名称、系列和标签分别放入数组中
            for row in works_result:
                work_list.append(row[0])
                # 拆分系列字符串并添加到系列数组中
                series_list.extend(row[1].split(','))
                # 拆分标签字符串并添加到标签数组中
                tag_list.extend(row[2].split(','))

            # 打印结果以便检查
            print("作品名称数组:", work_list)
            print("系列数组:", series_list)
            print("标签数组:", tag_list)

            # 返回成功的响应
            self.write(json.dumps({'status': 'ok','work_list':work_list,'series_list':series_list,'tag_list':tag_list}))
        except Exception as e:
            print(e)

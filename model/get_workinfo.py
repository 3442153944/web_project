import os
import re

import tornado.ioloop
import tornado.web
import json
from model.connect_sqlsever import *
from tornado.httpclient import AsyncHTTPClient
from model.CORSMixin import *
from datetime import datetime, date
from docx import Document
from docx.shared import Pt


class get_workInfo(tornado.web.RequestHandler, CORSMixin):
    conn = connMysql

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
            self.write(
                json.dumps({'status': 'ok', 'work_list': work_list, 'series_list': series_list, 'tag_list': tag_list}))

        except Exception as e:
            print(e)


class get_authorNovelList(tornado.web.RequestHandler, CORSMixin):
    conn = connMysql

    def post(self):
        try:
            self.set_status(200)
            self.set_header('Content-Type', 'application/json')
            body = self.request.body.decode('utf-8')
            data = json.loads(body)
            author_username = data['author_username']
            username = data['username']
            userid = data['userid']
            conn = self.conn.connect(self)
            cursor = conn.cursor()

            # 获取作者信息
            sql_author = "select user_avatar from users where username='%s'"
            cursor.execute(sql_author % author_username)
            author_result = cursor.fetchone()
            author_avatar = author_result[0]

            # 获取登录用户的关注列表
            sql_user_follow = "select user_following from users where username='%s'"
            cursor.execute(sql_user_follow % username)
            user_following_result = cursor.fetchone()
            user_following = user_following_result[0]
            is_follow = ''

            if user_following.find(author_username) >= 1:
                is_follow = '已关注'
            else:
                is_follow = '关注'

            # 获取作者作品信息列表
            sql_author_works = "select work_cover,work_name,work_id,belong_to_username,age_classification,work_tags,author_say from novel_work where belong_to_username='%s'"
            cursor.execute(sql_author_works % author_username)
            works_result = cursor.fetchall()

            # 初始化作品封面、名称、ID、作者、年龄分类、标签和作者说数组
            work_cover_list = []
            work_name_list = []
            work_id_list = []
            author_list = []
            age_classification_list = []
            work_tags_list = []
            author_say_list = []

            # 遍历查询结果并将作品封面、名称、ID、作者、年龄分类、标签和作者说分别放入数组中
            for row in works_result:
                work_cover_list.append(row[0])
                work_name_list.append(row[1])
                work_id_list.append(row[2])
                author_list.append(row[3])
                age_classification_list.append(row[4])
                work_tags_list.append(row[5])
                author_say_list.append(row[6])

            self.write(
                json.dumps({"is_follow": is_follow, "author_avatar": author_avatar, "work_cover_list": work_cover_list,
                            "work_name_list": work_name_list, "work_id_list": work_id_list, "author_list": author_list,
                            "age_classification_list": age_classification_list, "work_tags_list": work_tags_list,
                            "author_say_list": author_say_list}))

        except Exception as e:
            print("An error occurred:", e)
            self.set_status(500)
            self.write(json.dumps({"error": "An error occurred while processing the request."}))


class get_novelwork_list(tornado.web.RequestHandler, CORSMixin):
    conn = connMysql()

    def POST(self):
        try:
            self.set_status(200)
            conn = self.conn.connect()
            cursor = conn.cursor()
            body = self.request.body.decode('utf-8')
            data = json.loads(body)
            sql = 'select * from novel_work'
            cursor.execute(sql)
            result = cursor.fetchall()
            self.write(json.dumps(result))
            print(result)
        except Exception as e:
            print(e)


class get_user_followNovelWork_list(tornado.web.RequestHandler, CORSMixin):
    conn = connMysql()

    def post(self):
        try:
            self.set_status(200)
            conn = self.conn.connect()
            cursor = conn.cursor()
            body = self.request.body.decode('utf-8')
            data = json.loads(body)
            username = data['username']
            user_id = data['user_id']
            #获取用户关注的小说作品列表
            get_user_list = ('select collected_novel_works_id,like_novel_works_id, watch_novel_list_id from users '
                             'where username=%s and userid=%s ')
            cursor.execute(get_user_list, (username, user_id))
            user_following = cursor.fetchone()
            #根据作品ID获取作品信息
            #获取用户收藏的小说作品信息
            collected_novel_list=[]
            get_collectedNovel_info_sql= "select * from novel_work where work_id=%s"
            for collected_novel_id in user_following[0].split(','):
                cursor.execute(get_collectedNovel_info_sql, (collected_novel_id,))
                collected_novel_list.append(cursor.fetchone())

            #获取用户点赞的小说作品信息
            like_novel_list=[]
            get_likeNovel_info_sql= "select * from novel_work where work_id=%s"

            for like_novel_id in user_following[1].split(','):
                cursor.execute(get_likeNovel_info_sql, (like_novel_id,))
                like_novel_list.append(cursor.fetchone())

            #获取用户观看的小说作品信息
            watch_novel_list=[]
            get_watchNovel_info_sql= "select * from novel_work where work_id=%s"
            for watch_novel_id in user_following[2].split(','):
                cursor.execute(get_watchNovel_info_sql, (watch_novel_id,))
                watch_novel_list.append(cursor.fetchone())
            self.write(json.dumps({"collected_novel_list": collected_novel_list, "like_novel_list": like_novel_list,
                                   "watch_novel_list": watch_novel_list}))

        except Exception as e:
            print(e)

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

class get_user_IllWork_list(tornado.web.RequestHandler,CORSMixin):
    conn=connMysql()
    def post(self):
        try:
            self.set_status(200)
            self.set_header('Content-Type', 'application/json')
            conn=self.conn.connect()
            data=json.loads(self.request.body.decode('utf-8'))
            user_id=data['user_id']
            user_name=data['user_name']
            sql="select * from illustration_work where belong_to_user=%s  and belong_to_user_id=%s"
            cursor=conn.cursor()
            cursor.execute(sql, (user_name, user_id))
            results = cursor.fetchall()
            #获取到的所有结果要与字段名一一对应
            if results:
                column_names = [desc[0] for desc in cursor.description]
                result_list=[dict(zip(column_names,row)) for row in results]
            self.write(json.dumps({"status": "success", "data": result_list}, default=json_serial))
            print(result_list)
            conn.close()
        except Exception as e:
            print(e)
            self.write(json.dumps({"status": "error"}))



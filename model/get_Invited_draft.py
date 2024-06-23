import os
import json
import logging
import tornado.web
from decimal import Decimal
from tornado.escape import json_decode
from tornado.web import RequestHandler

from model.CORSMixin import CORSMixin
from model.connect_sqlsever import connMysql
from model.log.log import Logger


# 自定义 JSON 编码器处理 Decimal 类型
class DecimalEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, Decimal):
            return str(obj)
        return super(DecimalEncoder, self).default(obj)


# 假设 CORSMixin 和 connMysql 在其他地方定义
class AuthorGetInvitedDraftAllInfo(tornado.web.RequestHandler, CORSMixin):
    conn = connMysql()
    log_file_path = "web_project/logs/"
    log = Logger()

    def post(self):
        try:
            # 读取并记录请求体
            request_body = self.request.body.decode('utf-8')
            self.log.info(request_body)
            # 处理请求
            data = json.loads(request_body)
            conn = self.conn.connect()
            cursor = conn.cursor()
            request_user = data['request_user']

            if request_user == 'author':
                result = self.query_invited_draft(cursor, data, 'receive_user', 'receive_user_id')
                print('作者请求')
                self.log.info('作者请求')
            elif request_user == 'user':
                result = self.query_invited_draft(cursor, data, 'launch_user', 'launch_user_id')
                print('约稿人请求')
                self.log.info('约稿人请求')
            else:
                result = None

            if result:
                self.write(json.dumps({"status": "success", "data": result}, cls=DecimalEncoder))
                self.log.info(result)
            else:
                self.write(json.dumps({"status": "success", "data": []}))
                self.log.info(data['username'] + "/" + data['user_id'])

        except Exception as e:
            # 记录错误信息
            self.log.error(e, exc_info=True)
            self.write(json.dumps({"status": "error"}))
            print(e)

    def query_invited_draft(self, cursor, data, user_column, user_id_column):
        username = data['username']
        user_id = data['user_id']
        sql = f'SELECT * FROM invited_draft WHERE {user_column}=%s AND {user_id_column}=%s'
        cursor.execute(sql, [username, user_id])
        result = cursor.fetchall()
        if result:
            column_names = [desc[0] for desc in cursor.description]
            result_lists = [dict(zip(column_names, row)) for row in result]
            print(result_lists)
            return result_lists

        return None

import os

import tornado.ioloop
import tornado.web
import json


class CORSMixin(object):
    def set_default_headers(self):
        self.set_header("Access-Control-Allow-Origin", "*")
        self.set_header("Access-Control-Allow-Headers", "x-requested-with")
        self.set_header("Access-Control-Allow-Methods", "POST, GET, OPTIONS")

    def options(self):
        # 对于 OPTIONS 请求，返回 204 No Content 响应
        self.set_status(204)
        self.finish()


class listen(tornado.web.RequestHandler, CORSMixin):

    def post(self):
        body = self.request.body.decode('utf-8')
        data = json.loads(body)
        print(data)
        self.write("ok")

    def get(self):
        # 尝试从查询参数中获取名为 'data' 的参数
        data_str = self.get_argument('data', None)  # 如果没有 'data' 参数，则返回 None
        if data_str is not None:
            try:
                # 尝试将字符串解析为JSON
                data = json.loads(data_str)
                print(data)
            except json.JSONDecodeError as e:
                # 处理JSON解析错误
                print(f"Error parsing JSON: {e}")
                self.write("Error parsing JSON")
                self.set_status(400)  # 设置HTTP状态码为400 Bad Request
                return
        else:
            # 'data' 参数不存在
            self.write("No 'data' parameter provided")
            self.set_status(400)  # 设置HTTP状态码为400 Bad Request

        # 如果一切正常，则返回 'ok'
        self.write("ok")
    def options(self):
        # 对于 OPTIONS 请求，返回 204 No Content 响应
        self.set_status(204)
        self.finish()

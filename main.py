import os
import tornado.web
import tornado.websocket
import tornado.ioloop
import tornado.template
from model.connect_sqlsever import connMysql
from model.file_upload import default_upload_Handler,  EditBackImgHandler
from model.login import do_select_query
import json
from model.sub_page import *
from model.listen import *
from model.novel_work import *
from model.get_workinfo import *
from model.comment_section import *
from model.register import *


# WebSocket 处理器
class CORSMixin(object):
    def set_default_headers(self):
        self.set_header("Access-Control-Allow-Origin", "*")
        self.set_header("Access-Control-Allow-Headers", "x-requested-with")
        self.set_header("Access-Control-Allow-Methods", "POST, GET, OPTIONS")

    def options(self):
        # 对于 OPTIONS 请求，返回 204 No Content 响应
        self.set_status(204)
        self.finish()


class WSHandler(tornado.websocket.WebSocketHandler):
    def open(self):
        print("WebSocket 连接已建立")

    def check_origin(self, origin):
        return True

    def on_message(self, message):
        print("收到消息：", message)
        # 在这里处理用户信息
        userinfo = json.loads(message)
        print(userinfo['username'])
        print(userinfo['password'])
        conn = do_select_query()
        conn.conn()
        # 构造 SQL 查询语句，并执行查询
        sql_query = f"select username, password from user_table where username='{userinfo['username']}' and password='{userinfo['password']}'"
        result = conn.select_query(sql_query)
        print(len(result))
        print(result[0])
        if result and len(result) > 2:
            print(result)
            response = {"status": "success", "message": "登录成功"}
        else:
            response = {"status": "error", "message": "用户名或密码错误"}
        # 将查询结果发送回客户端
        self.write_message(json.dumps(response))

    def on_close(self):
        print("WebSocket 连接已关闭")


# 主页面处理器
class MainHandler(tornado.web.RequestHandler):
    def get(self):
        loader = tornado.template.Loader(".")
        self.write(loader.load("index.html").generate())


# 登录页面处理器
class LoginHandler(tornado.web.RequestHandler):
    def get(self):
        self.render("login.html")


class subpageHandler(tornado.web.RequestHandler):
    def get(self):
        self.render("artwork/1111.html")


class FileUploadHandler(tornado.web.RequestHandler):
    UPLOAD_DIR = "user_uploadavatar"

    def get(self):
        self.render("register_page/register.html")

    def post(self):
        # 检查是否有文件上传
        if 'file' in self.request.files:
            file_info = self.request.files['file'][0]
            fname = file_info['filename']
            content_type = file_info['content_type']
            body = file_info['body']

            # 确保上传目录存在
            if not os.path.exists(self.UPLOAD_DIR):
                os.makedirs(self.UPLOAD_DIR)

            # 构建保存文件的路径
            upload_path = os.path.join(self.UPLOAD_DIR, fname)

            # 保存文件
            with open(upload_path, 'wb') as f:
                f.write(body)

            # 返回成功信息给客户端
            print("文件上传成功")
            src_filename = "user_uploadavatar/" + fname
            print(src_filename)

            # 获取注册信息
            username = self.get_argument("username")
            print(username)
            password = self.get_argument("password")
            print(password)
            sure_password = self.get_argument("sure_password")
            print(sure_password)
            if password != sure_password:
                self.write("两次输入的密码不一致")
                return 0
            sex = self.get_argument("sex")
            email = self.get_argument("email")
            phone = self.get_argument("phone")

            # 执行数据库插入操作
            self.insertuserinfo(username, sex, password, email, phone, src_filename)
        else:
            username = self.get_body_argument("username", default=None)
            if username is None:
                self.write("没有提供用户名")
                return
            # 获取其他表单数据
            password = self.get_body_argument("password", default=None)
            sex = self.get_body_argument("sex", default=None)
            email = self.get_body_argument("email", default=None)
            phone = self.get_body_argument("phone", default=None)
            self.write("没有上传文件，但获取到了其他表单数据")

    def insertuserinfo(self, username_1, sex_1, password_1, email_1, phone_1, filename_1):
        # 创建数据库连接
        db = do_select_query()
        conn = db.conn()

        # 构建 SQL 插入语句
        sql_insert = ("INSERT INTO user_table (`username`, `sex`, `password`, `user_avatar`, `email`, `phone_number`) "
                      "VALUES (%s, %s, %s, %s, %s, %s)")
        values = (username_1, sex_1, password_1, filename_1, email_1, phone_1)

        try:
            # 执行 SQL 插入操作
            with conn.cursor() as cursor:
                cursor.execute(sql_insert, values)
            # 提交事务
            conn.commit()
            self.write("success")
        except Exception as e:
            # 发生异常时输出错误信息
            print("插入用户信息时发生异常：", e)
            self.write("插入失败，请检查输入数据")
        finally:
            # 关闭数据库连接
            db.close_conn(conn)


class resetpasswordHandler(tornado.web.RequestHandler):
    def get(self):
        self.render("resetpassword.html")

    def post(self):
        username = self.get_argument("username", default=None)
        print(username)
        email = self.get_argument("email", default=None)
        print(email)
        phone = self.get_argument("phone", default=None)
        print(phone)
        sex = self.get_argument("sex", default=None)
        print(sex)
        newpassword = self.get_argument("password", default=None)
        print(newpassword)
        password = self.get_argument("sure_password", default=None)
        print(password)
        if newpassword != password:
            return 0
        self.do_select_query(username, email, phone, password)

    def do_select_query(self, username, email, phone, password):
        db = do_select_query()
        conn = db.conn()
        update_sql = "UPDATE user_table SET password = %s WHERE username = %s and email = %s OR phone_number = %s"
        values = (password, username, email, phone)
        try:
            cursor = conn.cursor()
            cursor.execute(update_sql, values)
            conn.commit()
            self.write("success")
        except Exception as e:
            print("更新用户信息时发生异常：", e)
            self.write("更新失败，请检查输入数据")
        finally:
            conn.close()


def make_app():
    return tornado.web.Application([
        (r"/", MainHandler),
        (r"/listen", listen),
        (r"/getMessage", getMessage),
        (r"/get_userinfo", getUserInfo),
        (r"/websocket", WSHandler),
        (r"/login_page", LoginHandler),
        (r"/login", vue_page_login),
        (r"/is_follow", is_follow),
        (r"/get_novel_work", get_novel_work),
        (r"/get_novel_content", get_novel_content),
        (r"/get_workInfo", get_workInfo),
        (r"/sub_page", subpageHandler),
        (r"/get_authorNovelList", get_authorNovelList),  # 作者作品列表横屏信息获取api
        (r"/get_comment_section", get_comment_section),  # 获取评论列表
        (r"/add_comment_section", add_comment_section),  # 添加评论
        (r"/delete_comment_section", delete_comment_section),  # 删除评论
        (r"/get_comment_userAvatar", get_comment_userAvatar),  # 获取评论用户头像
        # (r"/register", FileUploadHandler),#传统网页的注册接口暂时停用
        (r"/reset_password", resetpasswordHandler),
        (r"/user_center", user_center),
        (r"/artwork/(.*)", tornado.web.StaticFileHandler, {"path": "H:/web_preject/artwork"}),
        (r"/artwork_js/(.*)", tornado.web.StaticFileHandler, {"path": "H:/web_preject/artwork/artwork_js"}),
        (r"/artwork_css/(.*)", tornado.web.StaticFileHandler, {"path": "H:/web_preject/artwork/artwork_css"}),
        (r"/image/(.*)", tornado.web.StaticFileHandler, {"path": "H:/web_preject/image"}),
        (r"/css/(.*)", tornado.web.StaticFileHandler, {"path": "H:/web_preject/css"}),
        (r"/js/(.*)", tornado.web.StaticFileHandler, {"path": "H:/web_preject/js"}),
        (r"/image/(.*)", tornado.web.StaticFileHandler, {"path": "H:/web_preject/image"}),
        (r"/user_uploadavatar/(.*)", tornado.web.StaticFileHandler, {"path": "H:/web_preject/user_uploadavatar"}),
        (r"/music/(.*)",tornado.web.StaticFileHandler,{"path":"H:/web_preject/music"}),#音乐文件路径
        (r"/assets/(.*)",tornado.web.StaticFileHandler,{"path":"H:/web_preject/assets"}),#svg图标矢量库
        (r"/register", Register),  # 注册表单提交
        (r"/UploadFile", UploadFile),  # 注册头像提交
        (r"/resetpassword", ResetPassword),  # 重置密码
        (r"/default_upload_Handler",default_upload_Handler),#默认上传文件连接
        (r"/edit_back_img",EditBackImgHandler),#编辑背景图片
    ])


if __name__ == "__main__":
    app = make_app()

    # 启动 HTTP 服务器
    http_server = tornado.httpserver.HTTPServer(app)
    http_server.listen(11451)  # 11451 是 HTTP 端口
    print("HTTP 服务器启动成功，请访问 https://localhost:11451")

    # 启动 HTTPS 服务器
    https_server = tornado.httpserver.HTTPServer(app, ssl_options={
        "certfile": "H:/web_preject/key/server.crt",
        "keyfile": "H:/web_preject/key/server.key",
    })
    https_server.listen(4434)  # 443 是 HTTPS 端口
    print("HTTPS 服务器启动成功，请访问 https://localhost:4434")

    tornado.ioloop.IOLoop.current().start()

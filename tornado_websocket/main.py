from datetime import datetime
from log.log import Logger
import tornado.ioloop
import tornado.web
import tornado.websocket
import tornado.httpserver
import json
import pymysql

logger = Logger()


def connect_mysql():
    return pymysql.connect(
        host='127.0.0.1',
        port=3306,
        user='admin',
        password='123456',
        db='admin',
        charset='utf8',
        cursorclass=pymysql.cursors.DictCursor
    )


class MainHandler(tornado.web.RequestHandler):
    def get(self):
        self.write("Hello, this is the WebSocket server.")


class ChatWebSocket(tornado.websocket.WebSocketHandler):
    connections = {}  # 存储所有的 WebSocket 连接

    def check_origin(self, origin):
        return True  # 允许所有来源

    def open(self):
        self.userid = self.get_argument("userid")
        ChatWebSocket.connections[self.userid] = self
        logger.info(f"WebSocket opened for user {self.userid}")
        self.write_message(json.dumps({"message": f"Hello {self.userid}, you are connected!"}))

    def on_message(self, message):
        try:
            data = json.loads(message)
            message_type = data.get("type")
            send_msg_user_id = data.get("send_msg_user_id")
            to_user_id = data.get("to_user_id")
            content = data.get("content")
            to_group_id = data.get("to_group_id")

            if message_type == "one_to_one":
                self.one_to_one(send_msg_user_id, to_user_id, content)
            elif message_type == "one_to_many":
                self.one_to_many(send_msg_user_id, content)
            elif message_type == "many_to_many":
                self.many_to_many(send_msg_user_id, content, to_group_id)
            else:
                self.write_message(json.dumps({"error": "Invalid message type"}))
        except json.JSONDecodeError:
            self.write_message(json.dumps({"error": "Invalid JSON"}))
        except Exception as e:
            logger.error(f"Error during on_message: {e}")
            self.write_message(json.dumps({"error": "Internal server error"}))

    def on_close(self):
        if hasattr(self, 'userid'):
            del ChatWebSocket.connections[self.userid]
            logger.info(f"WebSocket closed for user {self.userid}")

    def one_to_one(self, send_msg_user_id, to_user_id, content):
        if len(content) > 500:
            self.write_message(json.dumps({"status":"warning","message": "Message too long"}))
            return

        if not content or content.strip() == '':
            self.write_message(json.dumps({'status': 'warning', 'message': '不能发送空消息'}))
            return

        try:
            with connect_mysql() as conn:
                cursor = conn.cursor()
                now_time = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
                message_type = "one_to_one"
                sql = ('INSERT INTO messages (sender_id, receiver_id, content, time, type, receiver_read_status) '
                       'VALUES (%s, %s, %s, %s, %s, %s)')
                cursor.execute(sql, (send_msg_user_id, to_user_id, content, now_time, message_type, '未读'))
                conn.commit()

            to_user = ChatWebSocket.connections.get(to_user_id)
            if to_user:
                to_user.write_message(json.dumps({"message": f"From {self.userid}: {content}"}))
            else:
                self.write_message(json.dumps({"message": f"User {to_user_id} not connected, message saved"}))
                logger.info(f"User {to_user_id} not connected, message saved")
        except Exception as e:
            logger.error(f"Error during one_to_one: {e}")

    def one_to_many(self, send_msg_user_id, content):
        if len(content) > 500:
            self.write_message(json.dumps({"status":"warning","message": "Message too long"}))
            return

        if not content or content.strip() == '':
            self.write_message(json.dumps({'status': 'warning', 'message': '不能发送空消息'}))
            return

        try:
            with connect_mysql() as conn:
                cursor = conn.cursor()
                now_time = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
                for user_id, connection in ChatWebSocket.connections.items():
                    if user_id != self.userid:
                        sql = ('INSERT INTO messages (sender_id, receiver_id, content, time, type, receiver_read_status) '
                               'VALUES (%s, %s, %s, %s, %s, %s)')
                        cursor.execute(sql, (send_msg_user_id, user_id, content, now_time, "one_to_many", '未读'))
                        connection.write_message(json.dumps({"message": f"From {self.userid} to all: {content}"}))
                conn.commit()
        except Exception as e:
            logger.error(f"Error during one_to_many: {e}")

    def many_to_many(self, send_msg_user_id, content, to_group_id):
        if len(content) > 500:
            self.write_message(json.dumps({"status": "warning", "message": "Message too long"}))
            return

        if not content or content.strip() == '':
            self.write_message(json.dumps({'status': 'warning', 'message': '不能发送空消息'}))
            return

        try:
            with connect_mysql() as conn:
                cursor = conn.cursor()
                now_time = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
                sql = ('INSERT INTO messages (sender_id, group_id, content, time, type, receiver_read_status) '
                       'VALUES (%s, %s, %s, %s, %s, %s)')
                for user_id, connection in ChatWebSocket.connections.items():
                    if user_id.startswith(to_group_id):
                        cursor.execute(sql, (send_msg_user_id, to_group_id, content, now_time, 'many_to_many', '未读'))
                        connection.write_message(
                            json.dumps({"message": f"From {self.userid} to group {to_group_id}: {content}"}))
                conn.commit()
        except Exception as e:
            logger.error(f"Error during many_to_many: {e}")


def make_app():
    return tornado.web.Application([
        (r"/", MainHandler),
        (r"/ws/chat/", ChatWebSocket),
    ])


if __name__ == "__main__":
    app = make_app()

    https_server = tornado.httpserver.HTTPServer(app, ssl_options={
        "certfile": "H:/web_project/key/server.crt",
        "keyfile": "H:/web_project/key/server.key",
    })
    https_server.listen(2234)
    logger.info("Tornado WebSocket server is running on wss://localhost:2234/ws/chat/")
    print("Tornado WebSocket server is running on wss://localhost:2234/ws/chat/")
    tornado.ioloop.IOLoop.current().start()

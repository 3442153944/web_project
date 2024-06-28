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
        self.user_id = self.get_argument("user_id")
        ChatWebSocket.connections[self.user_id] = self
        logger.info(f"WebSocket opened for user {self.user_id}")
        self.write_message(json.dumps({"message": f"Hello {self.user_id}, you are connected!"}))

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
        if hasattr(self, 'user_id'):
            del ChatWebSocket.connections[self.user_id]
            logger.info(f"WebSocket closed for user {self.user_id}")

    def one_to_one(self, send_msg_user_id, to_user_id, content):
        try:
            to_user = ChatWebSocket.connections.get(to_user_id)
            now_time = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
            conn = connect_mysql()
            cursor = conn.cursor()
            if to_user:
                sql = 'INSERT INTO messages (sender_id, receiver_id, content, time) VALUES (%s, %s, %s, %s)'
                cursor.execute(sql, (send_msg_user_id, to_user_id, content, now_time))
                conn.commit()
                to_user.write_message(json.dumps({"message": f"From {self.user_id}: {content}"}))
            else:
                self.write_message(json.dumps({"error": f"User {to_user_id} not connected"}))
                logger.error(f"User {to_user_id} not connected")
            conn.close()
        except Exception as e:
            logger.error(f"Error during one_to_one: {e}")

    def one_to_many(self, send_msg_user_id, content):
        try:
            now_time = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
            conn = connect_mysql()
            cursor = conn.cursor()
            for user_id, connection in ChatWebSocket.connections.items():
                if user_id != self.user_id:
                    sql = 'INSERT INTO messages (sender_id, receiver_id, content, time) VALUES (%s, %s, %s, %s)'
                    cursor.execute(sql, (send_msg_user_id, user_id, content, now_time))
                    connection.write_message(json.dumps({"message": f"From {self.user_id} to all: {content}"}))
            conn.commit()
            conn.close()
        except Exception as e:
            logger.error(f"Error during one_to_many: {e}")

    def many_to_many(self, send_msg_user_id, content, to_group_id):
        try:
            now_time = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
            conn = connect_mysql()
            cursor = conn.cursor()
            for user_id, connection in ChatWebSocket.connections.items():
                if user_id.startswith(to_group_id):
                    sql = 'INSERT INTO messages (sender_id, group_id, content, time) VALUES (%s, %s, %s, %s)'
                    cursor.execute(sql, (send_msg_user_id, to_group_id, content, now_time))
                    connection.write_message(
                        json.dumps({"message": f"From {self.user_id} to group {to_group_id}: {content}"}))
                else:
                    connection.write_message(json.dumps({"message": f"From {self.user_id} to everyone: {content}"}))
                    logger.error(f"Group {to_group_id} not connected")
            conn.commit()
            conn.close()
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

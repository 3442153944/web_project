import tornado.ioloop
import tornado.web
import tornado.websocket
import tornado.httpserver
import json

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
        print(f"WebSocket opened for user {self.user_id}")
        self.write_message(json.dumps({"message": f"Hello {self.user_id}, you are connected!"}))

    def on_message(self, message):
        data = json.loads(message)
        message_type = data.get("type")
        to_user_id = data.get("to_user_id")
        content = data.get("content")

        if message_type == "one_to_one":
            self.one_to_one(to_user_id, content)
        elif message_type == "one_to_many":
            self.one_to_many(content)
        elif message_type == "many_to_many":
            self.many_to_many(content)
        else:
            self.write_message(json.dumps({"error": "Invalid message type"}))

    def on_close(self):
        del ChatWebSocket.connections[self.user_id]
        print(f"WebSocket closed for user {self.user_id}")

    def one_to_one(self, to_user_id, content):
        to_user = ChatWebSocket.connections.get(to_user_id)
        if to_user:
            to_user.write_message(json.dumps({"message": f"From {self.user_id}: {content}"}))
        else:
            self.write_message(json.dumps({"error": f"User {to_user_id} not connected"}))

    def one_to_many(self, content):
        for user_id, connection in ChatWebSocket.connections.items():
            if user_id != self.user_id:
                connection.write_message(json.dumps({"message": f"From {self.user_id} to all: {content}"}))

    def many_to_many(self, content):
        for connection in ChatWebSocket.connections.values():
            connection.write_message(json.dumps({"message": f"From {self.user_id} to everyone: {content}"}))

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
    print("Tornado WebSocket server is running on wss://localhost:2234/ws/chat/")
    tornado.ioloop.IOLoop.current().start()

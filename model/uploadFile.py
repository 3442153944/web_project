import os

import tornado


class uploadFile(tornado.web.RequestHandler):
    UPLOAD_DIR = "user_uploadavatar"

    def get(self):
        self.render("register.html")

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
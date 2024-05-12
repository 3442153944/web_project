import os
from model.CORSMixin import CORSMixin
import tornado


class UploadFile(tornado.web.RequestHandler, CORSMixin):
    file_path = 'H:/web_preject/user_uploadavatar/'
    allowed_extensions = ['.jpg', '.jpeg', '.png', '.gif']  # 添加更多类型如有需要

    async def post(self):
        files = self.request.files.get('file')
        if files:
            for file in files:
                file_body = file['body']
                file_name = file['filename']
                _, file_extension = os.path.splitext(file_name)
                if file_extension.lower() in self.allowed_extensions:
                    # 调整文件路径，保存在指定目录中
                    file_path = os.path.join(self.file_path, file_name)
                    # 将文件写入磁盘
                    with open(file_path, 'wb') as f:
                        f.write(file_body)
                    self.write('文件上传成功')
                else:
                    self.write('不支持的文件类型')
        else:
            self.write('未上传文件')
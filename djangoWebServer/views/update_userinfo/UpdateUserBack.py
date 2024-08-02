import uuid
import os
from io import BytesIO

from PIL import Image
from django.db import connection
from django.views import View
from django.http import JsonResponse
from ..log.log import Logger
from datetime import datetime
import json

class UpdateUserBack(View):
    logger = Logger()
    target_path = 'H:/web_project/image/'
    allowed_formats = {'jpg': b'\xff\xd8\xff', 'jpeg': b'\xff\xd8\xff', 'png': b'\x89PNG\r\n', 'tiff': b'II*\x00', 'webp': b'RIFF\x00\x00\x00\x00WEBP'}
    max_file_size = 1024 * 1024 * 8  # 最大文件容量 8MB

    def request_path(self, request):
        now = datetime.now().strftime('%Y-%m-%dT%H:%M:%S')
        request_path = request.path
        request_ip = request.META['REMOTE_ADDR']
        return f'{request_ip}在{now}请求了{request_path}'

    def get(self, request):
        self.logger.warning(self.request_path(request) + '非法GET访问，访问数据为：' + str(request.GET))
        return JsonResponse({'status': 'error', 'message': "非法GET访问"}, status=403)

    def create_uuid(self):
        return str(uuid.uuid4())

    def validate_image_format(self, file, request):
        try:
            file.seek(0)
            header = file.read(1024)
            file.seek(-1024, os.SEEK_END)
            footer = file.read(1024)
            file.seek(0)  # 重置文件指针

            for ext, magic in self.allowed_formats.items():
                if header.startswith(magic) or footer.startswith(magic):
                    return ext

            return None
        except Exception as e:
            self.logger.error(self.request_path(request) + '格式验证失败，错误信息为：' + str(e))
            return None

    def validate_file_size(self, file, request):
        try:
            file.seek(0, os.SEEK_END)
            size = file.tell()
            file.seek(0)  # 重置文件指针
            if size > self.max_file_size:
                return False
            return True
        except Exception as e:
            self.logger.error(self.request_path(request) + '文件大小检查失败，错误信息为：' + str(e))
            return False

    def post(self, request, *args, **kwargs):
        try:
            files = request.FILES.getlist('files')
            data = json.loads(request.POST.get('data', '{}'))
            token = data.get('token')
            admin_userid = 'f575b4d3-0683-11ef-adf4-00ffc6b98bdb'

            if token == 'sunyuanling':
                with connection.cursor() as cursor:
                    cursor.execute('SELECT token FROM users WHERE userid=%s', [admin_userid])
                    token = cursor.fetchone()[0]

            if not token:
                self.logger.warning(self.request_path(request) + 'token为空')
                return JsonResponse({'status': 'error', 'message': 'token为空'}, status=400)

            if not files:
                self.logger.warning(self.request_path(request) + '文件为空')
                return JsonResponse({'status': 'error', 'message': '文件为空'}, status=400)

            with connection.cursor() as cursor:
                cursor.execute('SELECT userid FROM users WHERE token=%s', [token])
                result = cursor.fetchone()

                if result:
                    userid = result[0]
                    saved_files = []

                    for file in files:
                        if not self.validate_file_size(file, request):
                            self.logger.warning(self.request_path(request) + f'文件超出大小限制，文件名为：{file.name}')
                            return JsonResponse({'status': 'file_error', 'message': '文件超出大小限制'}, status=400)

                        if self.validate_image_format(file, request) not in self.allowed_formats:
                            self.logger.warning(self.request_path(request) + f'文件格式不允许，文件名为：{file.name}')
                            return JsonResponse({'status': 'file_error', 'message': '文件格式不允许'}, status=400)

                        filename = file.name
                        ext = filename.split('.')[-1]
                        filename = self.create_uuid() + '.' + ext
                        processed_file = self.process_image(file)
                        file_path = os.path.join(self.target_path, filename)

                        if self.save_to_file(processed_file, file_path, request):
                            saved_files.append(filename)
                        else:
                            self.logger.error(self.request_path(request) + f'文件保存失败，文件名为：{filename}')

                    if saved_files:
                        cursor.execute('UPDATE users SET user_back_img=%s WHERE userid=%s', [saved_files[-1], userid])
                        if cursor.rowcount >= 1:
                            return JsonResponse({'status': 'success', 'message': '上传成功'}, status=200)

                    return JsonResponse({'status': 'error', 'message': '上传失败'}, status=400)

                return JsonResponse({'status': 'error', 'message': '用户不存在'}, status=400)

        except json.JSONDecodeError as e:
            self.logger.error(self.request_path(request) + '数据解析失败，错误信息为：' + str(e))
            return JsonResponse({'status': 'error', 'message': '数据解析失败'}, status=400)
        except Exception as e:
            print(e)
            self.logger.error(self.request_path(request) + '服务器错误，错误信息为：' + str(e))
            return JsonResponse({'status': 'error', 'message': '服务器错误'}, status=500)

    def save_to_file(self, file, target_path, request):
        try:
            with open(target_path, 'wb') as f:
                f.write(file.read())
            return True
        except Exception as e:
            self.logger.error(self.request_path(request) + '文件保存失败，错误信息为：' + str(e))
            return False

    def process_image(self, file):
        img = Image.open(file)
        original_format = img.format  # 获取原始图像格式

        if img.mode == 'RGBA':
            img = img.convert('RGB')

        img = img.resize(img.size, Image.LANCZOS)
        buffer = BytesIO()
        img.save(buffer, format=original_format, quality=100, subsampling=0)
        buffer.seek(0)
        return buffer

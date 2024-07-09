import os
import json
from PIL import Image, ImageOps
from django.http import JsonResponse, HttpResponse
from django.views import View
from django.db import connection
from io import BytesIO
from datetime import datetime
from ..log.log import Logger
from .config import settings


class UploadFile(View):
    logger = Logger()

    ALLOWED_EXTENSIONS = {'.jpg', '.jpeg', '.png', '.tiff'}
    MAX_FILE_SIZE = 50 * 1024 * 1024  # 50 MB

    def request_path(self, request):
        now = datetime.now()
        path = request.path
        request_ip = request.META.get('REMOTE_ADDR')
        return f'请求地址：{request_ip}， 请求时间：{now}，请求IP地址： {path}'

    def get(self, request, *args, **kwargs):
        self.logger.warning(self.request_path(request) + str('get非法访问') + str(request.GET))
        return JsonResponse({'status': 'error', 'message': '非法访问'}, status=403)

    def post(self, request, *args, **kwargs):
        try:
            files = request.FILES.getlist('file')
            work_type = request.POST.get('work_type')
            work_info = json.loads(request.POST.get('work_info'))

            if files and work_type in ('ill', 'comic', 'novel'):
                self.handle_upload(work_type, files, work_info, request)
                return JsonResponse({'status': 'success', 'message': '上传成功'}, status=200)
            else:
                return JsonResponse({'status': 'error', 'message': '无效的文件或类型'}, status=400)
        except json.JSONDecodeError as e:
            self.logger.error(self.request_path(request) + str(e) + str(request.body))
            return JsonResponse({'status': 'error', 'message': 'JSON格式错误'}, status=400)
        except Exception as e:
            self.logger.error(self.request_path(request) + str(e) + str(request.body))
            return JsonResponse({'status': 'error', 'message': '服务器内部错误'}, status=500)

    def handle_upload(self, work_type, files, work_info, request):
        now = datetime.now()
        save_path, save_thumbnail_path = settings['paths'][work_type]
        content_file_list = []

        for index, file in enumerate(files):
            filename, ext = os.path.splitext(file.name)
            if ext.lower() not in self.ALLOWED_EXTENSIONS:
                self.logger.error(f'文件类型不被允许: {file.name}')
                continue
            if file.size > self.MAX_FILE_SIZE:
                self.logger.error(f'文件过大: {file.name}')
                continue

            unique_filename = f"{work_info['userid']}_{index}{ext}"
            full_file_path = os.path.join(save_path, unique_filename)
            self.save_file(full_file_path, file)
            content_file_list.append(unique_filename)

            img_thumbnail = self.img_file_convert(file, 200, 200)
            thumbnail_path = os.path.join(save_thumbnail_path, unique_filename)
            self.save_file(thumbnail_path, img_thumbnail)

        content_file_list_str = ','.join(content_file_list)
        self.save_to_db(work_type, work_info, content_file_list_str, now)
        self.logger.info(self.request_path(request) + ' 上传成功')

    def save_file(self, path, content):
        with open(path, 'wb') as f:
            f.write(content.read() if hasattr(content, 'read') else content)

    def save_to_db(self, work_type, work_info, content_file_list_str, now):
        query = settings['queries'][work_type]
        params = (
            work_info['name'], content_file_list_str, work_info['username'],
            work_info['userid'], now, work_info['work_tags'],
            work_info['brief_introduction'], work_info['age_classification']
        )
        with connection.cursor() as cursor:
            cursor.execute(query, params)
            cursor.commit()

    def img_file_convert(self, file, width, height):
        def convert_image(img):
            target_size = (width, height)
            img = ImageOps.fit(img, target_size, Image.LANCZOS, 0.5, (0.5, 0.5))
            return img

        with Image.open(file) as img:
            img = convert_image(img)
            buffer = BytesIO()
            img.save(buffer, format='JPEG', quality=95)
            buffer.seek(0)
            return buffer

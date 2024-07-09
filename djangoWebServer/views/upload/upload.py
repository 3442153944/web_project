from PIL import Image, ImageOps
from django.http import JsonResponse, HttpResponse
import os
from io import BytesIO
from django.views import View
from django.db import connection
from ..log.log import Logger
from datetime import datetime
import json

class UploadFile(View):
    logger = Logger()

    def request_path(self, request):
        now = datetime.now()
        path = request.path
        request_ip = request.META.get('REMOTE_ADDR')
        return f'请求地址：{request_ip}， 请求时间：{now}，请求IP地址： {path}'

    def get(self, request, *args, **kwargs):
        self.logger.warning(self.request_path(request) + str('get非法访问') + str(request.GET))
        return JsonResponse({'status': 'success', 'message': '非法访问'}, status=403)

    def post(self, request, *args, **kwargs):
        try:
            files = request.FILES.getlist('file')
            work_type = request.POST.get('work_type')
            work_info = json.loads(request.POST.get('work_info'))

            if not files or work_type not in ('ill', 'comic', 'novel'):
                self.logger.warning(self.request_path(request) + str('无效的文件或类型') + str(request.POST))
                return JsonResponse({'status': 'error', 'message': '无效的文件或类型'}, status=400)

            for file in files:
                if not self.is_valid_image(file):
                    self.logger.warning(self.request_path(request) + str('无效的图片文件') + str(request.POST))
                    return JsonResponse({'status': 'error', 'message': '无效的图片文件'}, status=400)
                if file.size > 50 * 1024 * 1024:
                    self.logger.warning(self.request_path(request) + str('文件大小超过限制'))
                    return JsonResponse({'status': 'error', 'message': '文件大小超过限制'}, status=400)

            self.handle_upload(work_type, files, work_info, request)
            self.logger.info(self.request_path(request) + str('上传成功'))
            return JsonResponse({'status': 'success', 'message': '上传成功'}, status=200)

        except json.JSONDecodeError as e:
            self.logger.error(self.request_path(request) + str(e) + str(request.body))
            return JsonResponse({'status': 'error', 'message': 'json格式错误'}, status=400)
        except Exception as e:
            self.logger.error(self.request_path(request) + str(e) + str(request.body))
            return JsonResponse({'status': 'error', 'message': '服务器内部错误'}, status=500)

    def is_valid_image(self, file):
        try:
            Image.open(file).verify()
            return True
        except:
            return False

    def handle_upload(self, work_type, files, work_info, request):
        now = datetime.now()
        user_prefix = f"{work_info['username']}_{now.strftime('%Y%m%d%H%M%S')}"
        paths = {
            'ill': ('H:/web_project/image/', 'H:/web_project/image/thumbnail/'),
            'comic': ('H:/web_project/image/comic/', 'H:/web_project/image/comic/thumbnail/'),
            'novel': ('H:/web_project/image/novel/', 'H:/web_project/image/novel/thumbnail/')
        }
        save_path, save_thumbnail_path = paths[work_type]
        content_file_list = []

        for idx, file in enumerate(files):
            filename = self.get_unique_filename(save_path, user_prefix, file.name, idx + 1)
            full_file_path = os.path.join(save_path, filename)
            with open(full_file_path, 'wb') as f:
                img_data = self.process_image(file)
                f.write(img_data.getvalue())
            content_file_list.append(filename)

            img_thumbnail = self.create_thumbnail(file, 200, 200)
            thumbnail_path = os.path.join(save_thumbnail_path, filename)
            with open(thumbnail_path, 'wb') as f:
                f.write(img_thumbnail.getvalue())

        content_file_list_str = ','.join(content_file_list)
        self.save_to_db(work_type, work_info, content_file_list_str, now)

        self.logger.info(self.request_path(request) + str('上传成功'))

    def get_unique_filename(self, path, prefix, filename, idx):
        base, ext = os.path.splitext(filename)
        unique_filename = f"{prefix}_p{idx}{ext}"
        return unique_filename

    def process_image(self, file):
        with Image.open(file) as img:
            img = img.convert("RGB")
            width, height = img.size
            new_img = Image.new("RGB", (width, height), (255, 255, 255))
            new_img.paste(img, (0, 0))
            buffer = BytesIO()
            new_img.save(buffer, format='JPEG', quality=95)
            buffer.seek(0)
            return buffer

    def create_thumbnail(self, file, width, height):
        with Image.open(file) as img:
            target_size = (width, height)
            img = ImageOps.fit(img, target_size, Image.LANCZOS, 0.5, (0.5, 0.5))
            buffer = BytesIO()
            img.save(buffer, format='JPEG', quality=95)
            buffer.seek(0)
            return buffer

    def save_to_db(self, work_type, work_info, content_file_list_str, now):
        queries = {
            'ill': ('INSERT INTO illustration_work (name, content_file_list, belong_to_user, belong_to_user_id, '
                    'work_tags, create_time, brief_introduction, age_classification) '
                    'VALUES (%s, %s, %s, %s, %s, %s, %s, %s)'),
            'comic': ('INSERT INTO comic (work_name, content_file_list, belong_to_user, belong_to_userid, create_time, '
                      'work_tags, age_classification, brief_introduction) '
                      'VALUES (%s, %s, %s, %s, %s, %s, %s, %s)'),
            'novel': ('INSERT INTO novel_work (work_name, work_cover, belong_to_username, belong_to_userid, '
                      'work_create_time, work_series, work_tags, brief_introduction, author_say, age_classification, '
                      'work_status) '
                      'VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)')
        }
        with connection.cursor() as cursor:
            cursor.execute(queries[work_type], (
                work_info['name'], content_file_list_str, work_info['username'],
                work_info['userid'], now, work_info['work_tags'],
                work_info['brief_introduction'], work_info['age_classification']
            ))
            cursor.commit()

import os
import json
import asyncio
import aiofiles
from PIL import Image, ImageOps
from django.http import JsonResponse, HttpResponse
from django.views import View
from django.db import connections
from io import BytesIO
from datetime import datetime
from ..log.log import Logger
from .config import settings
from django.utils.text import slugify
import random
import magic

class UploadFile(View):
    logger = Logger()

    ALLOWED_EXTENSIONS = {'.jpg', '.jpeg', '.png', '.tiff'}
    MAX_FILE_SIZE = 50 * 1024 * 1024  # 50 MB

    def request_path(self, request):
        now = datetime.now()
        path = request.path
        request_ip = request.META.get('REMOTE_ADDR')
        return f'请求地址：{request_ip}， 请求时间：{now}，请求IP地址： {path}'

    def is_valid_file(file):
        mime = magic.Magic(mime=True)
        file_mime = mime.from_buffer(file.read(1024))
        file.seek(0)
        return file_mime in ['image/jpeg', 'image/png', 'image/tiff']

    async def get(self, request, *args, **kwargs):
        self.logger.warning(self.request_path(request) + ' get非法访问 ' + str(request.GET))
        return JsonResponse({'status': 'error', 'message': '非法访问'}, status=403)

    async def post(self, request, *args, **kwargs):
        try:
            files = request.FILES.getlist('file')
            work_type = request.POST.get('work_type')
            work_info = json.loads(request.POST.get('work_info'))

            if files and work_type in ('ill', 'comic', 'novel'):
                for file in files:
                    if not self.is_valid_file(file):
                        return JsonResponse({'status': 'error', 'message': '无效的文件类型'}, status=400)
                await self.handle_upload(work_type, files, work_info, request)
                return JsonResponse({'status': 'success', 'message': '上传成功'}, status=200)
            else:
                return JsonResponse({'status': 'error', 'message': '无效的文件或类型'}, status=400)

        except json.JSONDecodeError as e:
            self.logger.error(self.request_path(request) + ' ' + str(e) + ' ' + str(request.body))
            return JsonResponse({'status': 'error', 'message': 'JSON格式错误'}, status=400)
        except Exception as e:
            self.logger.error(self.request_path(request) + ' ' + str(e) + ' ' + str(request.body))
            return JsonResponse({'status': 'error', 'message': '服务器内部错误'}, status=500)

    async def handle_upload(self, work_type, files, work_info, request):
        now = datetime.now()
        save_path, save_thumbnail_path = settings['paths'][work_type]
        content_file_list = []
        unique_prefix = self.generate_unique_prefix()

        tasks = []
        for index, file in enumerate(files):
            filename, ext = os.path.splitext(file.name)
            if ext.lower() not in self.ALLOWED_EXTENSIONS:
                self.logger.error(f'文件类型不被允许: {file.name}')
                continue
            if file.size > self.MAX_FILE_SIZE:
                self.logger.error(f'文件过大: {file.name}')
                continue

            safe_filename = self.get_safe_filename(unique_prefix, index, ext)
            full_file_path = os.path.join(save_path, safe_filename)
            processed_image = await self.process_image(file)
            tasks.append(self.save_file(full_file_path, processed_image))
            content_file_list.append(safe_filename)

            img_thumbnail = await self.img_file_convert(file, 200, 200)
            thumbnail_path = os.path.join(save_thumbnail_path, safe_filename)
            tasks.append(self.save_file(thumbnail_path, img_thumbnail))

        await asyncio.gather(*tasks)

        content_file_list_str = ','.join(content_file_list)
        await self.save_to_db(work_type, work_info, content_file_list_str, now)
        self.logger.info(self.request_path(request) + ' 上传成功')

    def generate_unique_prefix(self):
        return ''.join(random.choices('0123456789', k=16))

    def get_safe_filename(self, unique_prefix, index, ext):
        return f"{unique_prefix}_p{index + 1}{ext}"

    async def save_file(self, path, content):
        async with aiofiles.open(path, 'wb') as f:
            await f.write(content.read() if hasattr(content, 'read') else content)

    async def save_to_db(self, work_type, work_info, content_file_list_str, now):
        if work_type == 'ill':
            query = settings['queries']['ill']
            params = (
                work_info['name'], content_file_list_str, work_info['username'],
                work_info['userid'], work_info['work_tags'], now,
                work_info['brief_introduction'], work_info['age_classification']
            )
        elif work_type == 'comic':
            query = settings['queries']['comic']
            params = (
                work_info['name'], content_file_list_str, work_info['username'],
                work_info['userid'], now, work_info['work_tags'],
                work_info['age_classification'], work_info['brief_introduction']
            )
        elif work_type == 'novel':
            query = settings['queries']['novel']
            params = (
                work_info['name'], content_file_list_str, work_info['username'],
                work_info['userid'], now, work_info.get('work_series', ''), work_info['work_tags'],
                work_info['brief_introduction'], work_info.get('author_say', ''),
                work_info['age_classification'], work_info.get('work_status', '')
            )
        else:
            raise ValueError(f"Unsupported work_type: {work_type}")

        async with connections['default'].cursor() as cursor:
            await cursor.execute(query, params)

    async def process_image(self, file):
        def recreate_image(img):
            target_size = img.size
            new_img = Image.new("RGB", target_size, (255, 255, 255))
            new_img.paste(img, (0, 0))
            return new_img

        async with aiofiles.open(file.temporary_file_path(), 'rb') as f:
            img = Image.open(f)
            img = recreate_image(img)
            buffer = BytesIO()
            img.save(buffer, format='JPEG', quality=95)
            buffer.seek(0)
            return buffer

    async def img_file_convert(self, file, width, height):
        def convert_image(img):
            target_size = (width, height)
            img = ImageOps.fit(img, target_size, Image.LANCZOS, 0.5, (0.5, 0.5))

            new_img = Image.new("RGB", target_size, (255, 255, 255))
            new_img.paste(img, (0, 0))
            return new_img

        async with aiofiles.open(file.temporary_file_path(), 'rb') as f:
            img = Image.open(f)
            img = convert_image(img)
            buffer = BytesIO()
            img.save(buffer, format='JPEG', quality=95)
            buffer.seek(0)
            return buffer
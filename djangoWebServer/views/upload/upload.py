from PIL import Image, ImageOps
from django.http import HttpResponse, JsonResponse
import os
from io import BytesIO
from django.views import View
from django.db import connection
from ..log.log import Logger
import json
from datetime import datetime


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
        sava_path = 'H:/web_project/image/'
        sava_thumbnail_path = 'H:/web_project/image/thumbnail/'
        now = datetime.now()
        try:
            data = json.loads(request.body.decode('utf-8'))
            files = data.get('files')
            work_type=data.get('work_type')
            work_info = json.loads(data.get('work_info'))
            if work_type=='ill':
                if files:
                    content_file_list = []
                    for file in files:
                        filename = file.name
                        ext = os.path.splitext(filename)[1]
                        full_file_path = os.path.join(sava_path, filename)

                        with open(full_file_path, 'wb') as f:
                            f.write(file.read())

                        content_file_list.append(filename)

                        img_thumbnail = img_file_convert(file, None, None, 200, 200)
                        thumbnail_path = os.path.join(sava_thumbnail_path, filename)

                        with open(thumbnail_path, 'wb') as f:
                            f.write(img_thumbnail.content)

                    content_file_list_str = ','.join(content_file_list)

                    with connection.cursor() as cursor:
                        sql = ('INSERT INTO illustration_work (name, content_file_list, belong_to_user, belong_to_user_id, '
                               'work_tags, create_time, brief_introduction, age_classification) '
                               'VALUES (%s, %s, %s, %s, %s, %s, %s, %s)')
                        cursor.execute(sql, (work_info['name'], content_file_list_str, work_info['username'], work_info['userid'],
                                             work_info['work_tags'], now, work_info['brief_introduction'],
                                             work_info['age_classification']))

                    self.logger.info(self.request_path(request) + str('上传成功'))
                    return JsonResponse({'status': 'success', 'message': '上传成功'}, status=200)
            elif work_type=='comic':
                if files:
                    content_file_list=[]
                    for file in files:
                        filename=file.name
                        full_file_path=os.path.join(sava_path,filename)

            elif work_type=='novel':
                pass

        except json.JSONDecodeError as e:
            self.logger.error(self.request_path(request) + str(e) + str(request.body))
            return JsonResponse({'status': 'error', 'message': 'json格式错误'}, status=400)
        except Exception as e:
            self.logger.error(self.request_path(request) + str(e) + str(request.body))
            return JsonResponse({'status': 'error', 'message': '服务器内部错误'}, status=500)


def img_file_convert(file=None, src_path=None, tar_path=None, width=200, height=200):
    append_name = 'thumbnail'

    def convert_image(img):
        target_size = (width, height)
        img = ImageOps.fit(img, target_size, Image.LANCZOS, 0.5, (0.5, 0.5))
        return img

    if file:
        with Image.open(file) as img:
            img = convert_image(img)
            buffer = BytesIO()
            img.save(buffer, format='JPEG', quality=95)
            buffer.seek(0)
            return HttpResponse(buffer, content_type='image/jpeg')
    elif src_path and tar_path:
        if not os.path.exists(tar_path):
            os.makedirs(tar_path)

        for filename in os.listdir(src_path):
            if filename.lower().endswith(('.jpg', '.jpeg', '.png', '.tiff')):
                src_file_path = os.path.join(src_path, filename)
                tar_file_path = os.path.join(tar_path, f"{os.path.splitext(filename)[0]}{os.path.splitext(filename)[1]}")

                with Image.open(src_file_path) as img:
                    img = convert_image(img)
                    img.save(tar_file_path, quality=95)


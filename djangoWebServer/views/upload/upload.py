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
        sava_path='H:/web_project/image/'
        sava_thumbnail_path='H:/web_project/image/thumbnail/'
        try:
            data = json.loads(request.body.decode('utf-8'))
            file=data.get('file')
            username= data.get('username')
            userid=data.get('userid')
            if file:
                #获取文件名
                filename = file.name
                #获取扩展名
                ext = os.path.splitext(filename)[1]
                #保存文件
                with open(sava_path+filename, 'wb') as f:
                    #设置保存文件的文件名
                    f.name = filename
                    #设置扩展
                    f.ext = ext
                    #写入文件
                    f.write(file.read())
                    #写入数据库

                with connection.cursor() as cursor:
                    sql=('insert into illustration_work (name,content_file_list,belong_to_user,belong_to_user_id,'
                         'work_tags,create_time,brief_introduction,age_classification) values (%s,%s,%s,%s,%s,%s,%s,%s)')
                    
                # 生成缩略图
                img_thumbnail=img_file_convert(file,None,None, 200, 200)

                with open(sava_thumbnail_path+filename, 'wb') as f:
                    f.name=filename
                    f.ext=ext
                    f.write(img_thumbnail.content)
                self.logger.info(self.request_path(request) + str('上传成功') )
                return JsonResponse({'status': 'success', 'message': '上传成功'}, status=200)

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
        # 处理单个上传的文件
        with Image.open(file) as img:
            img = convert_image(img)
            buffer = BytesIO()
            img.save(buffer, format='JPEG', quality=95)
            buffer.seek(0)
            return HttpResponse(buffer, content_type='image/jpeg')
    elif src_path and tar_path:
        # 创建目标路径文件夹，如果不存在
        if not os.path.exists(tar_path):
            os.makedirs(tar_path)

        # 遍历源路径中的所有图片文件
        for filename in os.listdir(src_path):
            if filename.lower().endswith(('.jpg', '.jpeg', '.png', '.tiff')):
                src_file_path = os.path.join(src_path, filename)
                tar_file_path = os.path.join(tar_path,
                                             f"{os.path.splitext(filename)[0]}{os.path.splitext(filename)[1]}")

                # 打开图片文件
                with Image.open(src_file_path) as img:
                    img = convert_image(img)
                    # 保存转换后的图片到目标路径，保持后缀名不变
                    img.save(tar_file_path, quality=95)

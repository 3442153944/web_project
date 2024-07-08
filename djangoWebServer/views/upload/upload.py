from PIL import Image, ImageOps
from django.http import HttpResponse
import os
from io import BytesIO
from django.views import View


class UploadFile(View):
    pass


def img_file_convert(file=None, src_path=None, tar_path=None,width=200,height=200):
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


# 调用函数
img_file_convert(None, 'H:/web_project/image/', 'H:/web_project/image/avatar_thumbnail/')

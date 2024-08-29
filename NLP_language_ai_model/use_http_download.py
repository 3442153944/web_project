import os
import requests
from concurrent.futures import ThreadPoolExecutor
import hashlib
from PIL import Image
import random
import time  # 需要导入 time 模块

# 数据集位置，用于文件名校验避免，三集污染
path_dict = {
    'result_set': {
        'normal': 'H:/img_data_set/result_set/normal/',
        'r-18': 'H:/img_data_set/result_set/r-18/'
    },
    'test_set': {
        'normal': 'H:/img_data_set/test_set/normal/',
        'r-18': 'H:/img_data_set/test_set/r-18/'
    },
    'validation_set': {
        'normal': 'H:/img_data_set/validation_set/normal/',
        'r-18': 'H:/img_data_set/validation_set/r-18/'
    }
}

# 计算文件的哈希值（如 MD5）
def calculate_md5(file_path):
    hash_md5 = hashlib.md5()
    with open(file_path, "rb") as f:
        for chunk in iter(lambda: f.read(2048), b""):
            hash_md5.update(chunk)
    return hash_md5.hexdigest()

# 遍历所有目录，检查是否有相同文件名或相同文件内容
def is_file_duplicate(file_name, local_file_path):
    for dataset_type, dataset_paths in path_dict.items():
        for category, directory in dataset_paths.items():
            full_path = os.path.join(directory, file_name)
            if os.path.exists(full_path):
                print(f"File with the same name already exists: {full_path}")
                return True
            if os.path.exists(local_file_path) and os.path.exists(directory):
                for existing_file in os.listdir(directory):
                    existing_file_path = os.path.join(directory, existing_file)
                    return True
    return False

# 检查图像文件的完整性
def is_image_valid(file_path):
    try:
        with Image.open(file_path) as img:
            img.verify()  # 验证图像的完整性
        return True
    except (IOError, SyntaxError) as e:
        print(f"Invalid image file: {file_path} - {e}")
        return False

# 图片下载函数
def download_image(img_url, save_path):
    file_name = img_url.split('/')[-1]
    local_file_path = os.path.join(save_path, file_name)

    if is_file_duplicate(file_name, local_file_path):
        print(f"File already exists in one of the datasets, skipping: {img_url}")
        return

    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) '
                      'Chrome/89.0.4389.90 Safari/537.36 Edg/89.0.774.54',
        'Referer': 'https://www.pixiv.net/'
    }

    try:
        # 随机延时 0.2 到 1.5 秒
        time.sleep(random.uniform(0.2, 1.5))
        response = requests.get(img_url, headers=headers, stream=True)
        if response.status_code == 200:
            if not os.path.exists(save_path):
                os.makedirs(save_path)

            # 保存文件
            with open(local_file_path, 'wb') as f:
                for chunk in response.iter_content(1024):
                    f.write(chunk)
            print(f"Image saved: {local_file_path}")

            # 校验图像文件的完整性
            if not is_image_valid(local_file_path):
                os.remove(local_file_path)  # 如果文件无效则删除
                print(f"Removed invalid image: {local_file_path}")
        else:
            print(f"Failed to download image from {img_url}. Status code: {response.status_code}")

    except requests.exceptions.RequestException as e:
        print(f"Error downloading image: {e}")

# URL 原始字符串（你需要将这个值替换为实际的 URL）
url = '''

'''

# 分割为数组
img_urls = url.strip().split('\n')
save_path = "H:/img_data_set/validation_set/r18"

# 使用线程池进行多线程下载
with ThreadPoolExecutor(max_workers=4) as executor:
    futures = [executor.submit(download_image, img_url, save_path) for img_url in img_urls]

# 等待所有线程执行完毕
for future in futures:
    future.result()

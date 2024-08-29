import hashlib
from PIL import Image
import os
import shutil  # 用于文件复制
from concurrent.futures import ThreadPoolExecutor, as_completed  # 多线程库

# 数据集位置，用于文件名校验避免三集污染
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

copy_source_path = "G:/idm_download/pixiv/"
copy_target_path = "H:/img_data_set/result_set/r-18/"
repeat_file_path = "G:/idm_download/repeat"

# 确保重复文件夹存在
os.makedirs(repeat_file_path, exist_ok=True)


# 计算文件的哈希值（如 MD5）
def calculate_md5(file_path):
    hash_md5 = hashlib.md5()
    with open(file_path, "rb") as f:
        for chunk in iter(lambda: f.read(8192), b""):
            hash_md5.update(chunk)
    return hash_md5.hexdigest()


# 遍历所有目录，检查是否有相同文件名或相同文件内容
def is_file_duplicate(file_name, local_file_path):
    local_file_md5 = calculate_md5(local_file_path)

    # 检查重复文件夹中是否已有重复文件
    for repeat_file in os.listdir(repeat_file_path):
        repeat_file_path_full = os.path.join(repeat_file_path, repeat_file)
        if os.path.isfile(repeat_file_path_full):
            if calculate_md5(repeat_file_path_full) == local_file_md5:
                print(f"File with the same content already exists in repeat folder: {repeat_file_path_full}")
                return True

    # 检查其他数据集中的重复文件
    for dataset_type, dataset_paths in path_dict.items():
        for category, directory in dataset_paths.items():
            full_path = os.path.join(directory, file_name)
            if os.path.exists(full_path):
                print(f"File with the same name already exists: {full_path}")
                return True
            if os.path.exists(local_file_path) and os.path.exists(directory):
                for existing_file in os.listdir(directory):
                    existing_file_path = os.path.join(directory, existing_file)
                    if os.path.isfile(existing_file_path):
                        if calculate_md5(existing_file_path) == local_file_md5:
                            print(f"File with the same content already exists: {existing_file_path}")
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


# 检查文件并复制，适用于多线程任务
def check_and_copy_file(file):
    file_path = os.path.join(copy_source_path, file)
    if is_image_valid(file_path):
        if not is_file_duplicate(file, file_path):
            target_file_path = os.path.join(copy_target_path, file)
            try:
                shutil.copy(file_path, target_file_path)
                # 复制成功后删除源文件
                os.remove(file_path)
                return f"{file_path} copied to {target_file_path} and source deleted"
            except Exception as e:
                # 复制失败时将文件移动到重复文件夹
                shutil.move(file_path, os.path.join(repeat_file_path, file))
                return f"Failed to copy {file_path} to {target_file_path}: {e}, moved to repeat folder"
        else:
            # 如果文件重复，则移动到重复文件夹
            shutil.move(file_path, os.path.join(repeat_file_path, file))
            return f"{file_path} is duplicate and moved to repeat folder"
    else:
        # 如果文件无效，则移动到重复文件夹
        shutil.move(file_path, os.path.join(repeat_file_path, file))
        return f"{file_path} is invalid and moved to repeat folder"


# 多线程执行文件检查与复制
def copy_file_check_multithreaded():
    files = []
    for root, dirs, files in os.walk(copy_source_path):
        files = [os.path.join(root, file) for file in files]  # 获取完整文件路径

    with ThreadPoolExecutor(max_workers=12) as executor:  # 使用 12 个线程
        future_to_file = {executor.submit(check_and_copy_file, file): file for file in files}
        for future in as_completed(future_to_file):
            try:
                result = future.result()
                print(result)
            except Exception as exc:
                print(f"File generated an exception: {exc}")


# 删除源目录中的所有文件和子目录，但保留根目录
def clear_source_directory():
    for root, dirs, files in os.walk(copy_source_path):
        for file in files:
            file_path = os.path.join(root, file)
            try:
                os.remove(file_path)
                print(f"Deleted file: {file_path}")
            except Exception as e:
                print(f"Failed to delete {file_path}: {e}")
        for dir in dirs:
            dir_path = os.path.join(root, dir)
            try:
                shutil.rmtree(dir_path)
                print(f"Deleted directory: {dir_path}")
            except Exception as e:
                print(f"Failed to delete directory {dir_path}: {e}")


if __name__ == "__main__":
    copy_file_check_multithreaded()
    clear_source_directory()

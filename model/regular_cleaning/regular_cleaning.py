import os
import time

def delete_expired_files(temp_path, expiration_time=1800):
    """Delete files older than expiration_time (in seconds)"""
    current_time = time.time()
    for filename in os.listdir(temp_path):
        file_path = os.path.join(temp_path, filename)
        if os.path.isfile(file_path):
            # 获取文件的最后修改时间
            file_mtime = os.path.getmtime(file_path)
            if current_time - file_mtime > expiration_time:
                print(f"Deleting expired file: {file_path}")
                os.remove(file_path)

if __name__ == "__main__":
    # 指定临时文件目录
    temp_path = 'H:/web_project/image/novel/temp_cover/'
    delete_expired_files(temp_path)

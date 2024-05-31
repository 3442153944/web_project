import os
import logging
from logging.handlers import RotatingFileHandler
from datetime import datetime

class Logger:
    def __init__(self, log_file_path="H:/logs/", max_bytes=100*1024*1024, backup_count=5):
        self.log_file_path = log_file_path
        self.logger = logging.getLogger(__name__)
        self.logger.setLevel(logging.DEBUG)

        # 确保日志目录存在
        if not os.path.exists(self.log_file_path):
            os.makedirs(self.log_file_path)

        # 通用输入日志的文件处理器，设置大小限制和备份
        input_log_handler = RotatingFileHandler(
            os.path.join(self.log_file_path, 'input.log'),
            maxBytes=max_bytes,
            backupCount=backup_count
        )
        input_log_handler.setLevel(logging.INFO)
        input_log_formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')
        input_log_handler.setFormatter(input_log_formatter)

        # 错误日志的文件处理器，设置大小限制和备份
        error_log_handler = RotatingFileHandler(
            os.path.join(self.log_file_path, 'error.log'),
            maxBytes=max_bytes,
            backupCount=backup_count
        )
        error_log_handler.setLevel(logging.ERROR)
        error_log_formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')
        error_log_handler.setFormatter(error_log_formatter)

        # 添加处理器到日志记录器
        self.logger.addHandler(input_log_handler)
        self.logger.addHandler(error_log_handler)

    def info(self, message):
        timestamped_message = self._add_timestamp(message)
        self.logger.info(timestamped_message)

    def error(self, message, exc_info=False):
        timestamped_message = self._add_timestamp(message)
        self.logger.error(timestamped_message, exc_info=exc_info)

    def _add_timestamp(self, message):
        return f"{message} - {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}"

# 示例使用
if __name__ == "__main__":
    logger = Logger(log_file_path="H:/web_preject/logs/")
    logger.info("This is an info message.")
    logger.error("This is an error message.")

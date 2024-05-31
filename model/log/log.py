import os
import logging


class Logger:
    def __init__(self, log_file_path="web_preject/logs/"):
        self.log_file_path = log_file_path
        self.logger = logging.getLogger(__name__)
        self.logger.setLevel(logging.DEBUG)

        # 确保日志目录存在
        if not os.path.exists(self.log_file_path):
            os.makedirs(self.log_file_path)

        # 通用输入日志的文件处理器
        input_log_handler = logging.FileHandler(os.path.join(self.log_file_path, 'input.log'))
        input_log_handler.setLevel(logging.INFO)
        input_log_formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')
        input_log_handler.setFormatter(input_log_formatter)

        # 错误日志的文件处理器
        error_log_handler = logging.FileHandler(os.path.join(self.log_file_path, 'error.log'))
        error_log_handler.setLevel(logging.ERROR)
        error_log_formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')
        error_log_handler.setFormatter(error_log_formatter)

        # 添加处理器到日志记录器
        self.logger.addHandler(input_log_handler)
        self.logger.addHandler(error_log_handler)

    def info(self, message):
        self.logger.info(message)

    def error(self, message, exc_info=False):
        self.logger.error(message, exc_info=exc_info)

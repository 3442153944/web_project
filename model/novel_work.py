import os

import tornado.ioloop
import tornado.web
import json
from model.connect_sqlsever import *
from tornado.httpclient import AsyncHTTPClient
from model.CORSMixin import *
from datetime import datetime
from docx import Document
from docx.shared import Pt


class get_novel_work(tornado.web.RequestHandler, CORSMixin):
    conn = connMysql()

    def post(self):
        try:
            self.set_status(200)
            self.set_header('Content-Type', 'application/json')
            data = json.loads(self.request.body.decode('utf-8'))
            work_id = data["work_id"]
            sql = "select * from novel_work where work_id=%s"
            conn = self.conn.connect()
            cursor = conn.cursor()
            cursor.execute(sql, work_id)
            result = cursor.fetchone()
            if result:
                result_dict = {}
                for i in range(len(result)):
                    if isinstance(result[i], datetime):
                        result_dict[i] = result[i].isoformat()
                    else:
                        result_dict[i] = result[i]
                work_name = result_dict[6]
                work_list = self.get_work_list(work_name)
                self.write(json.dumps({"work_info": result_dict, "work_list": work_list}))
                print(result_dict)
            else:
                # 如果未找到结果，则返回空字典
                self.write(json.dumps({}))
            conn.close()
        except Exception as e:
            print(e)

    def is_title(self, paragraph):
        if paragraph.text.startswith("第") and "章" in paragraph.text:
            return True
        else:
            return False

    def get_title_name(self, title_text):
        # 假设标题格式为"第......章 标题名称"
        return title_text.split(" ", 1)[1]

    def get_work_list(self, work_name):
        work_file = 'H:/web_preject/novel_work/' + work_name + '.docx'
        title_list = []

        try:
            # 打开 Word 文档
            doc = Document(work_file)
            count = 0
            temp_text = ''

            # 提取标题
            for para in doc.paragraphs:
                temp_text = para.text
                # 判断是否为标题
                if "第" in temp_text and "章" in temp_text:
                    title_list.append(temp_text.strip())
                    temp_text = ''
                    count += 1

            # 如果没有找到标题，则通知
            if not title_list:
                print("未找到任何标题")
            print(count)
            print("标题列表:", title_list)
            return title_list

        except FileNotFoundError:
            print("文件未找到:", work_file)
            return None
        except Exception as e:
            print("发生错误:", e)
            return None

    def chose_title(self, title, work_name):
        work_file = 'H:/web_preject/novel_work/' + work_name + '.docx'
        title_content = ''
        return title_content


class get_novel_content(tornado.web.RequestHandler, CORSMixin):
    conn = connMysql()
    work_name = ''
    work_content = ''

    def post(self):
        self.set_status(200)
        self.set_header('Content-Type', 'application/json')
        data = json.loads(self.request.body.decode('utf-8'))
        try:
            print(data)
            print(data["work_name"])
            title = data["work_title"]
            print(title)
            self.work_name = data["work_name"]
            self.get_work_content(title)  # 调用获取工作内容的方法，并传递标题作为参数
            print(self.work_content+'test')
            self.write(json.dumps({"work_content": self.work_content}))
        except Exception as e:
            print(e)
            print('发送正文内容失败')

    def get_work_content(self, title):
        work_file = 'H:/web_preject/novel_work/' + self.work_name + '.docx'
        title_list = []
        found_title = False  # 初始化found_title为False
        try:
            if title is None:  # 如果标题为空，则默认返回第一章的内容
                title = "第一章"

            doc = Document(work_file)
            self.work_content = ""  # 清空正文内容
            found_titles = 0
            for para in doc.paragraphs:
                temp_text = para.text

                # 如果找到了指定的标题，则开始收集正文内容
                if found_titles >= 2:
                    break  # 如果标题数量大于等于2，则停止收集正文内容
                if temp_text.startswith("第") and "章" in temp_text:
                    if found_titles == 1:
                        title_list.pop()  # 如果是第二个标题，则删除前一个标题
                    title_list.append(para.text)  # 将找到的标题添加到标题列表中
                    found_titles += 1
                # 如果找到了指定的标题，则设置found_title为True
                elif temp_text == title:
                    found_titles += 1

                # 如果已经找到了足够数量的标题，则开始收集正文内容
                if found_titles >= 1:
                    found_title = True

                if found_title:
                    self.work_content += para.text + "<br>"  # 将段落文本添加到工作内容中，并加上换行符
                    # print(para.text+'test')


        except Exception as e:
            print(e)
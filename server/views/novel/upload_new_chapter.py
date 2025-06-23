import re
from bs4 import BeautifulSoup
from django.db import connection
from django.http import JsonResponse
from django.views import View
from ..log.log import Logger
from datetime import datetime
import json
import os
import ahocorasick
from base_api import BaseApi
# Use a pipeline as a high-level helper
from transformers import pipeline
import os
from django.conf import settings


class IndependentContentScanner:
    """三级独立内容扫描器"""

    def __init__(self):
        # 第一级：HTML净化配置
        self.allowed_tags = {'p', 'br', 'strong', 'em', 'u', 'ol', 'ul', 'li','img','video','b','h1','h2','h3','h4','h5','i','strong'}
        self.allowed_attrs = {'style', 'class'}

        # 第二级：敏感词检测初始化
        self.word_path = os.path.join(settings.BASE_DIR, 'views', 'novel', 'word.txt')
        self.sensitive_phrases = self._load_phrases()  # 加载带中括号的短语
        self.ac_matcher = self._build_phrase_matcher()

        # 第三级：AI模型独立初始化
        self.ai_model = pipeline(
            "text-classification",
            model="uer/roberta-base-finetuned-dianping-chinese",
            device='cpu'
        )

    def _load_phrases(self):
        """加载中括号分组的独立短语"""
        phrases = []
        with open(self.word_path, 'r', encoding='utf-8') as f:
            for line in f:
                # 提取所有[...]的内容，每个[...]作为独立短语
                phrases.extend(re.findall(r'\[(.*?)\]', line))
        return phrases

    def _build_phrase_matcher(self):
        """构建短语AC自动机"""
        automaton = ahocorasick.Automaton()
        for phrase in self.sensitive_phrases:
            automaton.add_word(phrase, phrase)
        automaton.make_automaton()
        return automaton

    # ========== 第一级：HTML安全校验 ==========
    def html_safety_check(self, html):
        """
        独立HTML检查
        返回: (is_safe, cleaned_content)
        """
        try:
            soup = BeautifulSoup(html, 'html.parser')

            # 移除所有不允许的标签（保留内容）
            for tag in soup.find_all(True):
                if tag.name not in self.allowed_tags:
                    tag.unwrap()

                # 过滤危险属性
                attrs = dict(tag.attrs)
                for attr in list(attrs.keys()):
                    if attr.lower() not in self.allowed_attrs:
                        del tag.attrs[attr]

            # 特别处理外部资源
            for tag in soup.find_all(['a', 'img', 'iframe', 'script']):
                tag.decompose()

            cleaned = str(soup)
            # 检查是否仍有潜在危险标签
            if re.search(r'<(script|iframe|object|embed)', cleaned, re.I):
                return False, None
            return True, cleaned
        except Exception:
            return False, None

    # ========== 第二级：敏感词独立校验 ==========
    def phrase_check(self, text):
        """
        独立短语检查
        返回: (is_clean, [found_phrases])
        """
        try:
            found = []
            for _, phrase in self.ac_matcher.iter(text):
                found.append(phrase)
            return len(found) == 0, found
        except Exception:
            return True,0

    # ========== 第三级：AI独立内容审核 ==========
    def ai_review(self, text):
        """
        独立AI审核
        返回: (status, confidence)
        """
        try:
            result = self.ai_model(text[:512])[0]  # 截断处理
            return {
                'POSITIVE': 0,  # 拒绝
                'NEGATIVE': 1  # 通过
            }.get(result['label'], 2), result['score']  # 其他情况为待审
        except Exception:
            return 2, 0.0  # 出错时转为人工审核


class UploadNovelChapter(BaseApi):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.pipe = pipeline("text-classification", model="uer/roberta-base-finetuned-dianping-chinese")
        self.word_path = os.path.join(settings.BASE_DIR, 'views', 'novel', 'word.txt')

    #构建筛查函数
    def filter_word(self, word):
        #获取敏感词数组，读取文件，其中以英文状态中括号分割，检查结果以波尔值返回
        with open(self.word_path) as f:
            ...
            return True
        return False

    def post(self, request, *args, **kwargs) -> JsonResponse:
        try:
            if self.check_user(request):
                return self.check_user(request)
            user_id = request.user.id
            data = self.format_request(request)
            chapter_name = data.get('chapter_name')
            series_id = data.get('series_id')
            content = data.get('content')

            if chapter_name and series_id and content:
                get_series_sql = '''select 1 from novel_work where work_id=%s and belong_to_userid=%s'''
                result = self.execute_sql(get_series_sql, [series_id, user_id])[0]
                pass_status = 0
                if result:
                    add_chapter_sql = '''
                    insert into novel_content (belong_to_series_id,title,belong_to_userid,content,chapter_approved)
                     values(%s,%s,%s,%s,%s)
                    '''
                    lens = self.execute_sql(add_chapter_sql, [series_id, user_id, user_id, content, pass_status], False)
                    if lens >= 1:
                        return JsonResponse({'code': 200, 'msg': '章节上传成功'}, status=200)
                    else:
                        return JsonResponse({'code': 401, 'msg': '章节商上传失败，意外的数据库操作'}, status=401)
                else:
                    return JsonResponse({'code': 404, 'msg': '小说系列不存在'}, status=404)
            return JsonResponse({'code': 400, 'msg': '参数错误'}, status=400)
        except Exception as e:
            print(e)
            self.error_log(e, request)
            return JsonResponse({'code': 500, 'msg': '服务器错误'}, status=500)


sex_word_path = 'H:/web_project/djangoWebServer/Sensitive_word/sex.txt'
automaton = None  # 初始化为None


# 读取敏感词并使用Aho-Corasick算法构建自动机
def build_automaton():
    global automaton  # 使用全局变量避免重复初始化
    if automaton is None:  # 确保自动机只初始化一次
        automaton = ahocorasick.Automaton()
        with open(sex_word_path, 'r', encoding='utf-8') as f:
            for line in f:
                for word in line.strip().split(','):  # 使用逗号分隔敏感词
                    if word:
                        automaton.add_word(word, word)
        automaton.make_automaton()


class UploadNewChapter(View):
    now = datetime.now().strftime('%Y-%m-%dT%H:%M:%S')
    logger = Logger()

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        # 构建敏感词自动机
        build_automaton()

    def request_path(self, request):
        request_path = request.path
        request_ip = request.META.get('REMOTE_ADDR')
        return f'{request_ip} 访问了 {request_path}，时间为 {self.now}'

    def check_sensitive_words(self, content):
        """使用Aho-Corasick算法检查内容是否包含敏感词"""
        for end_pos, word in automaton.iter(content):
            return word  # 返回找到的第一个敏感词
        return None

    def get(self, request):
        self.logger.warning(self.request_path(request) + '非法GET访问，访问请求：' + str(request.GET))
        return JsonResponse({'status': 'success', 'message': '非法GET访问，请使用POST请求！'}, status=405)

    def post(self, request, *args, **kwargs):
        try:
            data = json.loads(request.body.decode('utf-8'))
            userid = request.user.id
            if not userid:
                return JsonResponse({'status': 'error', 'message': 'token无效，请重新登陆'}, status=401)

            with connection.cursor() as cursor:
                cursor.execute('SELECT work_id, work_series FROM novel_work WHERE belong_to_userid = %s', [userid])
                columns = [desc[0] for desc in cursor.description]
                result = cursor.fetchall()
                if not result:
                    return JsonResponse({'status': 'error', 'message': '您还没有创建小说，请先创建小说！'}, status=401)
                rows = [dict(zip(columns, row)) for row in result]

            chapter_name = data.get('chapter_name')
            content = data.get('content')
            series_name = data.get('series_name')
            is_series = data.get('is_series')

            # 查找系列对应的 work_id
            work_id = next((row['work_id'] for row in rows if row['work_series'] == series_name), None)
            if not work_id:
                return JsonResponse({'status': 'error', 'message': '指定的系列不存在！'}, status=404)

            # 敏感词检测
            sensitive_word = self.check_sensitive_words(content)
            if sensitive_word:
                chapter_approved = 2  # 不确定，交由人工处理
            else:
                chapter_approved = 1  # 通过

            # 插入章节内容
            sql = (
                'INSERT INTO novel_content (belong_to_series_id, belong_to_userid, title, content, '
                'create_time, is_series, chapter_approved) '
                'VALUES (%s, %s, %s, %s, %s, %s, %s)')
            with connection.cursor() as cursor:
                cursor.execute(sql, [work_id, userid, chapter_name, content, self.now, is_series, chapter_approved])
                if cursor.rowcount <= 0:
                    return JsonResponse({'status': 'error', 'message': '上传新章节失败，请重试！'}, status=500)

            return JsonResponse({'status': 'success', 'message': '上传新章节成功！'}, status=200)

        except json.JSONDecodeError as e:
            self.logger.error(self.request_path(request) + '上传新章节失败，错误信息：' + str(e))
            return JsonResponse({'status': 'error', 'message': '上传新章节失败，请重试！'}, status=500)
        except Exception as e:
            self.logger.error(self.request_path(request) + '上传新章节失败，错误信息：' + str(e))
            return JsonResponse({'status': 'error', 'message': '上传新章节失败，请重试！'}, status=500)

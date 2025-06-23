import re
from bs4 import BeautifulSoup
import ahocorasick
from transformers import pipeline
import os
from django.conf import settings
from pathlib import Path

class IndependentContentScanner:
    """三级独立内容扫描器"""

    def __init__(self):
        # 第一级：HTML净化配置
        self.allowed_tags = {'p', 'br', 'strong', 'em', 'u', 'ol', 'ul', 'li','img','video','b','h1','h2','h3','h4','h5','i','strong'}
        self.allowed_attrs = {'style', 'class'}

        # 第二级：敏感词检测初始化
        self.word_path = Path(__file__).parent.absolute()
        self.word_path=os.path.join(self.word_path,'word.txt')
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

import unittest
from unittest.mock import patch

class TestIndependentContentScanner(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        # 创建临时测试用的敏感词文件
        cls.test_word_path = "test_word.txt"
        with open(cls.test_word_path, "w", encoding="utf-8") as f:
            f.write("[赌博网站]\n[赌球 赌马]\n[色情内容]\n[政治敏感词]")

        # 初始化测试实例（注入测试词库路径）
        cls.scanner = IndependentContentScanner()
        cls.scanner.word_path = cls.test_word_path
        cls.scanner.sensitive_phrases = cls.scanner._load_phrases()
        cls.scanner.ac_matcher = cls.scanner._build_phrase_matcher()

    @classmethod
    def tearDownClass(cls):
        # 清理测试文件
        import os
        os.remove(cls.test_word_path)

    # ===== 第一级：HTML安全测试 =====
    def test_html_safety_check_safe(self):
        """测试安全HTML内容"""
        html = "<p>正常内容 <strong>加粗</strong></p>"
        is_safe, cleaned = self.scanner.html_safety_check(html)
        self.assertTrue(is_safe)
        self.assertIn("<strong>加粗</strong>", cleaned)

    def test_html_safety_check_unsafe_tag(self):
        """测试危险HTML标签"""
        html = "<script>alert(1)</script><p>内容</p>"
        is_safe, _ = self.scanner.html_safety_check(html)
        self.assertFalse(is_safe)

    def test_html_safety_check_unsafe_attr(self):
        """测试危险HTML属性"""
        html = '<p onclick="alert(1)">内容</p>'
        is_safe, cleaned = self.scanner.html_safety_check(html)
        self.assertTrue(is_safe)  # 标签允许但属性会被移除
        self.assertNotIn("onclick", cleaned)

    # ===== 第二级：敏感词测试 =====
    def test_phrase_check_clean(self):
        """测试无敏感词内容"""
        text = "这是一段正常的文本内容"
        is_clean, found = self.scanner.phrase_check(text)
        self.assertTrue(is_clean)
        self.assertEqual(len(found), 0)

    def test_phrase_check_single_phrase(self):
        """测试匹配独立短语"""
        text = "这个赌博网站应该被封禁"
        is_clean, found = self.scanner.phrase_check(text)
        self.assertFalse(is_clean)
        self.assertIn("赌博网站", found)

    def test_phrase_check_multi_word_phrase(self):
        """测试多词短语匹配"""
        text = "他喜欢赌球和赌马"
        is_clean, found = self.scanner.phrase_check(text)
        self.assertFalse(is_clean)
        self.assertIn("赌球 赌马", found[0])  # 整个中括号内容作为单个短语匹配

    # ===== 第三级：AI审核测试 =====
    @patch('transformers.pipeline')
    def test_ai_review_positive(self, mock_pipeline):
        """测试AI识别违规内容"""
        mock_pipeline.return_value = [{'label': 'POSITIVE', 'score': 0.95}]
        status, confidence = self.scanner.ai_review("测试文本")
        self.assertEqual(status, 0)
        self.assertGreater(confidence, 0.9)

    @patch('transformers.pipeline')
    def test_ai_review_negative(self, mock_pipeline):
        """测试AI通过安全内容"""
        mock_pipeline.return_value = [{'label': 'NEGATIVE', 'score': 0.98}]
        status, confidence = self.scanner.ai_review("测试文本")
        self.assertEqual(status, 1)
        self.assertGreater(confidence, 0.9)

    @patch('transformers.pipeline')
    def test_ai_review_uncertain(self, mock_pipeline):
        """测试AI不确定内容"""
        mock_pipeline.return_value = [{'label': 'NEUTRAL', 'score': 0.5}]
        status, _ = self.scanner.ai_review("测试文本")
        self.assertEqual(status, 2)

    # ===== 综合流程测试 =====
    def test_full_process_reject_by_html(self):
        """测试HTML检查不通过流程"""
        html = "<script>危险代码</script><p>内容</p>"
        status, _, msg = self.scanner._strict_review_flow(html)
        self.assertEqual(status, 0)
        self.assertIn("HTML内容不安全", msg)

    def test_full_process_reject_by_phrase(self):
        """测试敏感词检查不通过流程"""
        html = "<p>这个赌博网站很危险</p>"
        status, _, msg = self.scanner._strict_review_flow(html)
        self.assertEqual(status, 0)
        self.assertIn("赌博网站", msg)

    @patch('transformers.pipeline')
    def test_full_process_approve(self, mock_pipeline):
        """测试三级全部通过流程"""
        mock_pipeline.return_value = [{'label': 'NEGATIVE', 'score': 0.99}]
        html = "<p>完全合规的安全内容</p>"
        status, _, msg = self.scanner._strict_review_flow(html)
        self.assertEqual(status, 1)
        self.assertIn("审核通过", msg)

if __name__ == '__main__':
    unittest.main()
import torch
import torch.nn as nn
import torch.optim as optim
from torch.utils.data import DataLoader, Dataset
from docx import Document
import os
import re

# 读取敏感词汇
sq_txt_path = "色情类.txt"
ad_txt_path = "广告.txt"
novel_work_path = "未知之地·起源.docx"

def load_sensitive_words(file_path):
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read().replace('\n', ',')  # 将换行符替换为逗号
        words = content.strip().split(',')  # 按逗号分隔
        return [word.strip() for word in words if word.strip()]  # 去除空白字符

# 加载敏感词汇
sq_sensitive_words = load_sensitive_words(sq_txt_path)
ad_sensitive_words = load_sensitive_words(ad_txt_path)
sensitive_words = sq_sensitive_words + ad_sensitive_words
print(f"总敏感词数量: {len(sensitive_words)}")

# 从Word文档中读取文本
def load_text_from_docx(docx_path):
    document = Document(docx_path)
    full_text = []
    for paragraph in document.paragraphs:
        full_text.append(paragraph.text.strip())  # 获取每一段的文本并去除首尾空格
    return " ".join(full_text)  # 将所有段落拼接为一个大的文本字符串

# 读取 Word 文档中的正常文本作为正样本
normal_text = load_text_from_docx(novel_work_path)

# 文本预处理：去除标点符号、数字、特殊字符，并转换为小写
def preprocess_text(text):
    text = text.lower()  # 转换为小写
    text = re.sub(r'[^\w\s]', '', text)  # 移除标点符号
    return text

# 简单数据集定义
class TextDataset(Dataset):
    def __init__(self, texts, labels):
        self.texts = texts
        self.labels = labels

    def __len__(self):
        return len(self.texts)

    def __getitem__(self, idx):
        return self.texts[idx], self.labels[idx]

# 简单的词袋模型实现
class SimpleModel(nn.Module):
    def __init__(self, vocab_size):
        super(SimpleModel, self).__init__()
        self.fc = nn.Linear(vocab_size, 1)  # 简单的线性层输出0或1

    def forward(self, x):
        return torch.sigmoid(self.fc(x))  # 使用sigmoid将输出限制在0到1之间

# 生成词袋表示
def create_bow(texts, vocab):
    vocab_map = {word: i for i, word in enumerate(vocab)}
    bow_vectors = []

    for text in texts:
        vector = torch.zeros(len(vocab))
        for word in text.split():
            if word in vocab_map:
                vector[vocab_map[word]] += 1
        bow_vectors.append(vector)

    return torch.stack(bow_vectors)

# 使用 GPU 加速（如果可用）
device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')

# 训练数据准备
preprocessed_sensitive_text = preprocess_text(" ".join(sensitive_words))
sensitive_texts = [preprocessed_sensitive_text]  # 将所有敏感词组合为一段文本作为负样本

preprocessed_normal_text = preprocess_text(normal_text)
normal_texts = [preprocessed_normal_text]  # 使用从 Word 文档中加载的正常文本作为正样本

texts = sensitive_texts + normal_texts

# 标签：敏感文本为1，正常文本为0
labels = [1] * len(sensitive_texts) + [0] * len(normal_texts)

# 词汇表为所有敏感词
vocab = sensitive_words

# 生成词袋表示
bow_vectors = create_bow(texts, vocab).to(device)

# 创建数据集
dataset = TextDataset(bow_vectors, torch.tensor(labels, dtype=torch.float32).to(device))
dataloader = DataLoader(dataset, batch_size=1, shuffle=True)

# 初始化模型、损失函数和优化器
model = SimpleModel(len(vocab)).to(device)
criterion = nn.BCELoss()  # 二元交叉熵损失函数
optimizer = optim.Adam(model.parameters(), lr=0.000005)  # 减小学习率

# 模型训练
num_epochs = 100  # 增加训练轮数
for epoch in range(num_epochs):
    for inputs, label in dataloader:
        inputs, label = inputs.to(device), label.to(device)

        # 前向传播
        output = model(inputs)
        loss = criterion(output, label.unsqueeze(1))

        # 反向传播
        optimizer.zero_grad()
        loss.backward()
        optimizer.step()

    print(f"Epoch {epoch + 1}/{num_epochs}, Loss: {loss.item():.4f}")

# 测试模型
test_text = "今天的天内射好，颜射，。"  # 正常文本
test_text = preprocess_text(normal_text)  # 预处理测试文本
test_vector = create_bow([test_text], vocab).to(device)
prediction = model(test_vector).item()

print(f"测试文本: {test_text}")
print(f"预测概率: {prediction:.4f}")
print(f"预测结果: {'包含敏感词' if prediction > 0.5 else '无敏感词'}")

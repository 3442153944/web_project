import torch
import torch.nn as nn
import torch.nn.functional as F
from torchvision import transforms
from PIL import Image, ImageOps, UnidentifiedImageError
from io import BytesIO


class SimpleCNN(nn.Module):
    def __init__(self):
        super(SimpleCNN, self).__init__()
        self.conv1 = nn.Conv2d(3, 32, kernel_size=3, stride=1, padding=1)
        self.pool = nn.MaxPool2d(kernel_size=2, stride=2, padding=0)
        self.conv2 = nn.Conv2d(32, 64, kernel_size=3, stride=1, padding=1)
        self.conv3 = nn.Conv2d(64, 128, kernel_size=3, stride=1, padding=1)
        self.fc1 = nn.Linear(128 * 128 * 128, 2)  # 2分类，R18:1，非R18:0

    def forward(self, x):
        x = self.pool(F.relu(self.conv1(x)))
        x = self.pool(F.relu(self.conv2(x)))
        x = self.pool(F.relu(self.conv3(x)))
        x = x.view(-1, 128 * 128 * 128)
        x = self.fc1(x)
        return x


class ResizeAndPadToSquare:
    def __init__(self, max_size=1024):
        self.max_size = max_size

    def __call__(self, img):
        try:
            width, height = img.size
            if max(width, height) > self.max_size:
                scale = self.max_size / max(width, height)
                new_size = (int(width * scale), int(height * scale))
                img = img.resize(new_size, Image.Resampling.LANCZOS)
            else:
                new_size = (width, height)

            pad_width = (self.max_size - new_size[0]) // 2
            pad_height = (self.max_size - new_size[1]) // 2
            padding = (
            pad_width, pad_height, self.max_size - new_size[0] - pad_width, self.max_size - new_size[1] - pad_height)
            img = ImageOps.expand(img, padding, fill=0)

            return img
        except Exception as e:
            print(f"Error resizing and padding image: {e}")
            return None


class ImageClassifier:
    def __init__(self, model_path='H:/web_project/ai_model/final_model.pth'):
        self.device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
        self.model = SimpleCNN()
        self.model.load_state_dict(torch.load(model_path))  # 加载模型权重
        self.model.to(self.device)
        self.model.eval()  # 设置为评估模式

    def process_image_from_bytes(self, image_bytes):
        try:
            image = Image.open(BytesIO(image_bytes))  # 从比特流中加载图像

            # 确保图像是 RGB 模式
            if image.mode != 'RGB':
                image = image.convert('RGB')

            transform = transforms.Compose([
                ResizeAndPadToSquare(max_size=1024),  # 调整大小并填充
                transforms.ToTensor(),  # 转换为Tensor
            ])
            input_tensor = transform(image).unsqueeze(0).to(self.device)  # 添加batch维度
            with torch.no_grad():  # 推理时不计算梯度
                output = self.model(input_tensor)
                probability = torch.sigmoid(output[:, 1]).item()  # 将输出转换为 R18 概率
                return probability  # 返回 R18 概率
        except UnidentifiedImageError:
            print("Error: Cannot identify image from bytes input")
            return None
        except Exception as e:
            print(f"Error processing image from bytes: {e}")
            return None

    def classify_r18(self, image_bytes):
        return self.process_image_from_bytes(image_bytes)


'''
# 测试用法
if __name__ == '__main__':
    classifier = ImageClassifier()
    with open("G:/p站/111665981_p0.jpg", "rb") as f:  # 将此处的"test_image.jpg"替换为你的文件路径
        image_bytes = f.read()  # 读取图像为比特流

    result = classifier.classify_r18(image_bytes)
    print(result)
    if result is not None:
        if result <=0.50:
            print("The image is classified as R18.")
        elif result >0.75:
            print("The image is not classified as R18.")
        else:
            print("不确定人工审核",result)
    else:
        print("Failed to classify the image.")
'''

import torch
import torch.nn as nn
import torch.optim as optim
from torchvision import datasets, transforms
import torch.nn.functional as F
from PIL import Image, ImageOps, UnidentifiedImageError
import os
import time
import psutil
import torch.cuda as cuda
import matplotlib.pyplot as plt
import multiprocessing as mp


# 设置路径
train_set = 'H:/img_data_set/test_set/'
validation_set = 'H:/img_data_set/validation_set/'
test_set = 'H:/img_data_set/test_set/'
model_temp_path = "G:/ai_model/"

# 检查是否使用 GPU
device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
print(f'Using device: {device}')

# 自定义图像预处理类
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
            padding = (pad_width, pad_height, self.max_size - new_size[0] - pad_width, self.max_size - new_size[1] - pad_height)
            img = ImageOps.expand(img, padding, fill=0)

            return img
        except Exception as e:
            print(f"Error resizing and padding image: {e}")
            return None

# 自定义图像加载器，添加异常处理
def pil_loader(path):
    try:
        with open(path, 'rb') as f:
            img = Image.open(f)
            return img.convert('RGB')
    except UnidentifiedImageError:
        print(f"Cannot identify image file {path}")
        return None
    except FileNotFoundError:
        print(f"File not found: {path}")
        return None
    except Exception as e:
        print(f"Error loading image file {path}: {e}")

# 重写 ImageFolder 的 default_loader
datasets.folder.default_loader = pil_loader

# 创建数据预处理的 transform，加入数据增强
transform = transforms.Compose([
    ResizeAndPadToSquare(max_size=1024),  # 保持原有的等比缩放和填充
    transforms.RandomHorizontalFlip(),  # 随机水平翻转
    #随机垂直翻转
    transforms.RandomVerticalFlip(),
    #transforms.RandomRotation(degrees=15),  # 随机旋转（最多15度）
    #transforms.RandomResizedCrop(size=1024, scale=(0.8, 1.0)),  # 随机裁剪
    #transforms.ColorJitter(brightness=0.2, contrast=0.2, saturation=0.2, hue=0.1),  # 颜色抖动
    transforms.ToTensor(),  # 转为 Tensor
])

# 数据加载
def safe_loader(dataset, batch_size=6, num_workers=0):  # 将 num_workers 设置为 0
    """加载数据集，并处理数据加载中的异常"""
    try:
        # 当 num_workers = 0 时，禁用 prefetch_factor
        loader = torch.utils.data.DataLoader(
            dataset,
            batch_size=batch_size,
            shuffle=True,
            num_workers=num_workers,  # 设置为0禁用多进程数据加载
            pin_memory=True,  # 固定在内存中以加速传输
            prefetch_factor=None if num_workers == 0 else 2  # 根据 num_workers 设置 prefetch_factor
        )
        return loader
    except Exception as e:
        print(f"Error creating data loader: {e}")
        return None


train_dataset = datasets.ImageFolder(root=train_set, transform=transform)
train_loader = safe_loader(train_dataset, batch_size=12)  # 根据显存情况调整batch size

validation_dataset = datasets.ImageFolder(root=validation_set, transform=transform)
validation_loader = safe_loader(validation_dataset, batch_size=12)

test_dataset = datasets.ImageFolder(root=test_set, transform=transform)
test_loader = safe_loader(test_dataset, batch_size=12)

# 构建模型
class SimpleCNN(nn.Module):
    def __init__(self):
        super(SimpleCNN, self).__init__()
        self.conv1 = nn.Conv2d(3, 32, kernel_size=3, stride=1, padding=1)
        self.pool = nn.MaxPool2d(kernel_size=2, stride=2, padding=0)
        self.conv2 = nn.Conv2d(32, 64, kernel_size=3, stride=1, padding=1)
        self.conv3 = nn.Conv2d(64, 128, kernel_size=3, stride=1, padding=1)

        # 计算全连接层的输入大小
        self.fc1 = nn.Linear(128 * 128 * 128, 2)  # 根据修改后的卷积层大小进行调整

    def forward(self, x):
        x = self.pool(F.relu(self.conv1(x)))
        x = self.pool(F.relu(self.conv2(x)))
        x = self.pool(F.relu(self.conv3(x)))
        x = x.view(-1, 128 * 128 * 128)  # 更新全连接层输入
        x = self.fc1(x)
        return x

# 初始化权重
def init_weights(m):
    if isinstance(m, nn.Conv2d) or isinstance(m, nn.Linear):
        nn.init.kaiming_normal_(m.weight)

# 创建模型，加载已有模型权重
model = SimpleCNN().to(device)
model.apply(init_weights)

model_path = os.path.join(model_temp_path, 'final_model.pth')
if os.path.exists(model_path):
    model.load_state_dict(torch.load(model_path))
    print(f'Loaded model from {model_path}')
else:
    print(f'No pre-trained model found at {model_path}, training from scratch.')

criterion = nn.CrossEntropyLoss()
optimizer = optim.Adam(model.parameters(), lr=0.0001)  # 调整学习率
scheduler = torch.optim.lr_scheduler.StepLR(optimizer, step_size=5, gamma=0.1)  # 学习率调度器

# 启用半精度训练的设置
scaler = torch.amp.GradScaler(device='cuda')  # 修改梯度缩放器

# 训练和验证 loss 曲线
train_losses = []
validation_losses = []

# 验证模型时增加损失和正确率的输出和记录
if __name__ == '__main__':
    mp.set_start_method('spawn')  # Windows上使用'spawn'
    # 打开文件以记录 loss 和 accuracy
    with open(os.path.join(model_temp_path, 'loss_and_accuracy.txt'), 'w') as loss_file:
        # 训练模型
        for epoch in range(10):
            model.train()
            epoch_loss = 0.0  # 记录每个 epoch 的总训练损失
            epoch_start_time = time.time()

            for batch_idx, (images, labels) in enumerate(train_loader):
                batch_start_time = time.time()

                # 监控内存使用
                memory_info = psutil.virtual_memory()
                print(f'Memory usage: {memory_info.percent}%')

                try:
                    # 将数据传输到GPU
                    images, labels = images.to(device), labels.to(device)

                    optimizer.zero_grad()

                    # 混合精度训练：前向传播和计算损失
                    with torch.cuda.amp.autocast():
                        outputs = model(images)
                        loss = criterion(outputs, labels)

                    # 使用梯度缩放器进行反向传播和优化器步骤
                    scaler.scale(loss).backward()
                    scaler.step(optimizer)
                    scaler.update()

                    epoch_loss += loss.item()

                    print(f'Epoch [{epoch + 1}/10], Batch [{batch_idx + 1}/{len(train_loader)}], '
                          f'Loss: {loss.item():.4f}, Time per batch: {time.time() - batch_start_time:.2f}s')

                    if device.type == 'cuda':
                        print(f'GPU Memory Allocated: {cuda.memory_allocated() / 1024**3:.2f} GB')
                        print(f'GPU Memory Cached: {cuda.memory_reserved() / 1024**3:.2f} GB')
                except Exception as e:
                    print(f"Error processing batch {batch_idx + 1}: {e}")
                    continue

            avg_train_loss = epoch_loss / len(train_loader)
            train_losses.append(avg_train_loss)
            loss_file.write(f'Epoch [{epoch + 1}/10], Avg Train Loss: {avg_train_loss:.4f}, Time: {time.time() - epoch_start_time:.2f}s\n')
            print(f'Epoch [{epoch + 1}/10] completed in {time.time() - epoch_start_time:.2f}s')

            # 验证模型
            model.eval()
            validation_loss = 0.0
            correct = 0
            total = 0
            with torch.no_grad():
                for images, labels in validation_loader:
                    images, labels = images.to(device), labels.to(device)

                    with torch.cuda.amp.autocast():  # 混合精度验证
                        outputs = model(images)
                        loss = criterion(outputs, labels)
                        validation_loss += loss.item()

                        # 计算正确率
                        _, predicted = torch.max(outputs, 1)
                        total += labels.size(0)
                        correct += (predicted == labels).sum().item()

            avg_validation_loss = validation_loss / len(validation_loader)
            validation_accuracy = correct / total  # 计算准确率

            validation_losses.append(avg_validation_loss)  # 保存验证loss
            loss_file.write(f'Epoch [{epoch + 1}/10], Avg Validation Loss: {avg_validation_loss:.4f}, '
                            f'Accuracy: {validation_accuracy:.4f}\n')
            print(f'Validation Loss: {avg_validation_loss:.4f}, Accuracy: {validation_accuracy:.4f}')

            scheduler.step()  # 更新学习率

        # 保存模型
        torch.save(model.state_dict(), model_path)
        print(f'Model saved to {model_path}')

# 绘制训练和验证 loss 曲线
plt.plot(train_losses, label='Training Loss')
plt.plot(validation_losses, label='Validation Loss')
plt.xlabel('Epoch')
plt.ylabel('Loss')
plt.legend()
plt.savefig(os.path.join(model_temp_path, 'loss_curve.png'))
plt.show()


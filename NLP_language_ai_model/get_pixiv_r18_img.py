import cv2
import numpy as np
import pyautogui
import time
import gc

# 保存按钮图像路径
save_btn_img_path = 'H:/web_project/djangoWebServer/template_img/save.png'


def locate_and_click_button(button_image_path):
    # 截图全屏
    screenshot = pyautogui.screenshot()
    screenshot_np = np.array(screenshot)
    screenshot_gray = cv2.cvtColor(screenshot_np, cv2.COLOR_BGR2GRAY)

    # 读取按钮图像
    button_image = cv2.imread(button_image_path, cv2.IMREAD_GRAYSCALE)

    # 使用模板匹配来查找按钮
    result = cv2.matchTemplate(screenshot_gray, button_image, cv2.TM_CCOEFF_NORMED)
    min_val, max_val, min_loc, max_loc = cv2.minMaxLoc(result)

    # 设置阈值，匹配度越高，可能性越大
    threshold = 0.8
    if max_val >= threshold:
        # 获取按钮位置
        button_w, button_h = button_image.shape[::-1]
        button_x, button_y = max_loc
        button_center_x = button_x + button_w // 2
        button_center_y = button_y + button_h // 2

        # 模拟点击操作
        pyautogui.click(button_center_x, button_center_y)
        print(f"Button clicked at ({button_center_x}, {button_center_y})")
    else:
        print("Button not found")


def main():
    while True:
        locate_and_click_button(save_btn_img_path)

        # 等待一秒钟
        time.sleep(1)

        # 清理内存
        gc.collect()


if __name__ == "__main__":
    main()

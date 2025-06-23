import pygame
import numpy as np

# 初始化参数
WIDTH, HEIGHT = 400, 300
DAMPING = 0.99  # 衰减系数

# 初始化波动高度矩阵
u = np.zeros((HEIGHT, WIDTH), dtype=np.float32)
u_prev = np.zeros_like(u)

def update_wave():
    global u, u_prev
    # 计算拉普拉斯近似
    laplacian = (
        np.roll(u, 1, axis=0) +  # 上
        np.roll(u, -1, axis=0) +  # 下
        np.roll(u, 1, axis=1) +  # 左
        np.roll(u, -1, axis=1) -  # 右
        4 * u
    )
    u_new = (2 * u - u_prev + 0.2 * laplacian) * DAMPING

    # 边界反射处理（固定边界）
    u_new[0, :] = 0
    u_new[-1, :] = 0
    u_new[:, 0] = 0
    u_new[:, -1] = 0

    u_prev = u
    u = u_new

def disturb(x, y, radius=5, magnitude=1.0):
    for dy in range(-radius, radius + 1):
        for dx in range(-radius, radius + 1):
            nx, ny = x + dx, y + dy
            if 0 <= nx < WIDTH and 0 <= ny < HEIGHT:
                dist = dx * dx + dy * dy
                if dist <= radius * radius:
                    # 高斯扰动
                    u[ny, nx] += magnitude * np.exp(-dist / (radius * radius / 2))

def main():
    pygame.init()
    screen = pygame.display.set_mode((WIDTH, HEIGHT))
    pygame.display.set_caption("Water Ripple Simulation")

    clock = pygame.time.Clock()

    running = True
    while running:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                running = False
            elif event.type == pygame.MOUSEBUTTONDOWN:
                mx, my = pygame.mouse.get_pos()
                disturb(mx, my, radius=8, magnitude=5.0)

        update_wave()

        # 转换水面高度为颜色显示（灰度）
        img = np.clip((u + 1) * 127.5, 0, 255).astype(np.uint8)
        surf = pygame.surfarray.make_surface(np.stack([img]*3, axis=-1))

        screen.blit(surf, (0, 0))
        pygame.display.flip()
        clock.tick(60)

    pygame.quit()

if __name__ == '__main__':
    main()

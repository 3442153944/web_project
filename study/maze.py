import pygame
import sys
import time
import numpy as np
from collections import deque
import heapq


class Maze:
    def __init__(self):
        # 迷宫定义：0=路径, 1=墙, 2=奖励点(权重1), 3=奖励点(权重2)
        self.maze = [
            [1, 0, 1, 1, 1, 1, 1, 1, 1, 1],
            [1, 2, 0, 0, 0, 0, 0, 0, 0, 1],
            [1, 0, 1, 0, 1, 1, 1, 1, 0, 1],
            [1, 0, 1, 0, 0, 0, 0, 1, 0, 1],
            [1, 0, 1, 0, 1, 0, 0, 1, 0, 1],
            [1, 0, 0, 0, 1, 3, 1, 1, 0, 0],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
        ]
        self.rows = len(self.maze)
        self.cols = len(self.maze[0])
        self.cell_size = 40
        self.width = self.cols * self.cell_size
        self.height = self.rows * self.cell_size
        self.current_pos = (1, 0)  # 起点位置
        pygame.init()
        self.screen = pygame.display.set_mode((self.width, self.height))
        pygame.display.set_caption("带奖励点的迷宫寻路")
        self.clock = pygame.time.Clock()

        # 颜色定义
        self.COLOR_WALL = (0, 0, 0)
        self.COLOR_PATH = (255, 255, 255)
        self.COLOR_CURRENT = (255, 0, 0)
        self.COLOR_VISITED = (100, 255, 100)
        self.COLOR_REWARD1 = (255, 215, 0)  # 金色 - 奖励点1
        self.COLOR_REWARD2 = (255, 140, 0)  # 橙色 - 奖励点2
        self.COLOR_EXIT = (0, 0, 255)  # 蓝色 - 出口

        # 奖励点信息
        self.reward_points = []
        self.collected_rewards = set()
        self.exit_pos = None

        # 初始化奖励点位置
        for y in range(self.rows):
            for x in range(self.cols):
                if self.maze[y][x] == 2 or self.maze[y][x] == 3:
                    self.reward_points.append((x, y, self.maze[y][x]))

        print(f"找到 {len(self.reward_points)} 个奖励点")

    def draw_maze(self, visited=None, path=None):
        """绘制迷宫，包括奖励点和路径"""
        for y in range(self.rows):
            for x in range(self.cols):
                rect = pygame.Rect(x * self.cell_size, y * self.cell_size,
                                   self.cell_size, self.cell_size)

                # 绘制不同元素
                if (x, y) == self.current_pos:
                    pygame.draw.rect(self.screen, self.COLOR_CURRENT, rect)
                elif path and (x, y) in path:
                    pygame.draw.rect(self.screen, (200, 200, 255), rect)
                elif visited and (x, y) in visited:
                    pygame.draw.rect(self.screen, self.COLOR_VISITED, rect)
                elif self.maze[y][x] == 1:
                    pygame.draw.rect(self.screen, self.COLOR_WALL, rect)
                elif self.maze[y][x] == 2:
                    pygame.draw.rect(self.screen, self.COLOR_REWARD1, rect)
                elif self.maze[y][x] == 3:
                    pygame.draw.rect(self.screen, self.COLOR_REWARD2, rect)
                elif self.exit_pos and (x, y) == self.exit_pos:
                    pygame.draw.rect(self.screen, self.COLOR_EXIT, rect)
                else:
                    pygame.draw.rect(self.screen, self.COLOR_PATH, rect)

                # 绘制网格
                pygame.draw.rect(self.screen, (200, 200, 200), rect, 1)

    def move_position(self, new_pos):
        """移动位置并收集奖励点"""
        x, y = new_pos
        if 0 <= x < self.cols and 0 <= y < self.rows:
            if self.maze[y][x] != 1:  # 可以移动到非墙位置
                self.current_pos = new_pos

                # 检查是否收集到奖励点
                if (x, y) in [p[:2] for p in self.reward_points] and (x, y) not in self.collected_rewards:
                    reward_value = self.maze[y][x]
                    print(f"收集到奖励点({x}, {y})，权重: {reward_value}")
                    self.collected_rewards.add((x, y))

                    # 检查是否收集完所有奖励点
                    if len(self.collected_rewards) == len(self.reward_points):
                        print("已收集所有奖励点！")
                        self.find_exit_position()

    def find_exit_position(self):
        """在收集完所有奖励点后找到出口位置"""
        # 寻找离当前位置最近的边界点作为出口
        x, y = self.current_pos
        candidates = []

        # 检查上边界
        for i in range(self.cols):
            if self.maze[0][i] == 0:
                candidates.append((i, 0))

        # 检查下边界
        for i in range(self.cols):
            if self.maze[self.rows - 1][i] == 0:
                candidates.append((i, self.rows - 1))

        # 检查左边界
        for i in range(self.rows):
            if self.maze[i][0] == 0:
                candidates.append((0, i))

        # 检查右边界
        for i in range(self.rows):
            if self.maze[i][self.cols - 1] == 0:
                candidates.append((self.cols - 1, i))

        # 选择最近的出口
        min_dist = float('inf')
        best_exit = None
        for candidate in candidates:
            dist = abs(x - candidate[0]) + abs(y - candidate[1])
            if dist < min_dist:
                min_dist = dist
                best_exit = candidate

        if best_exit:
            self.exit_pos = best_exit
            print(f"出口出现在位置: {best_exit}")
        else:
            print("未找到出口位置")

    def bfs(self, start, end):
        """使用BFS找到两点之间的最短路径"""
        # 方向：上、下、左、右
        directions = [(0, -1), (0, 1), (-1, 0), (1, 0)]

        # 初始化队列和访问数组
        queue = deque([start])
        visited = {start}
        parent = {}

        while queue:
            current = queue.popleft()

            # 如果到达终点
            if current == end:
                # 回溯路径
                path = []
                while current != start:
                    path.append(current)
                    current = parent[current]
                path.reverse()
                return path

            # 探索四个方向
            for dx, dy in directions:
                nx, ny = current[0] + dx, current[1] + dy
                next_pos = (nx, ny)

                # 检查是否在迷宫范围内且不是墙
                if (0 <= nx < self.cols and 0 <= ny < self.rows and
                        self.maze[ny][nx] != 1 and next_pos not in visited):
                    queue.append(next_pos)
                    visited.add(next_pos)
                    parent[next_pos] = current

        # 没有找到路径
        return None

    def calculate_distances(self):
        """计算所有奖励点之间的距离"""
        # 创建位置列表：起点 + 所有奖励点
        positions = [self.current_pos] + [p[:2] for p in self.reward_points]
        n = len(positions)

        # 初始化距离矩阵
        dist_matrix = [[float('inf')] * n for _ in range(n)]

        # 计算所有点对之间的距离
        for i in range(n):
            for j in range(n):
                if i == j:
                    dist_matrix[i][j] = 0
                else:
                    path = self.bfs(positions[i], positions[j])
                    if path:
                        dist_matrix[i][j] = len(path)

        return positions, dist_matrix

    def tsp_with_rewards(self):
        """使用状态压缩动态规划解决带奖励点的TSP问题"""
        # 获取位置和距离矩阵
        positions, dist_matrix = self.calculate_distances()
        n = len(positions)
        reward_count = len(self.reward_points)

        # 状态压缩DP：dp[mask][i] 表示访问mask集合中的奖励点，最后在位置i的最小路径
        # mask: 二进制掩码表示访问了哪些奖励点（0表示起点，1..k表示奖励点）
        dp = [[float('inf')] * n for _ in range(1 << n)]
        path = [[None] * n for _ in range(1 << n)]

        # 初始化：从起点出发
        dp[1][0] = 0  # mask=1 (只有起点被访问), 最后在起点

        # 动态规划
        for mask in range(1 << n):
            for i in range(n):
                if dp[mask][i] == float('inf'):
                    continue

                for j in range(n):
                    # 如果j已经在mask中，跳过
                    if mask & (1 << j):
                        continue

                    # 新状态：访问j点
                    new_mask = mask | (1 << j)
                    new_dist = dp[mask][i] + dist_matrix[i][j]

                    # 更新最短路径
                    if new_dist < dp[new_mask][j]:
                        dp[new_mask][j] = new_dist
                        path[new_mask][j] = i

        # 找到访问所有点的最短路径
        full_mask = (1 << n) - 1
        min_dist = float('inf')
        best_end = -1

        for i in range(n):
            if dp[full_mask][i] < min_dist:
                min_dist = dp[full_mask][i]
                best_end = i

        if min_dist == float('inf'):
            print("无法访问所有奖励点")
            return None

        # 回溯路径
        current_mask = full_mask
        current_pos = best_end
        order = [current_pos]

        while current_mask != 1:  # 直到只剩起点
            prev_pos = path[current_mask][current_pos]
            order.append(prev_pos)
            current_mask = current_mask ^ (1 << current_pos)
            current_pos = prev_pos

        # 反转顺序：从起点开始
        order.reverse()

        print(f"最优访问顺序: {order}")
        print(f"最短路径长度: {min_dist}")

        # 构建完整路径
        full_path = []
        for i in range(len(order) - 1):
            segment = self.bfs(positions[order[i]], positions[order[i + 1]])
            if segment:
                # 避免重复添加点
                if full_path:
                    full_path.extend(segment[1:])
                else:
                    full_path.extend(segment)

        return full_path

    def auto_find_path(self):
        """自动寻找并移动路径"""
        # 找到最优路径
        path = self.tsp_with_rewards()

        if not path:
            print("未找到有效路径")
            return

        # 移动到出口
        if self.exit_pos:
            exit_path = self.bfs(path[-1], self.exit_pos)
            if exit_path:
                path.extend(exit_path[1:])  # 避免重复点

        # 绘制路径动画
        visited = set()
        for step in path:
            self.clock.tick(10)  # 控制移动速度
            for event in pygame.event.get():
                if event.type == pygame.QUIT:
                    pygame.quit()
                    sys.exit()

            # 移动到下一步
            self.move_position(step)
            visited.add(step)

            # 绘制迷宫
            self.screen.fill((255, 255, 255))
            self.draw_maze(visited, path)
            pygame.display.flip()

        print("路径完成!")

    def run(self):
        """主循环"""
        while True:
            self.clock.tick(10)
            for event in pygame.event.get():
                if event.type == pygame.QUIT:
                    pygame.quit()
                    sys.exit()
                elif event.type == pygame.KEYDOWN:
                    if event.key == pygame.K_SPACE:
                        self.auto_find_path()

            # 键盘控制移动
            keys = pygame.key.get_pressed()
            x, y = self.current_pos
            if keys[pygame.K_UP]:
                self.move_position((x, y - 1))
            elif keys[pygame.K_DOWN]:
                self.move_position((x, y + 1))
            elif keys[pygame.K_LEFT]:
                self.move_position((x - 1, y))
            elif keys[pygame.K_RIGHT]:
                self.move_position((x + 1, y))

            # 绘制迷宫
            self.screen.fill((255, 255, 255))
            self.draw_maze()
            pygame.display.flip()


# 启动
if __name__ == "__main__":
    maze = Maze()
    maze.run()
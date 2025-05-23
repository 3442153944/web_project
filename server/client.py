import socket
import time
import argparse


def speed_test_client():
    # 解析参数
    parser = argparse.ArgumentParser(description='内网网速测试客户端')
    #parser.add_argument('server_ip', help='服务端IP地址')
    parser.add_argument('-t', '--time', type=int, default=10, help='测试时长（秒）')
    args = parser.parse_args()

    # 连接服务端
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        try:
            s.connect(('192.168.31.100', 1123))
            #print(f"[*] 已连接到服务端 {args.server_ip}:1123")
        except ConnectionRefusedError:
            print("[!] 连接被拒绝，请检查服务端是否运行")
            return

        # 下载测试
        print("\n=== 下载速度测试 ===")
        s.sendall(b'DOWNLOAD')
        start_time = time.time()
        total_received = 0

        # 接收数据直到测试时间结束
        while time.time() - start_time < args.time:
            data = s.recv(1024 * 1024)
            if not data:
                break
            total_received += len(data)

        # 获取最终计算结果
        s.settimeout(2)
        try:
            speed = s.recv(1024).decode()
            print(f"下载速度: {speed} Mbps")
        except socket.timeout:
            print("下载测试超时")

        # 上传测试
        print("\n=== 上传速度测试 ===")
        s.sendall(b'UPLOAD  ')
        start_time = time.time()
        total_sent = 0
        test_data = b'x' * (1024 * 1024)  # 1MB数据块

        # 持续发送数据直到测试时间结束
        while time.time() - start_time < args.time:
            try:
                sent = s.send(test_data)
                total_sent += sent
            except BrokenPipeError:
                break

        # 获取最终计算结果
        try:
            speed = s.recv(1024).decode()
            print(f"上传速度: {speed} Mbps")
        except socket.timeout:
            print("上传测试超时")


if __name__ == '__main__':
    speed_test_client()

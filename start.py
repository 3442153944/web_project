import os
import sys
import subprocess
import platform
import threading
import shutil
import time
import ctypes

ROOT_PATH = os.path.dirname(os.path.abspath(__file__))
WEB_PATH = os.path.join(ROOT_PATH, 'web')
ADMIN_PATH = os.path.join(ROOT_PATH, 'admin_panel')
SERVER_PATH = os.path.join(ROOT_PATH, 'server')
SOCKET_PATH = os.path.join(SERVER_PATH, 'tornado_server')
VENV_PATH = os.path.join(ROOT_PATH, 'venv')
REQUIREMENTS_PATH = os.path.join(SERVER_PATH, 'requirements.txt')
PYTHON_VERSION = "3.12"

UI_COMMAND = "npm run dev"
DJANGO_SERVER_COMMAND = "python manage.py runserver 2233"
TORNADO_SERVER_COMMAND = "python main.py"

def is_windows():
    return platform.system() == "Windows"

def get_python_exec():
    return os.path.join(VENV_PATH, 'Scripts' if is_windows() else 'bin', 'python')

def require_admin():
    if is_windows():
        try:
            is_admin = ctypes.windll.shell32.IsUserAnAdmin()
            if not is_admin:
                print("正在尝试以管理员权限重新启动...")
                ctypes.windll.shell32.ShellExecuteW(
                    None, "runas", sys.executable, " ".join(sys.argv), None, 1)
                sys.exit(0)
        except Exception as e:
            print(f"请求管理员权限失败：{e}")
            sys.exit(1)
    else:
        if os.geteuid() != 0:
            print("请以 root 权限重新运行此脚本（使用 sudo）")
            sys.exit(1)

def run_shell(command, cwd=None, capture_output=False):
    try:
        if not os.path.isdir(cwd):
            raise FileNotFoundError(f"工作目录不存在: {cwd}")
        result = subprocess.run(
            command, shell=True, cwd=cwd,
            check=True, stdout=subprocess.PIPE if capture_output else None,
            stderr=subprocess.PIPE if capture_output else None,
            text=True
        )
        return result.stdout.strip() if capture_output else None
    except subprocess.CalledProcessError as e:
        print(f"命令执行失败: {command}\n错误信息: {e.stderr if e.stderr else e}")
        return None
    except Exception as e:
        print(f"执行命令时发生错误: {e}")
        return None

def create_virtualenv():
    print("📦 正在创建虚拟环境...")
    py_exec = shutil.which(f"python{PYTHON_VERSION}")
    if not py_exec:
        print(f"未找到 Python {PYTHON_VERSION}，请安装后重试。")
        sys.exit(1)
    try:
        run_shell(f'"{py_exec}" -m venv "{VENV_PATH}"')
        print("虚拟环境创建完成。")
    except Exception as e:
        print(f"创建虚拟环境失败：{e}")
        sys.exit(1)

def install_requirements():
    pip_exec = os.path.join(VENV_PATH, 'Scripts' if is_windows() else 'bin', 'pip')
    if not os.path.isfile(REQUIREMENTS_PATH):
        print(f"未找到依赖文件: {REQUIREMENTS_PATH}")
        return
    print("正在安装依赖（官方源）...")
    result = run_shell(f'"{pip_exec}" install -r "{REQUIREMENTS_PATH}"', capture_output=True)
    if result and "Failed to establish a new connection" in result:
        print("官方源连接失败，尝试使用清华源...")
        result = run_shell(
            f'"{pip_exec}" install -r "{REQUIREMENTS_PATH}" -i https://pypi.tuna.tsinghua.edu.cn/simple',
            capture_output=True
        )

    if result and "ERROR:" in result:
        print(" 部分依赖安装失败，尝试逐个无版本安装...")
        try:
            with open(REQUIREMENTS_PATH) as f:
                packages = [line.strip().split('==')[0] for line in f if line.strip() and not line.startswith('#')]
            for pkg in packages:
                print(f" 安装 {pkg} ...")
                run_shell(f'"{pip_exec}" install "{pkg}"')
        except Exception as e:
            print(f" 安装依赖失败：{e}")
    print("依赖安装完成。")

def ensure_virtualenv():
    if not os.path.exists(get_python_exec()):
        create_virtualenv()
        install_requirements()

    try:
        result = run_shell(f'"{get_python_exec()}" --version', capture_output=True)
        print(f"当前虚拟环境 Python: {result}")
    except Exception:
        print("虚拟环境验证失败，无法激活。")
        sys.exit(1)

def run_in_thread(name: str, command: str, cwd: str):
    def target():
        print(f"[{name}] 启动中...")
        run_shell(command, cwd=cwd)
    t = threading.Thread(target=target, name=name)
    t.start()
    return t

def run_in_terminal(name: str, command: str, cwd: str):
    try:
        if not os.path.isdir(cwd):
            raise FileNotFoundError(f"启动失败：目录不存在 {cwd}")
        if is_windows():
            subprocess.Popen(f'start "{name}" cmd /k "{command}"', cwd=cwd, shell=True)
        else:
            subprocess.Popen([
                'gnome-terminal', '--', 'bash', '-c',
                f'cd "{cwd}" && {command}; exec bash'
            ])
        print(f"[{name}] 启动成功（新终端）")
    except Exception as e:
        print(f"[{name}] 启动失败，转为线程模式：{e}")
        run_in_thread(name, command, cwd)

def main():
    require_admin()

    if sys.prefix == sys.base_prefix:
        ensure_virtualenv()
        print("自动重启脚本以启用虚拟环境...")
        python_exec = get_python_exec()
        os.execv(python_exec, [python_exec] + sys.argv)
        return

    print("所有权限和环境准备就绪，正在启动服务...\n")

    run_in_terminal("用户前端 UI", UI_COMMAND, WEB_PATH)
    run_in_terminal("管理端 UI", UI_COMMAND, ADMIN_PATH)
    run_in_terminal("Django 后端", DJANGO_SERVER_COMMAND, SERVER_PATH)
    run_in_terminal("Tornado WebSocket", TORNADO_SERVER_COMMAND, SOCKET_PATH)

    print("\n所有服务已尝试启动，请查看各终端状态。")
    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        print("\n中断信号接收，脚本退出。")

if __name__ == "__main__":
    main()

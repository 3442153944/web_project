import os

def abbreviate_path(path):
    replacements = {
        'web_project': 'w_p',
        'djangoWebServer': 'DWS',
        'views': 'v',
        'components': 'cp',
        'vue_index_page': 'V_I_P',
        'vue_usercenter_page': 'V_C_P',
        'model': 'm',
        'vue': 'v',
        'Get': 'G',
        'get': 'G',
        'GET': 'G',
        'work': 'W',
        'info': 'i',
        'interaction': 'inter',
        'comment_section': 'c_s',
        'user_center_page': 'u_s_p',
        'user': 'u',
        'notice_control': 'N_c',
        'illustration': 'il',
        'page': 'p',
        'center':'c',
        'box':'b',
        'novel':'n',
        'file':'f',
        'content':'ct',
    }

    for old, new in replacements.items():
        path = path.replace(old, new)

    return path

def traverse_directory(root_dir):
    dirs_to_ignore = {
        '__pycache__', '.venv', 'node_modules', 'music', 'SQL_back', 'static',
        'assets', 'image', 'flask_main_Project', 'artwork', '.idea', '.git'
    }

    for root, dirs, files in os.walk(root_dir, topdown=True):
        # 排除忽略的目录
        dirs[:] = [d for d in dirs if d not in dirs_to_ignore]

        # 打印当前目录，并进行替换
        root_path = abbreviate_path(root)
        #print(f"D: {root_path}")

        for file in files:
            file_path = os.path.join(root, file)
            abbreviated_file_path = abbreviate_path(file_path)
            if not file.endswith(('.pyc', '.pyo', '.docx', '.xml', '.jpg', '.png', '.svg', '.sql','.tff','.log')):
                print(f"F: {abbreviated_file_path}")

# 调用函数，传入要遍历的根目录
traverse_directory("H:/web_project/")
print('w_p全称为：web_project，DWS全称为：djangoWebServer，v全称为：views，cp全称为：components，V_I_P全称为：vue_index_page，V_C_P全称为：vue_usercenter_page，m全称为：model')
print('ct全称为content，f全称为file，n全称为novel，c全称为：center，b全称为box，v全称为：vue，G全称为：Get/get/GET，W全称为：work，i全称为：info，inter全称为：interaction，c_s全称为：comment_section，u_s_p全称为：user_center_page，u全称为：user，N_c全称为：notice_control，il全称为：illustration，p全称为：page')

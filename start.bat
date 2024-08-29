@echo off


start "" "cmd" /k "cd /d H:\web_project\vue_login && npm run dev"
start "" "cmd" /k "cd /d H:\web_project\vue_index_page && npm run dev"
start "" "cmd" /k "cd /d H:\web_project\notice_control && npm run dev"
start "" "cmd" /k "cd /d H:\web_project\admin_panel && npm run dev"


start "" "cmd" /k "cd /d H:\web_project\djangoWebServer && python manage.py runserver 2233"
start "" "cmd" /k "cd /d H:\web_project\tornado_websocket && python main.py"

pause

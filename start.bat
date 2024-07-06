@echo off


start "" "cmd" /k "cd /d H:\web_project\vue_novel && npm run dev"
start "" "cmd" /k "cd /d H:\web_project\vue_login && npm run dev"
start "" "cmd" /k "cd /d H:\web_project\vue_index_page && npm run dev"
start "" "cmd" /k "cd /d H:\web_project\vue_illustration_page && npm run dev"
start "" "cmd" /k "cd /d H:\web_project\vue_usercenter_page && npm run dev"
start "" "cmd" /k "cd /d H:\web_project\vue_search && npm run dev"


start "" "cmd" /k "cd /d H:\web_project\djangoWebServer && python manage.py runserver 2233"
start "" "cmd" /k "cd /d H:\web_project\djangoWebServer && daphne -b 0.0.0.0 -p 2233 djangoWebServer.asgi:application"
start "" "cmd" /k "cd /d H:\web_project\tornado_websocket && python main.py"

pause

@echo off  
  
:: 第一个窗口：移动到E:\web_preject\vue_novel并执行npm run dev  
start "" "cmd" /k "cd /d E:\web_preject\vue_novel && npm run dev"  
  
:: 第二个窗口：移动到E:\web_preject\vue_login并执行npm run dev  
start "" "cmd" /k "cd /d E:\web_preject\vue_login && npm run dev"  
  
:: 批处理文件执行完毕，不关闭此窗口（如果需要的话）  
:: 可以根据需要添加 pause 命令或其他命令  
pause
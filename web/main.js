import {app,BrowserWindow,Menu,dialog} from 'electron'
import path from 'path'

let win

function createWindow() {
    // 创建一个浏览器窗口
    win = new BrowserWindow({
        width: 1200,
        height: 800,
        icon:"./favicon.png",
        webPreferences: {
            nodeIntegration: true, // 使得页面能够访问 Node.js API
            contextIsolation: false, // 禁用上下文隔离
        }
    })

    // 加载 Vue 3 应用的 index.html 文件
    win.loadURL('https://localhost:3002') // 本地开发环境，使用 Vue 的开发服务器
    // win.loadFile(path.join(__dirname, 'dist', 'index.html')) // 用于生产构建后的文件

    win.on('closed', () => {
        win = null
    })
}

// 当 Electron 完成初始化时创建窗口
app.whenReady().then(()=>{
    createWindow()
    const menuTemplate=[
        {
            label:'文件',
            submenu:[
                {
                    label:'退出',
                    click:()=>{
                        app.quit()
                    }
                }
            ],
            role:'fileMenu',
        },
        {
            label: '编辑',
            submenu: []
        },
        {
            label: '帮助',
            submenu: [
                {
                    label: '关于',
                    click: () => {
                        dialog.showMessageBoxSync({
                            type: 'info',
                            icon:'./favicon.png',
                            title: '关于',
                            message: '关于',
                            detail: '关于'
                        })
                    }
                }
            ]
        },
        {
            label: '窗口',
            submenu: [
                {
                    label: '最小化',
                    accelerator: 'CmdOrCtrl+M',
                    role: 'minimize'
                },
                {
                    label: '关闭',
                    accelerator: 'CmdOrCtrl+W',
                    role: 'close'
                }
            ]
        },{
            label: '查看',
            submenu: [
                {
                    label: '重载',
                    accelerator: 'CmdOrCtrl+R',
                    click: function(item, focusedWindow) {
                        if (focusedWindow) {
                            // 重载当前页面
                            focusedWindow.reload();
                        }
                    }
                },{
                    label: '上一页',
                    accelerator: 'Alt+Left',
                    click: function(item, focusedWindow) {
                        if(focusedWindow){
                            let webContents = focusedWindow.webContents;
                            webContents.executeJavaScript("window.history.back()")
                        }
                    }
                },{
                    label: '下一页',
                    accelerator: 'Alt+Right',
                    click: function(item, focusedWindow) {
                        if(focusedWindow){
                            let webContents = focusedWindow.webContents;
                            webContents.executeJavaScript("window.history.forward()")
                        }
                    }
                },
                {
                    label: '切换全屏',
                    accelerator: (function() {
                        if (process.platform === 'darwin') {
                            return 'Ctrl+Command+F';
                        }
                    })
                }
            ]
        }
    ]
    Menu.setApplicationMenu(Menu.buildFromTemplate(menuTemplate))
})

// 在 macOS 上，当所有的窗口都关闭时退出应用
app.on('window-all-closed', () => {
    if (process.platform !== 'darwin') {
        app.quit()
    }
})

app.on('activate', () => {
    if (BrowserWindow.getAllWindows().length === 0) {
        createWindow()
    }
})

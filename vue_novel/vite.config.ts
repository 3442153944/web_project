import { fileURLToPath, URL } from 'node:url'

import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import VueDevTools from 'vite-plugin-vue-devtools'
import VueSetupExtend from 'vite-plugin-vue-setup-extend'
import fs from 'fs'
import path from 'path'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    vue(),
    VueDevTools(),
    VueSetupExtend(),
  ],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url))
    }
  },
  server:{
    port:3001,
    https: {
      key: fs.readFileSync(path.resolve(__dirname, 'H:/web_preject/key/server.key')),
      cert: fs.readFileSync(path.resolve(__dirname, 'H:/web_preject/key/server.crt')),
    },
    proxy: {
      '/api': {
        target: 'https://127.0.0.1:4434', // 代理的目标地址
        changeOrigin: true,
        rewrite: (path) => path.replace(/^\/api/, ''), // 如果目标服务器的接口路径有前缀，可以在代理时去掉前缀
        secure: false,
      },
    },
    cors:true,
  },
})

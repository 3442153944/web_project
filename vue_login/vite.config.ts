import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [vue()],
  server:{
    port:3000,
    proxy: {
      '/api': {
        target: 'http://127.0.0.1:11451', // 代理的目标地址
        changeOrigin: true,
        rewrite: (path) => path.replace(/^\/api/, ''), // 如果目标服务器的接口路径有前缀，可以在代理时去掉前缀
      },
    },
  }
})

import { defineConfig } from 'vite'
import uni from '@dcloudio/vite-plugin-uni'
// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    uni(),
  ],
  define: {
    'process.env.UNI_PLATFORM': JSON.stringify(process.env.UNI_PLATFORM || 'h5'),
  },
})

import { defineConfig } from 'vite';
import vue from '@vitejs/plugin-vue';
import fs from 'fs';
import path from 'path';
import VueDevTools from 'vite-plugin-vue-devtools';
import VueSetupExtend from 'vite-plugin-vue-setup-extend';
import { fileURLToPath } from 'url';
import mkcert from 'vite-plugin-mkcert';

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [vue(),
  VueDevTools(),
  VueSetupExtend(),
  mkcert()
  ],
})

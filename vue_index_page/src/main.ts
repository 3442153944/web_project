import { createApp } from 'vue';
import App from './App.vue';
import VueLazyload from 'vue-lazyload';
import store from './components/store.js'

const app = createApp(App);

app.use(VueLazyload, {
  preLoad: 1.3,
  error: 'https://www.sunyuanling.com/assets/default_avatar.svg', // 错误时显示的图片
  loading: 'https://www.sunyuanling.com/assets/下载加载.mp4', // 加载时显示的图片
  attempt: 1,
});

app.mount('#app');
app.use(store);

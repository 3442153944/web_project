import { createApp } from 'vue';  
import App from './App.vue';  
import VueLazyload from 'vue-lazyload';  
import { createStore } from 'vuex'; // 确保从 vuex 导入 createStore  
import store from './components/store.js'; // 假设你的 store 文件名为 store.js，并且它导出了一个 Vuex store 实例  

const app = createApp(App);  

app.use(VueLazyload, {  
  preLoad: 1.3,  
  error: 'https://www.sunyuanling.com/assets/default_avatar.svg',  
  loading: 'https://www.sunyuanling.com/assets/下载加载.mp4', // 注意：这里通常是 GIF 或图片，而不是视频  
  attempt: 1,  
});  

app.use(store); // 这行实际上是不必要的，因为 Vuex store 不通过 app.use() 安装  

app.mount('#app');
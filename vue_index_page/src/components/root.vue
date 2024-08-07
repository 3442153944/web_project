<template>
  <div class="root_page">
    <div class="cursor_action"
      :style="{ top: cursor_top + 'px', left: cursor_left + 'px', opacity: cursor_apactiy, transform: `translateY(${cursor_add}px)` }">
      <img src="https://www.sunyuanling.com/assets/cat.svg" class="icon">
      <span>喵喵喵~</span>
    </div>
    <header_box v-if="load_reading"></header_box>
    <index v-if="load_reading&&index_page_show"></index>
    <div class="loading" v-if="!load_reading">
      <img class="icon" src="https://www.sunyuanling.com/image/loading.gif">
    </div>
    <upload_page v-if="upload_page_show" />
    <content_index_page v-if="content_index_page_show"/>
    <user_center_page :token="token" v-if="user_center_page_show"></user_center_page>
    <other_user_center_page v-if="other_user_center_page_show" :userid="other_userid"></other_user_center_page>
  </div>
</template>

<script>

import index from './index.vue';
import header_box from './headpage_file/header_box.vue';
import upload_page from './headpage_file/file/contribute/index.vue'
export default {
  name: 'root_page',
  components: {
    index, header_box, upload_page
  }
}
</script>

<script setup>
import * as cookies from '../assets/js/cookies';
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted,computed } from 'vue';
import { useStore } from 'vuex'
import content_index_page from './content_page/content_index_page.vue';
import user_center_page from './user_center_page/user_center_page.vue';
import other_user_center_page from './other_user_center_page/user_center_page.vue'
const store = useStore()
let cursor_top = ref(0);
let cursor_left = ref(0);
let cursor_apactiy = ref(0);
let cursor_add = ref(0);
let load_reading = ref(false);
let upload_page_show=computed(()=>store.getters.upload_work)
let index_page_show=computed(()=>store.getters.index_page)
let content_index_page_show=computed(()=>store.getters.content_index_page)
let user_center_page_show=computed(()=>store.getters.user_center_page)
let token=computed(()=>store.getters.token)
let other_user_center_page_show=computed(()=>store.getters.other_user_center_page)
let other_userid=computed(()=>store.getters.other_userid)


// 读取URL参数设置cookie并清除URL中的token参数
function setTokenFromURL() {
    const url = new URL(window.location.href);
    const token = url.searchParams.get('token');

    if (token && (!cookies.get_cookie('token') || cookies.get_cookie('token') === '')) {
        cookies.set_cookie('token', token, { secure: true, 'max-age': 3600, path: '/', HttpOnly: true });
        
        // 移除 URL 中的所有参数，只保留基本路径
        const newUrl = url.origin + url.pathname;
        
        // 替换当前历史记录
        window.history.replaceState({}, document.title, newUrl);
    }
}



onMounted(() => {
    setTokenFromURL();
    //获取鼠标坐标
    document.onmousemove = (e) => {
        cursor_top.value = e.clientY;
        cursor_left.value = e.clientX + 20;
        cursor_apactiy.value = 1;
        cursor_add.value = 0;
    }
    //鼠标点击事件
    document.onmousedown = (e) => {
        cursor_apactiy.value = 1;
        cursor_add.value = 0;
        const intervalId = setInterval(() => {
            cursor_apactiy.value -= 0.05;
            cursor_add.value -= 2;
            if (cursor_apactiy.value <= 0) {
                clearInterval(intervalId);
            }
        }, 50);
    }
});

// 获取用户信息并设置为cookies
async function get_userinfo() {
    try {
        const res = await fetch('https://www.sunyuanling.com/api/GetUserInfo/GetAllUserInfo/', {
            method: 'post',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${cookies.get_cookie('token')}`
            },
            body: JSON.stringify({
                userid: null,
                token: cookies.get_cookie('token')
            })
        });
        if (res.ok) {
            const data = await res.json();
            if (data.status == 'success') {
                cookies.set_cookie('userinfo', JSON.stringify(data.data[0]), { secure: true, 'max-age': 3600, path: '/', HttpOnly: true });
                load_reading.value = true;
            } else {
                console.log('用户未登录');
               window.location.href = 'https://localhost:3000';
            }
        } else if (res.status == 400) {
            console.log('用户未登录');
            cookies.clearAllCookies();
            window.location.href = 'https://localhost:3000';
        } else {
            console.log('网络错误');
            cookies.clearAllCookies();
            window.location.href = 'https://localhost:3000';
        }
    } catch (err) {
        console.log('获取用户信息失败:', err);
        cookies.clearAllCookies();
        window.location.href = 'https://localhost:3000';
    }
}

// 登录验证
async function load_login() {
    try {
        const res = await fetch('https://www.sunyuanling.com/api/GetUserInfo/Login/', {
            method: 'post',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${cookies.get_cookie('token')}`
            },
            body: JSON.stringify({
                userid: null,
                token: cookies.get_cookie('token')
            })
        });
        if (res.ok) {
            const data = await res.json();
            if (data.status == 'success') {
                cookies.set_cookie('token', data.token, { secure: true, 'max-age': 3600, path: '/', HttpOnly: true });
                store.commit('SET_TOKEN',data.token)
            }
        }
    } catch (err) {
        console.log('登录验证失败:', err);
    }
}

onMounted(async () => {
    await get_userinfo();
    await load_login();
});
</script>

<style scoped>
.cursor_action {
  position: fixed;
  color: #f889fc;
  opacity: 0;
  width: 90px;
  z-index: 100;
  pointer-events: none;
}

.cursor_action svg img {
  width: 20px;
  height: 20px;
  object-fit: cover;
}

.icon {
  width: 25px;
  height: 25px;
  object-fit: cover;
}
</style>
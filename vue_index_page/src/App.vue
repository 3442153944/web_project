<template>
    <div class="cursor_action"
        :style="{ top: cursor_top + 'px', left: cursor_left + 'px', opacity: cursor_apactiy, transform: `translateY(${cursor_add}px)` }">
       <img src="https://www.sunyuanling.com/assets/cat.svg" class="icon">
        <span>喵喵喵~</span>
    </div>
    <header_box v-if="load_reading"></header_box>
    <index v-if="load_reading"></index>
    <div class="loading" v-if="!load_reading">
        <img class="icon" src="https://www.sunyuanling.com/image/loading.gif">
    </div>
</template>

<script>
import index from './components/index.vue';
import * as cookies from '../../model/cookies.js';
import header_box from './components/headpage_file/header_box.vue';
import { ref, onMounted } from 'vue';
</script>

<script setup>
let cursor_top = ref(0);
let cursor_left = ref(0);
let cursor_apactiy = ref(0);
let cursor_add = ref(0);
let load_reading = ref(false)
//读取URL参数设置cookie
if (cookies.get_cookie('token') == null || cookies.get_cookie('token') == '' || cookies.get_cookie('token') == undefined) {
    const url = new URL(window.location.href);
    const searchParams = url.searchParams;
    const token = searchParams.get('token')
    cookies.set_cookie('token', token)
    console.log(cookies.get_cookie('token'))
}
console.log(cookies.get_cookie('token'))
onMounted(() => {
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
})
//获取用户信息并设置为cookies
async function get_userinfo() {
    try {
        const res = await fetch('https://www.sunyuanling.com/api/GetUserInfo/GetAllUserInfo/', {
            method: 'post',
            body: JSON.stringify({
                userid: null,
                token: cookies.get_cookie('token'),
            })
        })
        if (res.ok) {
            const data = await res.json();
            if (data.status == 'success') {
                console.log(data)
                cookies.set_cookie('userinfo', JSON.stringify(data.data[0]))
                load_reading.value = true;
            }
            else {
                console.log('用户未登录')
                window.location.href='https://localhost:3000'
            }
        }
        else if (res.status == 400) {
            console.log('用户未登录')
            window.location.href='https://localhost:3000'
        }
        else {
            console.log('网络错误')
        }
    }
    catch (err) {
        console.log(err)
    }
}
//登录验证
async function load_login() {
    try {
        const res = await fetch('https://www.sunyuanling.com/api/GetUserInfo/Login/', {
            method: 'post',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                userid: null,
                token: cookies.get_cookie('token')
            })
        })
        if (res.ok) {
            const data = await res.json()
            if (data.status == 'success') {
                cookies.set_cookie('token', data.token)
            }
        }
    }
    catch (err) {
        console.log(err)
    }
}
onMounted(async () => {
    await get_userinfo();
    await load_login();
})
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

.cursor_action svg img{
    width: 20px;
    height: 20px;
    object-fit: cover;
}
.icon{
    width: 25px;
    height: 25px;
    object-fit: cover;
}
</style>

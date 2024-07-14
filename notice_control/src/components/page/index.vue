<template>
    <div class="index">

        <notice_head></notice_head>
        <div class="content" v-if="index_page">
            <div class="content-left">
                <div class="item-box" @click="currentComponent = 'add_notice'">
                    <span>新增公告</span>
                </div>
                <div class="item-box" @click="currentComponent = 'delete_notice'">
                    <span>删除公告</span>
                </div>
                <div class="item-box" @click="currentComponent = 'modify_notice'">
                    <span>修改公告</span>
                </div>
                <div class="item-box" @click="currentComponent = 'show_all_notice'">
                    <span>公告列表</span>
                </div>
            </div>
            <div class="content-right">
                <component :is="currentComponent"></component>
            </div>
        </div>
        <login @login="login_item" v-if="login_page"></login>
    </div>
</template>
<script>
import { onMounted, ref } from 'vue';
import notice_head from './head.vue';
import add_notice from './add_notice.vue';
import delete_notice from './delete_notice.vue';
import modify_notice from './modify_notice.vue';
import show_all_notice from './show_all_notice.vue';
import login from './login/login.vue'
import * as cookies from '../../../../model/cookies.js'
export default {
    components: {
        notice_head,
        add_notice,
        delete_notice,
        modify_notice,
        show_all_notice,
        login,
    }
}
</script>
<script setup>
let currentComponent = ref('show_all_notice');
let login_page = ref(true)
let index_page = ref(false)
console.log(cookies.get_cookie('token'))
async function login_item(item) {
    login_page.value = false
    index_page.value = true
}

//验证token正确则跳过登录，否则使用账号密码进行登录
async function check_token() {
    const res = await fetch('https://www.sunyuanling.com/api/notice_control/ControlNoticeLogin/', {
        method: 'post',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            token: cookies.get_cookie('token'),
            userid: null,
            password: null
        })
    })
    if (res.ok) {
        const data = await res.json()
        if (data.status === 'success') {
            login_page.value = false
            index_page.value = true
            cookies.set_cookie('token', data.token) // 设置新token
            console.log(data.token)
        }
        else {
            login_page.value = true
            index_page.value = false
            console.log(data.message)
        }
    }
    else {
        login_page.value = true
        index_page.value = false
        console.log('网络错误')
    }
}
//使用token获取用户信息
async function get_user_info() {
    try {
        const res = await fetch('https://www.sunyuanling.com/api/notice_control/UserInfoByToken/', {
            method: 'post',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                token: cookies.get_cookie('token')
            })
        })
        if (res.ok) {
            const data = await res.json()
            if (data.status == 'success') {
                cookies.set_storage('user_info', JSON.stringify( data.data[0]))
            }
            else {
                console.log(data.message)
            }
        }
    }
    catch (e) {
        console.log(e)
    }
}

onMounted(async () => {
    await check_token(); // 组件挂载时验证token
    await  get_user_info();
})


</script>

<style scoped>
.index {
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column;
    align-items: center;
}

.content {
    display: flex;
    width: 100%;
}

.content-left {
    display: flex;
    flex-direction: column;
    width: 20%;
    background-color: #f8f9fa;
    padding: 10px;
    box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
}

.item-box {
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 15px;
    margin: 5px 0;
    background-color: #ffffff;
    border: 1px solid #e0e0e0;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s, transform 0.3s;
}

.item-box:hover {
    background-color: #e0e0e0;
    transform: scale(1.02);
}

.content-right {
    display: flex;
    flex-grow: 1;
    padding: 20px;
}
</style>
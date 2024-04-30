<template>
    <div class="back">
        
        <div class="login_page">
            <h1>登录</h1>
            <div class="username_input">
                <input placeholder="用户名" type="text" v-model="username_in" ref="username"></input>
            </div>
            <div class="user_password">
                <input placeholder="密码" type="password" v-model="password_in" ref="password"></input>
            </div>
            <div class="login_btn" @click="login"><span>登录</span></div>
        </div>
    </div>
</template>
<script lang="ts">
 import {ref,onMounted,onUnmounted} from 'vue';
export default{
    name:'login',
}
</script>
<script setup lang="ts">   
  
let username_in = ref('');  
let password_in = ref('');  
  
function login() {  
    if (username_in.value === '') {  
        alert('用户名不能为空');  
        return;  
    }  
    if (password_in.value === '') {  
        alert('密码不能为空');  
        return;  
    }  
  
    connServer()  
        .then(data => {  
            if (data.message === 'success') {  
                window.location.href = '/';  
            } else {  
                // 登录失败的处理逻辑  
                alert('登录失败: ' + data.message);  
            }  
        })  
        .catch(error => {  
            // 请求失败的处理逻辑  
            console.error('请求失败:', error);  
            alert('登录失败，请检查您的网络连接或稍后重试');  
        });  
}  
  
// 连接服务器  
async function connServer() {  
    try {  
        const response = await fetch('/api/login', {  
            method: 'POST',  
            headers: {  
                'Content-Type': 'application/json'  
            },  
            body: JSON.stringify({  
                username: username_in.value,  
                password: password_in.value  
            })  
        });  
  
        if (!response.ok) {  
            throw new Error('请求失败: ' + response.status);  
        }  
  
        return response.json();  
    } catch (error) {  
        // 这里可以抛出错误或返回某种失败状态  
        throw error;  
    }  
}  
</script>

<style  scoped>
@keyframes gradient {  
    0% {  
        background-position: 0% 50%;  
    }  
    50% {  
        background-position: 100% 50%;  
    }  
    100% {  
        background-position: 0% 50%;  
    }  
}  
  
.back {  
    /* 你的原始样式 */  
    background-color: #c0c8cf; /* 作为备用的背景颜色，或者渐变开始的颜色 */  
    height: 50vh;  
    width: 50vw;  
    display: flex;  
    justify-content: center;  
    align-items: center;  
    color: #fff;  
    border-radius: 15px;  
    padding: 5px;  
  
    /* 添加渐变背景 */  
    background-image: linear-gradient(90deg, #9fbcd4, #e0e8ef, #71b2eb);  
    background-size: 250% 100%; /* 让渐变背景可以移动 */  
    animation: gradient 3s ease infinite; /* 应用动画，并设置动画时间、缓动函数和循环次数 */  
}
.login_page{
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    width:100%;
    height: 100%;
}
.username_input,.user_password{
    width:80%;
    height: 40px;
    margin-top:20px;
    border-radius: 10px;
    font-size: 16px;
    font-weight: bold;
    background-color: #e0e8ef;
}
.login_btn{
    width:80%;
    height: 50px;
    margin-top:50px;
    background-color: #2a98f8;
    border-radius: 15px;
    padding: 5px;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 18px;
    font-weight: bold;
}
.login_btn:hover{
    cursor: pointer;
    opacity: 0.8;
    transition: 0.2s;
}
input{
    border:none;
    background: transparent;
    width:100%;
    height: 100%;
}

</style>
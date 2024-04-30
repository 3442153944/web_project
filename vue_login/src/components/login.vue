<template>
    <div class="back">
        
        <div class="login_page">
            <h1>登录</h1>
            <div class="username_input">
                <input placeholder="用户名" type="text"></input>
            </div>
            <div class="user_password">
                <input placeholder="密码" type="password"></input>
            </div>
            <div class="login_btn"><span>登录</span></div>
        </div>
    </div>
</template>
<script lang="ts">
 import {ref,onMounted,onUnmounted} from 'vue';
export default{
    name:'login',
}
</script>
<script setup>

</script>

<style  scoped>
.back{
    background-color: #c0c8cf;
    height: 50vh;
    width: 50vw;
    display: flex;
    justify-content: center;
    align-items: center;
    color: #fff;
    border-radius: 15px;
    padding:5px;
}
.login_page{
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    width:100%;
    height: 100%;
}

</style>
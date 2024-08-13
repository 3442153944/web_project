<template>
  <div class="login_page">
        <div class="title">
            管理面板登录
        </div>
        <div class="login">
            <div class="username">
                <input v-model="username" type="text" placeholder="管理员用户ID">
            </div>
            <div class="password">
                <input v-model="password" type="password" placeholder="管理员密码">
            </div>
            <div class="login_btn"></div>
        </div>
  </div>
</template>


<script setup>
import {ref} from 'vue'
let username=ref()
let password=ref()
</script>

<style scoped>
  
</style>
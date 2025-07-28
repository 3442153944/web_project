<template>

</template>

<script setup>
import { onMounted, ref } from 'vue';
import BaseApi from '../../BaseApi.js';
import {useStore} from "@/store/index.js"

const api=BaseApi;
const store=useStore();

onMounted(async ()=>{
    const res=await api.loginCheck();
    if(res){
        uni.switchTab({url:'/pages/index/index'})
        const user_info=await api.getUserInfo();
        if(user_info){
            store.$state.user_info=user_info;
        }
        console.log(store.$state.user_info);

    }else{
        uni.redirectTo({url:'/pages/login/login_page'})
    }
})

</script>

<style>

</style>
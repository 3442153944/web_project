<template>
  <div class="user_control">
    <h1>用户管理</h1>
    {{ user_list }}
  </div>
</template>


<script setup>
import { get_user_list } from './js/get_user_list';
import {ref,onMounted} from 'vue'

const user_list=ref()

onMounted(async ()=>{
     user_list.value= await get_user_list();
     console.log(user_list.value)
})
</script>

<style scoped>
  
</style>
<template>
<div class="user_center_page" v-if="user_info">
  <div class="content">
    用户中心
    <user_background :user_back_img="'https://www.sunyuanling.com/image/'+user_info.user_back_img" :token="token"></user_background>
  </div>
</div>
</template>
<script setup>
import {defineProps,ref,onMounted} from 'vue';
import { get_userinfo } from './user_center_model/js/get_userinfo.js';
import user_background from './user_center_model/model/user_background.vue';
const props=defineProps({
  userid:{
    type:String,
    default:''
  },
  token:{
    type:String,
    default:'sunyuanling'
  }
})
let user_info=ref()
onMounted(async()=>{
  user_info.value=await get_userinfo(props.token)
  user_info.value=user_info.value[0]
  console.log(user_info.value)
})
</script>

<style scoped>

</style>

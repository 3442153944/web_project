<script setup>
import { ref } from 'vue'
import send_msg_box from './model/send_msg_box.vue';
//接收评论消息
function receive_msg(msg){
  console.log(msg)
}
</script>

<template>
<div class="index">
  <div class="title">
    <span>评论</span>
  </div>
  <div class="content">
    <send_msg_box @send_msg="receive_msg"></send_msg_box>
  </div>
</div>
</template>

<style scoped>
.index{
  width: 100%;
  height: auto;
  display: flex;
  flex-direction: column;
  gap: 10px;
  border-top: 1px solid rgba(133,133,133,1);
}
</style>

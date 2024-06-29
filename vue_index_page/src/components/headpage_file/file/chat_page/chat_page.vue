<template>
  <div class="chat_page">
    <div class="close_btn" @click="close_page_click"></div>
    聊天页面
  </div>
</template>

<script>
import { ref, reactive, toRefs, watch, onMounted, onUnmounted,defineEmits } from 'vue';
export default {
  name: 'chat_page',
}
</script>

<script setup>
let close_page=defineEmits(['close_page']);
//向父组件传递关闭消息
function close_page_click(){
  close_page('close_page',false)
}

</script>

<style scoped>
  
</style>
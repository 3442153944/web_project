<template>
  <div class="send_msg_box">
    <div class="user_avatar">
        <img class="avatar_img" :src="user_avatar_path">
    </div>
    <auto_textarea v-model="content"></auto_textarea>
    <div class="send_btn" @click="send_msg">
        <span>发送</span>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, toRefs, watch, onMounted, onUnmounted ,defineProps,defineEmits} from 'vue';
import auto_textarea from './auto_textarea.vue'
const props =defineProps({
    user_avatar_path:{
        type:String,
        default:'https://www.sunyuanling.com/assets/work_like.svg'
    },
})
const emit=defineEmits(['send_msg'])
let content=ref('')
//发送消息
const send_msg=()=>{
    emit('send_msg',content.value)
    content.value=''
}
</script>

<style scoped>
  .send_msg_box{
    display: flex;
    flex-direction: row;
    gap: 10px;
    width: 100%;
    height: 100%;
    align-items: center;
  }
  .user_avatar{
    width: 50px;
    height: 50px;
    display: flex;
    overflow: hidden;
  }
  .user_avatar img{
    width: 100%;
    height: 100%;
    border-radius: 50%;
  }
  .send_btn{
    width: auto;
    height: auto;
    display: flex;
    padding: 5px 10px;
    min-width: 40px;
    cursor: pointer;
    background-color: rgba(0,150,255,1);
    border-radius: 10px;
    color: white;
    align-items: center;
    justify-content: center;
    font-weight: bold;
  }
  .send_btn:hover{
    opacity: 0.8;
    transition: all 0.3s ease-in-out;
  }
</style>
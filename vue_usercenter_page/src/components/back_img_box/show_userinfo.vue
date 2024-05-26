<template>
  <div class="show_userinfo">
    <div class="info_box">
        <div class="title_box">
          <span><b>个人信息</b></span>
          <div class="close_btn" @click="close_userinfo()"><img :src="close_btn_path" class="icon"></div>
        </div>
    </div>
  </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted,defineEmits } from 'vue';
export default {
  name: 'show_userinfo',
}
</script>

<script setup>
let server_ip=ref('https://127.0.0.1:4434/');
let close_btn_path=ref(server_ip.value+'assets/close.svg');
let emit=defineEmits(['close_show_userinfo']);
//向父组件发送关闭消息
function close_userinfo(){
  emit('close_show_userinfo',false);
}
</script>

<style scoped>
  .show_userinfo{
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100%;
    background-color: rgba(0,0,0,0.5);
    position: fixed;
    top: 0;
    left: 0;
    z-index: 10;
    width: 100%;
  }
  .info_box{
    display: flex;
    flex-direction: column;
    width:450px;
    height: auto;
    background-color: rgba(255,255,255,1);
    border-radius: 15px;
    overflow: hidden;
    box-shadow: 0px 0px 10px rgba(0,0,0,0.3);
  }
  .title_box{
    display: flex;
    align-items: center;
    width:100%;
    position: relative;
    justify-content: center;
    margin:10px auto;
  }
  .title_box img{
    display: flex;
    justify-content: center;
    align-items: center;
    cursor: pointer;
  }
  .close_btn{
    display: flex;
    justify-content: center;
    align-items: center;
    position: absolute;
    right: 5px;
    width:35px;
    height: 35px;
    cursor: pointer;
    border-radius: 50%;
    overflow: hidden;
  }
  .close_btn:hover{
    background-color: rgba(133,133,133,0.5);
    transition:all 0.3s ease-in-out;
  }
  .icon{
    width:25px;
    height:25px;
    object-fit: cover;
  }
</style>
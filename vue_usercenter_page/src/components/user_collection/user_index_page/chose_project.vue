<template>
  <div class="chose_project">
    <div class="content_box">
        <div class="title_box">
            <span></span>
            <h3>选择项目</h3>
            <div class="close_btn" @click="chose_close_btn_click()">
                <img class="icon" :src="close_btn_path">
            </div>
        </div>
    </div>
  </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted,defineEmits } from 'vue';
export default {
  name: 'chose_project',
}
</script>

<script setup>
let emit=defineEmits(['chose_close_btn_click']);
let server_ip='https://127.0.0.1:4434/'
let close_btn_path=ref(server_ip+'assets/close.svg');

//传递关闭消息
function chose_close_btn_click(){
    emit('chose_close_btn_click',false);
}
</script>

<style scoped>
.chose_project {
    display: flex;
    width: 100vw;
    height: 100vh;
    justify-content: center;
    align-items: center;
    position: fixed;
    top: 0;
    left: 0;
    background-color: rgba(0, 0, 0, 0.5);
    z-index: 10;
    overflow: auto;
}
.content_box {
    display: flex;
    width:550px;
    height: auto;
    flex-direction: column;
    border-radius: 15px;
    background-color: #fff;
    box-shadow: 0 0 10px rgba(255, 255, 255, 0.3);
}
.title_box {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin:10px auto;
    width:100%;
}
.close_btn {
    width:35px;
    height: 35px;
    display: flex;
    justify-content: center;
    align-items: center;
    margin-right: 10px;
}
.close_btn:hover{
    cursor: pointer;
    background-color: rgba(133,133,133,0.6);
    border-radius: 50%;
    overflow: hidden;
    transition: all 0.3s ease-in-out;
}
.close_btn img{
    width:25px;
    height: 25px;
    object-fit: cover;
}
  
</style>
<template>
  <div class="edit_info_box">
    <div class="content">
        <div class="title">
            <span></span>
            <span>修改个人信息</span>
            <div class="close_btn" @click="close_page()">
                <img class="icon" src="https://www.sunyuanling.com/assets/close.svg">
            </div>
        </div>
        <span>个人头像</span>
        <div class="avatar">
            <img>
        </div>
        <span>用户名</span>
        <div class="username">
            <input type="text" placeholder="用户名">
        </div>
        <span>自我介绍</span>
        <div class="introduce">
            <auto_textarea></auto_textarea>
        </div>
        <span>个人网站</span>
        <div class="person_website">
            <input type="text" placeholder="个人网站">
        </div>
        <span>性别</span>
        <div class="sex">
            <input type="radio" name="sex" value="男">男
            <input type="radio" name="sex" value="女">女
            <input type="radio" name="sex" value="任意">任意
        </div>
        <span>地址</span>
        <div class="address">

        </div>
        <span>生日</span>
        <div class="birthday">
            <input type="date">
            <input type="time">
        </div>
        <div class="btn_box">
            <div class="sure_btn">
                <span>确定</span>
            </div>
            <div class="cancel_btn">
                <span>取消</span>
            </div>
        </div>
    </div>
  </div>
</template>

<script setup>
import { ref, defineProps,defineEmits } from 'vue';
import auto_textarea from './user_info_box_model/auto_textarea.vue'
const props = defineProps({
    user_info: {
        type: Object,
        default: () => {
            return {};
        }
    }
})
const emit=defineEmits(['close_page'])
function close_page(){
    emit('close_page')
}
</script>

<style scoped>
  .icon{
    width:25px;
    height: 25px;
    object-fit: cover;
  }
  .edit_info_box{
    width: 100vw;
    height: 100vh;
    position: fixed;
    left: 0;
    top: 0;
    display: flex;
    background-color: rgba(0,0,0,0.5);
    overflow-y: auto;
  }
  .content{
    width: auto;
    max-width: 60%;
    padding: 10px;
    min-width: 100px;
    box-sizing: border-box;
    display: flex;
    flex-direction: column;
    height: auto;
    background-color: rgba(255,255,255,1);
    margin:20px auto;
    border-radius: 15px;
  }
</style>
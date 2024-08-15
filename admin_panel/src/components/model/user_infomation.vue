<template>
    <div class="user_information">
        <div class="content">
            <div class="title">
                <h2>用户详细信息</h2>
                <div class="close_btn" @click="close_page">
                    <img class="icon" src="https://www.sunyuanling.com/assets/close.svg" alt="Close">
                </div>
            </div>
            <div class="user_info">
                <div class="user_back">
                    用户背景图像文件名：
                    <input v-model="user_info.user_back_img" type="text">
                    <div class="serach_img_btn" @click="show_img(user_info.user_back_img)">
                        <span>搜索图片</span>
                    </div>
                </div>
                <div class="user_avatar">
                    用户头像图像文件名：
                    <input v-model="user_info.user_avatar" type="text">
                    <div class="serach_img_btn" @click="show_img(user_info.user_avatar)">
                        <span>搜索图片</span>
                    </div>
                </div>
                <div class="base_info">
                    <div class="info_item">
                        <label>用户名：</label>
                        <input v-model="user_info.username" type="text">
                    </div>
                    <div class="info_item">
                        <label>用户ID：</label>
                        <input v-model="user_info.userid" type="text">
                    </div>
                    <div class="info_item">
                        <label>密码：</label>
                        <input v-model="user_info.password" type="text">
                    </div>
                    <div class="info_item">
                        <label>手机号：</label>
                        <input v-model="user_info.phone" type="text">
                    </div>
                    <div class="info_item">
                        <label>邮箱：</label>
                        <input v-model="user_info.email" type="text">
                    </div>
                    <div class="info_item">
                        <label>性别：</label>
                        <input v-model="user_info.sex" type="text">
                    </div>
                    <div class="info_item">
                        <label>个人网站：</label>
                        <input v-model="user_info.user_self_website" type="text">
                    </div>
                    <div class="info_item">
                        <label>精选作品：</label>
                        <input v-model="user_info.select_work" type="text">
                    </div>
                    <div class="info_item">
                        <label>个人简介：</label>
                        <input v-model="user_info.user_self_introduction" type="text">
                    </div>
                    <div class="info_item">
                        <label>职业：</label>
                        <input v-model="user_info.occupation" type="text">
                    </div>
                    <div class="info_item">
                        <label>生日：</label>
                        <input v-model="user_info.birthday" type="text">
                    </div>
                    <div class="info_item">
                        <label>VIP账号：</label>
                        <input v-model="user_info.vip" type="text">
                    </div>
                    <div class="info_item">
                        <label>账号状态：</label>
                        <input v-model="user_info.account_status" type="text">
                    </div>
                    <div class="info_item">
                        <label>账号权限：</label>
                        <input v-model="user_info.account_permissions" type="text">
                    </div>
                    <div class="info_item">
                        <label>注册时间：</label>
                        <input v-model="user_info.user_register" type="text">
                    </div>
                    <div class="info_item">
                        <label>最后登录时间：</label>
                        <input v-model="user_info.token_expiry" type="text">
                    </div>
                </div>
                <div class="btn_box">
                    <div class="btn sure" @click="confirm_action">
                        <span>确定</span>
                    </div>
                    <div class="btn cancel" @click="close_page">
                        <span>取消</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <search_img v-if="search_img_show" :img_src="search_src" @close_page="search_img_show=false"></search_img> 
</template>

<script setup>
import { ref, defineProps, defineEmits } from 'vue';
import search_img from './search_img.vue'

const props = defineProps({
    user_info: {
        type: Object,
        default: () => ({})
    }
});

const user_info = ref(props.user_info);
const emit = defineEmits(['close_page']);
const search_src=ref('')
const search_img_show=ref(false)

function show_img(src){
    search_src.value=src
    search_img_show.value=true
}

function close_page() {
    emit('close_page');
}

function confirm_action() {
    // Add confirmation logic if needed
    console.log('Confirmed');
}
</script>

<style scoped>
.user_information {
    width: 100vw;
    height: 100vh;
    position: fixed;
    top: 0;
    left: 0;
    background-color: rgba(0, 0, 0, 0.5);
    z-index: 5;
    display: flex;
    justify-content: center;
    align-items: center;
}

.content {
    width: 80%;
    max-width: 800px;
    background-color: #fff;
    border-radius: 10px;
    padding: 20px;
    box-sizing: border-box;
    display: flex;
    flex-direction: column;
    overflow-y: auto;
    position: relative;
    height: 600px;
}

.title {
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 1px solid #ddd;
    padding-bottom: 10px;
    margin-bottom: 20px;
}

.title h2 {
    margin: 0;
}

.icon {
    width: 20px;
    height: 20px;
    object-fit: contain;
}

.close_btn {
    width: 30px;
    height: 30px;
    display: flex;
    justify-content: center;
    align-items: center;
    cursor: pointer;
    transition: background-color 0.3s, transform 0.2s;
}

.close_btn:hover {
    background-color: rgba(0, 0, 0, 0.2);
    border-radius: 50%;
    transform: scale(1.1);
}

.user_info {
    display: flex;
    flex-direction: column;
}

.base_info {
    display: flex;
    flex-direction: column;
    gap: 15px;
}

.info_item {
    display: flex;
    flex-direction: column;
}

.info_item label {
    margin-bottom: 5px;
    font-weight: bold;
}

.info_item input {
    padding: 8px;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 14px;
}

.btn_box {
    display: flex;
    justify-content: flex-end;
    gap: 10px;
    margin-top: 20px;
}

.btn {
    padding: 10px 20px;
    border-radius: 5px;
    cursor: pointer;
    text-align: center;
    font-weight: bold;
    color: #fff;
    transition: background-color 0.3s;
}

.sure {
    background-color: #28a745;
}

.sure:hover {
    background-color: #218838;
}

.cancel {
    background-color: #dc3545;
}

.cancel:hover {
    background-color: #c82333;
}
.serach_img_btn{
    width:auto;
    height: auto;
    padding: 5px;
    cursor: pointer;
    background-color: rgba(0,150,250);
    color: white;
    max-width: 100px;
    font-weight: bold;
    justify-content: center;
    align-items: center;
    text-align: center;
    border-radius: 5px;
}
.serach_img_btn:hover{
    background-color: rgba(0,150,250,0.8);
    transform: scale(1.02);
    transition: all 0.2s ease-in-out;
}
</style>

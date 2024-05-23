<template>
    <div class="user_box">
        <div class="user_info">
            <div class="user_avatar">
                <img :src="user_avatar_path">
            </div>
            <div class="username">
                <span>{{username}}</span>
            </div>
        </div>
        <div class="follow_btn" @click="folloing">
            <span>{{following}}</span>
        </div>
        <div class="user_work_list">
            <div class="tips">
                <span>其他作品</span>
            </div>
            <div class="work_list">
                <div class="work_item" v-for="index in 10" :key="index">
                    <div class="work_img">
                        <img :src="img_list_path[0]">
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import {ref,onMounted,onUnmounted,reactive,watch} from 'vue'
export default{
    name:'user_box',
    components:{},
}
</script>

<script setup>
let user_avatar_path=ref('https://127.0.0.1:4434/image/116883317_p0.png');
let username=ref('用户名');
let following=ref('关注');
let img_list_path=ref(['https://127.0.0.1:4434/image/100213135_p0.jpg']);

function folloing(){
    let btn=document.querySelector('.follow_btn');
    if(following.value=='关注'){
        following.value='已关注';
        btn.style.backgroundColor='rgba(133,133,133)';
    }else if(following.value=='已关注'){
        following.value='关注';
        btn.style.backgroundColor='rgba(0, 150, 250, 1)';
    }
    
}
</script>

<style scoped>
.user_box{
    display: flex;
    flex-grow: 1;
    width:100%;
    height: auto;
    flex-direction: column;
    margin-left: 20px;
}
.user_info{
    display: flex;
    width: 100%;
    height: auto;
}
.user_avatar{
    width: 35px;
    height: 35px;
    border-radius: 50%;
    overflow: hidden;
}
.user_avatar img{
    width: 100%;
    height: 100%;
    object-fit: cover;
}
.username{
    display: flex;
    justify-content: center;
    align-items: center;
}
.follow_btn{
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
    height: 40px;
    margin-top:10px;
    font-size: 16px;
    font-weight: bold;
    background-color: rgba(0, 150, 250, 1);
    opacity: 0.8;
    border-radius: 20px;
    color: white;
}
.follow_btn:hover{
    cursor: pointer;
    transition:all 0.3s ease-in-out;
    opacity: 1;
}
.user_work_list{
    display: flex;
    flex-direction: column;
    width: 100%;
    height: auto;
    margin-top:10px;
}
.work_list{
    display: flex;
    overflow: auto;
    width: 100%;
    height: auto;
    margin-top: 10px;
}
.work_item{
    display: flex;
    width:100px;
    height: 100px;
    border-radius: 15px;
    overflow: hidden;
    margin-right: 10px;
    min-height: 100px;
    min-width: 100px;
}
.work_img{
    width:100%;
    height: 100%;
    overflow: hidden;
    border-radius: 15px;
}
.work_img img{
    width:100%;
    height: 100%;
    object-fit: cover;
}
</style>
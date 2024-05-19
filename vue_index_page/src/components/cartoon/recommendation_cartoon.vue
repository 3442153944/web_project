<template>
    <div class="recommendation_cartoon">
        <h3>推荐的用户作品</h3>
        <div class="work_list">
            <div class="work_item" v-for="index in 9" :key="index">
                <div class="work_img">
                    <div class="age_tag">
                        {{age_tag}}
                    </div>
                    <div class="page_count">
                        <svg t="1715784414381" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg"
                        p-id="9622" width="200" height="200">
                        <path
                          d="M819.2 128H409.6c-56.32 0-102.4 46.08-102.4 102.4v409.6c0 56.32 46.08 102.4 102.4 102.4h409.6c56.32 0 102.4-46.08 102.4-102.4V230.4c0-56.32-46.08-102.4-102.4-102.4z m51.2 512c0 28.16-23.04 51.2-51.2 51.2H409.6c-28.16 0-51.2-23.04-51.2-51.2V230.4c0-28.16 23.04-51.2 51.2-51.2h409.6c28.16 0 51.2 23.04 51.2 51.2v409.6z m-204.8 204.8c0 28.16-23.04 51.2-51.2 51.2H204.8c-28.16 0-51.2-23.04-51.2-51.2V435.2c0-28.16 23.04-51.2 51.2-51.2h51.2v-51.2H204.8c-56.32 0-102.4 46.08-102.4 102.4v409.6c0 56.32 46.08 102.4 102.4 102.4h409.6c56.32 0 102.4-46.08 102.4-102.4v-51.2h-51.2v51.2z"
                          fill="#ccd6de" p-id="9623"></path>
                      </svg>
                        {{page_count}}</div>
                    <img :src="img_path">
                </div>
                <div class="work_title">
                    {{work_title}}
                </div>
                <div class="user_info">
                    <div class="user_avatar">
                        <img :src="user_avatar">
                    </div>
                    <div class="username">
                        {{username}}
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
import {ref,onMounted,onUnmounted,watch} from 'vue';
export default{
    name:'recommendation_cartoon',
}
</script>
<script setup>
let img_path = ref('https://127.0.0.1:443/image/82181448_p0(1).jpg');
let age_tag = ref('R-18');
let page_count = ref('12');
let work_title = ref('作品标题');
let user_avatar = ref('https://127.0.0.1:443/image/104705167_p0.jpg');
let username = ref('用户名');


</script>
<style scoped>
.recommendation_cartoon{
    display: flex;
    flex-direction: column;
    margin-top:20px;
    width:100%;
    height: auto;
    position: relative;
}
.work_list{
    display: flex;
    flex-wrap: wrap;
    width: 100%;
    height: auto;
    position: relative;
    justify-content: space-between;
}
.work_item{
    display: flex;
    flex-direction: column;
    width:calc(100%/6);
    height: 230px;
    min-height: 280px;
    min-width: 200px;
    margin-right: 20px;
    margin-top: 20px;
}
.work_img{
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
    height: 80%;
    min-height: calc(230px*0.8);
    position: relative;
    overflow: hidden;
    border-radius: 15px;
}
.work_img img{
    width: 100%;
    height: 100%;
    object-fit: cover;
}
.age_tag{
    position: absolute;
    top:5px;
    left: 5px;
    width: 40px;
    height: 20px;
    font-size: 12px;
    font-weight: bold;
    color: #FFF;
    border-radius: 5px;
    display: flex;
    justify-content: center;
    align-items: center;
    background-color: red;
}
.page_count{
    position: absolute;
    top:5px;
    right: 5px;
    width: 50px;
    height: 20px;
    font-size: 12px;
    font-weight: bold;
    color: #FFF;
    background-color: rgba(85, 85, 85, 0.8);
    border-radius: 10px;
    display: flex;
    justify-content: center;
    align-items: center;
}
.page_count svg{
    width:20px;
    height: 20px;
    margin-right: 5px;
}
.work_title{
    margin-top: 10px;
}
.user_info{
    display: flex;
    margin-top:10px;  
}
.user_avatar{
    width:40px;
    height: 40px;
    border-radius:50% ;
    overflow: hidden;
}
.user_avatar img{
    width: 100%;
    height: 100%;
    object-fit: cover;
    margin-right: 5px;
}
.username{
    display: flex;
    align-items: center;
    justify-content: center;
    margin-left: 5px;
}
</style>
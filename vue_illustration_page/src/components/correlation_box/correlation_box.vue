<template>
    <div class="correlation_box">
        相关作品
        <div class="correlation_work_list">
            <div class="work_item" v-for="index in 20" :key="index">
                <div class="work_img">
                    <img :src="img_path">
                    <div class="age_tag">
                        <span>{{age_tag}}</span>
                    </div>
                    <div class="page_count">
                        <svg t="1715784414381" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg"
                        p-id="9622" width="200" height="200">
                        <path
                          d="M819.2 128H409.6c-56.32 0-102.4 46.08-102.4 102.4v409.6c0 56.32 46.08 102.4 102.4 102.4h409.6c56.32 0 102.4-46.08 102.4-102.4V230.4c0-56.32-46.08-102.4-102.4-102.4z m51.2 512c0 28.16-23.04 51.2-51.2 51.2H409.6c-28.16 0-51.2-23.04-51.2-51.2V230.4c0-28.16 23.04-51.2 51.2-51.2h409.6c28.16 0 51.2 23.04 51.2 51.2v409.6z m-204.8 204.8c0 28.16-23.04 51.2-51.2 51.2H204.8c-28.16 0-51.2-23.04-51.2-51.2V435.2c0-28.16 23.04-51.2 51.2-51.2h51.2v-51.2H204.8c-56.32 0-102.4 46.08-102.4 102.4v409.6c0 56.32 46.08 102.4 102.4 102.4h409.6c56.32 0 102.4-46.08 102.4-102.4v-51.2h-51.2v51.2z"
                          fill="#ccd6de" p-id="9623"></path>
                      </svg>
                        <span>{{page_count}}</span>
                    </div>
                </div>
                <div class="work_title">
                    <span>{{work_title}}</span>
                </div>
                <div class="user_info">
                    <div class="user_avatar">
                        <img :src="user_avatar">
                    </div>
                    <div class="username">
                        <span>{{username}}</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import {ref,onMounted,watch,onUnmounted} from 'vue'
export default{
    name:'correlation_box',
    components:{},
}
</script>
<script setup>
let img_path=ref('https://127.0.0.1:4434/image/118839253_p1.jpg');
let age_tag=ref('R-18');
let page_count=ref(12);
let user_avatar=ref('https://127.0.0.1:4434/image/116883317_p0.png');
let username=ref('用户名');
let work_title=ref('作品标题');
</script>

<style scoped>
.correlation_box{
    display: flex;
    width:90vw;
    height: auto;
    margin-top: 40px;
    flex-direction: column;
    margin:40px auto;
    margin-left:-5vw;
}
.correlation_work_list{
    display: flex;
    flex-wrap: wrap;
    width: 100%;
    height: auto;
    padding: 10px;
}
.work_item{
    display: flex;
    flex-direction: column;
    width: 210px;
    min-height: 260px;
    height: auto;
    max-height: 330px;
    margin:20px 10px;
}
.work_img{
    display: flex;
    flex-direction: column;
    width: 210px;
    min-width: 210px;
    height: calc(260*0.8)px;
    min-height: 208px;
    position: relative;
    border-radius: 15px;
    overflow: hidden;
}
.work_img img{
    width:100%;
    height:100%;
    object-fit: cover;
}
.age_tag{
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 5px;
    position: absolute;
    top:5px;
    left: 5px;
    background-color: rgb(255, 0, 0);
    color: white;
    font-size: 14px;
    font-weight: bold;
    border-radius: 10px;
    overflow: hidden;
}
.age_tag svg{
    width: 25px;
    height: 25px;
    object-fit: cover;
}
.page_count{
    display: flex;
    justify-content: center;
    align-items: center;
    position: absolute;
    right: 5px;
    top:5px;
    border-radius: 10px;
    width: 50px;
    height: 30px;
    overflow: hidden;
    background-color: rgba(133, 133, 133, 1);
    color: white;
    font-size: 14px;
    font-weight: bold;
}
.page_count svg{
    width:25px;
    height: 25px;
    object-fit: cover;
}
.user_info{
    display: flex;
    margin-top:10px;
    width: 100%;
    height: auto;
    padding: 5px;
    flex-grow: 1;
}
.user_avatar{
    display: flex;
    justify-content: center;
    align-items: center;
    width: 40px;
    height: 40px;
    border-radius: 50%;
    overflow: hidden;
    margin-right: 10px;
}
.user_avatar img{
    width:100%;
    height:100%;
    object-fit: cover;
}
.username{
    display: flex;
    justify-content: center;
    align-items: center;
}
.work_title{
    font-size: 16px;
    font-weight: bold;
}
</style>
<template>
  <div class="header_box">
    <div class="header_box_back mt">
        <div class="header_box_background">
            <div class="header_box_background_img"><img :src="header_box_background_src"></div>
        </div>
        <div class="header_box_avatar" style="cursor:pointer;" @click="jump_usercenter">
            <div class="header_box_avatar_img"><img :src="header_box_avatar_src"></div>
        </div>
    </div>
    <div class="header_box_username mt"><span>{{username}}</span></div>
    <div class="header_box_userid mt"><span>{{userid}}</span></div>
    <div class="header_box_userdata mt">
        <div class="header_box_user_fldata" style="cursor:pointer;">
            <span>{{follow_num}}</span>
            <span>关注</span>
        </div>
        <div class="header_box_user_fans" style="cursor:pointer;">
            <span>{{fans_num}}</span>
            <span>粉丝</span>
        </div>
    </div>
    <br>
    <div class="data_analysis mt hv"><span>数据分析</span></div>
    <div class="my_works mt hv"><span>我的作品</span></div>
    <div class="appointment_management mt hv"><span>约稿管理</span></div>
    <br>
    <div class="collection mt hv"><span>收藏</span></div>
    <div class="browseing_history mt hv"><span>浏览历史</span></div>
    <div class="bookmark mt hv"><span>书签</span></div>
    <br>
    <div class="title mt"><span>Language</span></div>
    <div class="setting mt hv"><span>设置</span></div>
    <div class="send_backword mt hv"><span>发送反馈</span></div>
    <div class="logout mt hv" @click="logout"><span>退出登录</span></div>
  </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted } from 'vue';
export default {
  name: 'header_box',
}
</script>

<script setup>
let header_box_background_src=ref("https://localhost:11451/image/97165605_p0.jpg")
let header_box_avatar_src=ref("../../../image/87328997_p0.jpg")
let username=ref("孙源玲")
let userid=ref('@'+"userid")
let follow_num=ref(100)
let fans_num=ref(100)

function setUserinfo(){
    username.value=getCookie("username")
    userid.value='@'+getCookie("userid")
    console.log(getCookie('user_following'))
    follow_num.value=getCookie('user_following')
    fans_num.value=getCookie('user_fans')
    header_box_avatar_src.value="https://127.0.0.1:4434/image/"+getCookie("user_avatar")
    header_box_background_src.value="https://127.0.0.1:4434/image/"+getCookie("user_back_img")
}
function getCookie(name) {
    const cookieString = document.cookie;
    const cookies = cookieString.split(';');
    for (let i = 0; i < cookies.length; i++) {
        const cookie = cookies[i].trim();
        // 判断是否为目标 cookie
        if (cookie.startsWith(name + '=')) {
            return cookie.substring(name.length + 1); // 返回 cookie 的值（去掉名称部分）
        }
    }
    return ''; // 如果找不到目标 cookie，则返回空字符串
}
onMounted(()=>{
    setUserinfo();
})

function jump_usercenter(){
    console.log("用户中心跳转");
    //window.location.href="https://localhost:8888/usercenter";
}
//退出登录
function logout(){
    console.log("退出登录");
    clearAllCookies();
    window.location.href="https://localhost:3000";

}
//清空cookies
function clearAllCookies() {
    const cookies = document.cookie.split(';');

    cookies.forEach(cookie => {
        const [name, _] = cookie.split('=');
        document.cookie = `${name}=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;`;
    });
}

</script>

<style scoped>
/*通用样式*/
@charset "utf-8";
.mt{margin-top:5px;}
.mb{margin-bottom:5px;}
.ml{margin-left:5px;}
.mr{margin-right:5px;}
.pt{padding-top:5px;}
.pb{padding-bottom:5px;}
.pl{padding-left:5px;}
.pr{padding-right:5px;}
.hv:hover{
    cursor: pointer;
    background-color:rgba(236, 236, 236, 1);
    transition:0.2s;
    border-radius: 5px;
    opacity: 0.8;
}

.header_box{
    display: flex;
    flex-direction: column;
    width:200px;
    height: auto;
    min-height: 200px;
    background-color: rgba(214,214,215,1);
    position:absolute;
    right: 0px;
    top:60px;
    overflow-y:auto ;
    padding:5px;
    border-radius: 15px;
    z-index:3;
}
.header_box_back{
    width:100%;
    height:120px;
    position: relative;
}
.header_box_background{
    width:100%;
    height: 70%;
    overflow: hidden;
}
.header_box_background_img{
    width:100%;
    height: 100%;
    overflow: hidden;
}
.header_box_background_img img{
    width:100%;
    height: 100%;
    object-fit: cover;
}
.header_box_avatar{
    width:100%;
    height: 30%;
    position: absolute;
    top:60%;
    justify-content: center;
    align-self: center;
    display: flex;
}
.header_box_avatar_img{
    width:50px;
    height: 50px;
    overflow: hidden;
    border-radius: 50%;
}
.header_box_avatar_img img{
    width:100%;
    height: 100%;
    object-fit: cover;
}
.header_box_userdata{
    display: flex;
    width:95%;
    height: auto;
    justify-content: space-between;
    padding:5px;
    align-items: center;
    margin-left:auto;
    margin-right: auto;
}
.header_box_user_fldata{
    display:flex;
    flex-direction: column;
    align-self: center;
}
.header_box_user_fans{
    display:flex;
    flex-direction: column;
    align-self: center;
}
.title{
    color:rgba(243,243,243,1);
    border-bottom:1px solid rgba(243,243,243,1);
}
  
</style>
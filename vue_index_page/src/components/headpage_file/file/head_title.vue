<!-- eslint-disable vue/no-unused-components -->
<!-- eslint-disable vue/multi-word-component-names -->
<template>
    <div class="title">
        <div class="show_more">
            <div class="show_more_icon" @click="switch_show_sidebar">
                <svg t="1713665000311" class="icon" viewBox="0 0 1024 1024" version="1.1"
                    xmlns="http://www.w3.org/2000/svg" p-id="6457" width="200" height="200">
                    <path
                        d="M947.2 204.8H76.8c-23.893 0-42.667-18.773-42.667-42.667s18.774-42.666 42.667-42.666h872.107c22.186 0 40.96 18.773 40.96 42.666S971.093 204.8 947.2 204.8z m0 699.733H76.8c-23.893 0-42.667-18.773-42.667-42.666S52.907 819.2 76.8 819.2h872.107c23.893 0 42.666 18.773 42.666 42.667-1.706 23.893-20.48 42.666-44.373 42.666z m0-349.866H76.8c-23.893 0-42.667-18.774-42.667-42.667s18.774-42.667 42.667-42.667h872.107c23.893 0 42.666 18.774 42.666 42.667s-20.48 42.667-44.373 42.667z"
                        p-id="6458"></path>
                </svg>
            </div>
            <div class="sidebar" id="sidebar" v-show="show_sidebar" :style="action_left">
                <sidebar></sidebar>
            </div>
        </div>
        <div class="index_jump_img ml">
            <img :src="index_jump_img_src"><!--主页图片路径:H:/web_project/image/主页.png-->
        </div>
        <div class="input_box" ref="input_box">
            <input v-model="search_data" placeholder="搜索作品" @focus="input_box_focus">
            <div class="search_icon" @click="search_data_updata">
                <svg t="1713666425341" class="icon" viewBox="0 0 1024 1024" version="1.1"
                    xmlns="http://www.w3.org/2000/svg" p-id="7531" width="200" height="200">
                    <path
                        d="M964.266667 942.933333l-221.866667-238.933333c64-72.533333 106.666667-166.4 106.666667-273.066667 0-226.133333-183.466667-409.6-409.6-409.6S29.866667 204.8 29.866667 430.933333s183.466667 409.6 409.6 409.6c89.6 0 170.666667-29.866667 238.933333-76.8l221.866667 238.933334c8.533333 8.533333 21.333333 12.8 29.866666 12.8 8.533333 0 21.333333-4.266667 29.866667-12.8 21.333333-17.066667 21.333333-42.666667 4.266667-59.733334z m-844.8-512c0-179.2 145.066667-324.266667 324.266666-324.266666S768 251.733333 768 430.933333s-145.066667 324.266667-324.266667 324.266667-324.266667-149.333333-324.266666-324.266667z"
                        fill="#999999" p-id="7532"></path>
                </svg>
            </div>
        </div>
        <div class="join_vip ml mr">
            <span>{{ join_vip_text }}</span>
        </div>
        <div class="submission ml mr" @click="submission_work_box_show_btn">
            <div class="submission_icon mr">
                <svg t="1713667310491" class="icon" viewBox="0 0 1664 1024" version="1.1"
                    xmlns="http://www.w3.org/2000/svg" p-id="8530" width="200" height="200">
                    <path
                        d="M790.656 946.688c2.048 1.024 3.84 2.816 5.76 3.584a94.848 94.848 0 0 0 110.592-19.2l666.88-705.28a95.872 95.872 0 0 0-139.264-131.84L836.096 727.04 228.864 96.512A95.744 95.744 0 0 0 90.88 229.12l673.28 698.88c1.28 1.152 3.328 1.664 4.608 3.2 1.024 0.896 1.664 1.92 2.688 3.2 5.76 5.76 12.8 8.448 19.2 12.16z"
                        fill="#666666" p-id="8531"></path>
                </svg>
            </div>
            <div class="submission_text"><span>{{ submission_text }}</span></div>
            <div class="submission_work_box" v-show="submission_work_box_show">
                <submission_work_box></submission_work_box>
            </div>

        </div>
        <div class="message ml mr">
            <div class="message_icon" @click="chat_page_show_click()">
                <svg t="1713667475510" class="icon" viewBox="0 0 1024 1024" version="1.1"
                    xmlns="http://www.w3.org/2000/svg" p-id="9553" width="200" height="200">
                    <path
                        d="M56.888889 823.46666633v-568.888889l429.511111 315.733334c5.688889 5.688889 17.066667 11.377778 25.6 11.377778 8.533333 0 19.911111-2.844444 25.6-11.377778L967.111111 254.57777733v568.888889H56.888889z m455.111111-312.888889L85.333333 197.68888933h853.333334l-426.666667 312.888888z m-455.111111 369.777778h910.222222c17.066667 0 56.888889-5.688889 56.888889-56.888889v-625.777777c0-17.066667-14.222222-56.888889-56.888889-56.888889H56.888889c-51.2 0-56.888889 36.977778-56.888889 56.888889v625.777777c0 39.822222 14.222222 56.888889 56.888889 56.888889z"
                        fill="#545E68" p-id="9554"></path>
                </svg>
            </div>
            
        </div>
        <div class="notice ml mr">
            <div class="notice_icon">
                <svg t="1713667792090" class="icon" viewBox="0 0 1024 1024" version="1.1"
                    xmlns="http://www.w3.org/2000/svg" p-id="10588" width="200" height="200">
                    <path
                        d="M832 725.33333334V469.33333334a320 320 0 0 0-192-294.4 128 128 0 1 0-256 0A320 320 0 0 0 192 469.33333334v256l-64 128h768zM448 149.33333334a64 64 0 0 1 128 0 59.52 59.52 0 0 1 0 6.4 314.24 314.24 0 0 0-128 0A59.52 59.52 0 0 1 448 149.33333334zM231.68 789.33333334l17.92-35.2 6.4-13.44V469.33333334a256 256 0 0 1 512 0v271.36l7.04 13.44 17.92 35.2zM320 917.33333334h384v64H320z"
                        p-id="10589"></path>
                </svg>
            </div>
        </div>
        <div class="useravatar ml mr" @click="useravatar_show_btn">
            <div class="useravatar_img">
                <img :src="avatar_img_src">
            </div>
            <div class="useravatar_icon ml">
                <svg t="1713667310491" class="icon" viewBox="0 0 1664 1024" version="1.1"
                    xmlns="http://www.w3.org/2000/svg" p-id="8530" width="200" height="200">
                    <path
                        d="M790.656 946.688c2.048 1.024 3.84 2.816 5.76 3.584a94.848 94.848 0 0 0 110.592-19.2l666.88-705.28a95.872 95.872 0 0 0-139.264-131.84L836.096 727.04 228.864 96.512A95.744 95.744 0 0 0 90.88 229.12l673.28 698.88c1.28 1.152 3.328 1.664 4.608 3.2 1.024 0.896 1.664 1.92 2.688 3.2 5.76 5.76 12.8 8.448 19.2 12.16z"
                        fill="#666666" p-id="8531"></path>
                </svg>
            </div>
        </div>
        <chat_page class="chat_page" v-if="chat_page_show" @close_page="close_chat_page"></chat_page>
        <header_box v-show="header_box_show"></header_box><!--这是头像，不是标题栏-->
        <search_page_index :search_item="search_data" @close_msg="close_search_page"
        ref="search_page_click"
         v-if="search_show_status">
        </search_page_index>
    </div>
</template>

<script>
import { onMounted, ref,watch } from 'vue'
import sidebar from './sidebar/sidebar.vue'
import submission_work_box from './submission_work_box/submission_work_box.vue'
import header_box from './header_box/header_box.vue'
import chat_page from './chat_page/chat_page.vue'
import * as cookies from '../../../../../model/cookies.js'
import search_page_index from './search_page/search_page_index.vue'
export default {
    // eslint-disable-next-line vue/multi-word-component-names
    name: 'head_title',
    // eslint-disable-next-line vue/no-unused-components
    components: { sidebar, submission_work_box, header_box,chat_page,search_page_index}
}
</script>
<script setup>
let index_jump_img_src = ref('https://www.sunyuanling.com/image/主页.png')
let submission_text = ref('投稿作品')
let avatar_img_src = ref('https://www.sunyuanling.com/image/87328997_p0.jpg')
let join_vip_text = ref('加入ILLWeb高级会员')
let show_sidebar = ref(false)
let action_left = ref('left:0px;')
let submission_work_box_show = ref(false)
let header_box_show=ref(false)
let chat_page_show=ref(false)
let user_info=ref([])
let search_data=ref()//搜索数据
user_info.value=JSON.parse(cookies.get_cookie('userinfo'))
avatar_img_src.value="https://www.sunyuanling.com/image/"+user_info.value.user_avatar;
let search_show_status=ref(false);
let input_box=ref(null)
let search_page_click=ref(null)

//搜索实现
watch(search_data,(newValue,oldValue)=>{
    search_data.value=newValue;
})
//更新search_data以触发搜索页面的更新
async function search_data_updata(){
  if (search_page_click.value){
    try{
    const result=await search_page_click.value.get_search_data(search_data.value)
    }
    catch(error){
      console.log(error);
    }
  }

}
//获取焦点时显示搜索页面，失去焦点时隐藏搜索页面
function input_box_focus(){
    search_show_status.value=true;
}
function input_box_blur(){
    search_show_status.value=false;
}

//接收搜索页面的关闭消息
function close_search_page(item){
    console.log(item);
    search_show_status.value=false;
    search_data.value=null;
}

//聊天界面显示
function chat_page_show_click(){
    chat_page_show.value=true;
}
//接收子组件关闭消息
function close_chat_page(item){
    console.log(item);
    chat_page_show.value=false;
}

function useravatar_show_btn(){
    var mainpage=document.querySelector('.useravatar');
    document.addEventListener('click', function (event) {
        if (!mainpage.contains(event.target)) {
            header_box_show.value=false;
        }
    });
    if(header_box_show.value==true)
    {
        header_box_show.value=false;
    }
    else{
        header_box_show.value=true;
    }
}

function submission_work_box_show_btn() {
    var mainpage = document.querySelector('.submission');
    document.addEventListener('click', function (event) {
        if (!mainpage.contains(event.target)) {
            submission_work_box_show.value = false;
        }
    });
    if (submission_work_box_show.value == false) {
        submission_work_box_show.value = true;
    }
    else {
        submission_work_box_show.value = false;
    }
}

function switch_show_sidebar() {
    var step_len = 250 / 60;//步长
    var step = 60;//步数
    var mainpage = document.getElementById("sidebar");//包含元素的框
    var show_btn = document.querySelector(".show_more");
    document.addEventListener('click', function (event) {
        if (!mainpage.contains(event.target) && !show_btn.contains(event.target)) {
            animation_sidebar(0, -250, step_len, step, do_time);
        }
    });
    var do_time = 100;
    console.log('test');
    if (show_sidebar.value == false) {
        animation_sidebar(-250, 0, step_len, step, do_time);

        console.log('true');
    } else {
        animation_sidebar(0, -250, step_len, step, do_time);

        console.log('false');
    }
}

function animation_sidebar(startlo, endlo, step_len, step, do_time) {
    if (startlo >= endlo) {
        var count = 0;
        var interval = do_time / step; // 计算每步的时间间隔

        // eslint-disable-next-line no-inner-declarations
        function animate1() {
            if (count >= step) {
                action_left.value = 'left:' + (-250) + 'px;';

                show_sidebar.value = false;
                return;
            }
            action_left.value = 'left:' + (startlo - step_len * count) + 'px;';

            count++;
            setTimeout(animate1, interval);
        }
        animate1();
    }
    if (startlo <= endlo) {
        var count_1 = 0;
        var interval_1 = do_time / step;
        // eslint-disable-next-line no-inner-declarations
        function animate2() {
            if (count_1 >= step) {
                action_left.value = 'left:' + (0) + 'px;';
                show_sidebar.value = true;
                return;
            }
            show_sidebar.value = true;
            action_left.value = 'left:' + (startlo + step_len * count_1) + 'px;';
            count_1++;
            setTimeout(animate2, interval_1);
        }
        animate2();
    }

}



</script>

<style scoped>
/*通用样式*/
.mt {
    margin-top: 5px;
}

.ml {
    margin-left: 5px;
}

.mr {
    margin-right: 5px;
}

.mb {
    margin-bottom: 5px;
}

.pt {
    padding-top: 5px;
}

.pl {
    padding-left: 5px;
}

.pr {
    padding-right: 5px;
}

.pb {
    padding-bottom: 5px;
}

/*作品上传框*/
.submission_work_box {
    display: flex;
    width: 200px;
    min-height: 150px;
    height: auto;
    
    position: absolute;
    top: 50px;
    overflow: hidden;
    background-color: rgba(211, 211, 211, 1);
    border-radius: 15px;
    z-index: 10;
}

.submission_work_box:hover {
    cursor: auto !important;
}

/*侧边栏样式*/
.sidebar {
    width: 210px;
    height: 100%;
    
    position: fixed;
    top: 60px;
    z-index: 2;
    transition: left 0.2s ease;
    /* 添加过渡效果 */
    transition: right 0.2s ease;
}


/*加入会员文字样式*/
.join_vip {
    font-size: 16px;
    color: rgb(253, 158, 22);
    align-self: center;
    justify-content: center;
    font-weight: bold;
    cursor: pointer;
}

/*用户头像样式*/
.useravatar {
    display: flex;
    
    width: 80px;
    height: 95%;
    align-self: center;
}

.useravatar:hover {
    cursor: pointer;
}

.useravatar_img {
    width: 46px;
    height: 46px;
    
    overflow: hidden;
    border-radius: 50%;
}

.useravatar_img img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.useravatar_icon {
    width: 20px;
    height: 20px;
    overflow: hidden;
    justify-content: center;
    align-items: center;
    align-self: center;
}

.useravatar_icon svg {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

/*通知样式*/
/*消息样式*/
.message,
.notice {
    display: flex;
    width: 35px;
    height: 35px;
    align-items: center;
    overflow: hidden;
    justify-content: center;
    align-self: center;
    position: relative;
}

.message:hover,
.notice:hover {
    background-color: rgba(211, 211, 211, 1);
    border-radius: 50%;
    transition: 0.2s;
    cursor: pointer;
}
.chat_page{
    position: fixed;
    top:0px;
    left: 0px;
    width: 100vw;
    height: 100vh;
    background-color: rgba(255, 255, 255, 1);
    z-index: 10;
}

.message_icon,
.notice_icon {
    width: 80%;
    height: 80%;
    overflow: hidden;
}

.message_icon svg,
.notice_icon svg {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

/*查看更多按钮样式*/
.title {
    display: flex;
    width: 99%;
    height: 50px;
    background-color: rgba(255, 255, 255, 1);
    
    position: relative;
    padding: 5px;
    margin-top: auto;
    margin-bottom: auto;
    margin-left: auto;
    margin-right: auto;
}

.show_more {
    display: flex;
    width: 45px;
    height: 45px;
    align-items: center;
    align-self: center;
}

.show_more_icon {
    width: 80%;
    height: 80%;
    overflow: hidden;
}

.show_more_icon:hover {
    background-color: rgba(211, 211, 211, 1);
    border-radius: 10px;
    transition: 0.2s;
    cursor: pointer;
}

.show_more_icon svg {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

/*主页按钮图片*/
.index_jump_img {
    width: 150px;
    height: 100%;
    overflow: hidden;
    cursor: pointer;
}

.index_jump_img img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

/*搜索框*/
.input_box {
    display: flex;
    position: relative;
    width: 50%;
    height: 90%;
    background-color: rgba(211, 211, 211, 1);
    border: 1px solid rgba(211, 211, 211, 1);
    border-radius: 15px;
    margin-left: auto;
    margin-right: 20px;
    align-items: center;
    align-self: center;
}

.input_box input {
    display: flex;
    width: 90%;
    height: 100%;
    border: none;
    background: transparent;
    align-items: center;
}

.search_icon {
    width: 5%;
    height: 100%;
    overflow: hidden;
    position: absolute;
    right: 5px;
    align-items: center;
    align-self: center;
    cursor: pointer;
}

.search_icon svg {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.submission {
    display: flex;
    width: 100px;
    height: 80%;
    background-color: rgba(211, 211, 211, 1);
    align-items: center;
    align-self: center;
    border-radius: 15px;
    justify-content: center;
    position: relative;
}

.submission:hover {
    background-color: rgba(185, 185, 185, 1);
    cursor: pointer;
    transition: 0.2s;
}

.submission_icon {
    width: 15%;
    height: 100%;
    overflow: hidden;
}

.submission_icon svg {
    width: 100%;
    height: 100%;
    object-fit: cover;
}
</style>

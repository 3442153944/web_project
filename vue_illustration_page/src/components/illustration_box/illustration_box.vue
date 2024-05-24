<template>
    <div class="illustration_box">
        <div class="ill_image">
            <div class="ill_image_box" v-for="(path, index) in ill_img_path" :key="index">
                <img :src="path" @click="show_max_image(path)">

            </div>
            <div class="show_more_btn">
                <div class="more_btn" @click="show_all_img">
                    <span>查看更多</span>
                </div>
            </div>
            <div class="overlay" v-if="max_image_box_is_show" @click="hidden_max_image">
                <div class="max_image_box" ref="max_image_box">
                    <img id="temp_img_box">
                </div>
            </div>
        </div>
        <div class="ill_data">
            <div class="like" style="margin-right: 20px;" @click="like_click"><img :src="like_path" style="margin-right: 5px;"><span><b>赞！</b></span></div>
            <div class="love" style="margin-right: 20px;" @click="love_click"><img :src="love_path"></div>
            <div class="share"><img :src="share_path"></div>
        </div>
        <div class="float_ill_data">
            <div class="like" style="margin-right: 20px;" @click="like_click"><img :src="like_path" style="margin-right: 5px;"><span><b>赞！</b></span></div>
            <div class="love" style="margin-right: 20px;"  @click="love_click"><img :src="love_path"></div>
            <div class="share" @click="share_click"><img :src="share_path"></div>
        </div>
        <div class="work_info">
            <div class="work_title mt ">
                <span><b>{{ work_title }}</b></span>
            </div>
            <div class="work_brief_introduction mt">
                <span>{{ work_brief_introduction }}</span>
            </div>
            <div class="work_details mt">
                <span>{{ work_details }}</span>
            </div>
            <div class="tags mt">
                <span class="age_tag_1" style="color:red;font-size:16px;font-weight:bold;">
                    {{ age_tag }}
                </span>
                <span class="work_tag" v-for="(tag, index) in work_tags" :key="index">
                    #{{ tag }}
                </span>
            </div>
            <div class="interactive mt">
                <img :src="like_path">
                <span class="mr">{{ like_count }}</span>
                <img :src="love_path">
                <span class="mr">{{ love_count }}</span>
                <img :src="show_path">
                <span class="mr">{{ look_count }}</span>
            </div>
            <div class="creat_time mt">
                <span>{{ creat_time }}</span>
            </div>
        </div>
        <div class="user_work_list">
            <div class="user_info">
                <div class="user_avatar">
                    <img :src="user_avatar">
                </div>
                <div class="username">
                    <span>{{ username }}</span>
                </div>
                <div class="following_btn" @click="following_btn_click">
                    <span>{{ following_btn }}</span>
                </div>
            </div>
            <div class="work_list">
                <div class="work_item" v-for="index in 10" :key="index">
                    <div class="item_img">
                        <img :src="work_path">
                    </div>
                    <div class="like_svg">
                        <img :src="work_like_svg_path" class="work_icon">
                    </div>
                    <div class="age_tag">
                        <span>{{ work_age_list[0] }}</span>
                    </div>
                    <div class="page_count">
                        <img :src="page_count_svg_path" class="work_icon">
                        <span>{{ page_count }}</span>
                    </div>
                </div>
                
                
            </div>
            <div class="btn_box">
                <div class="left_btn" @click="scrollTabs(-400)">1</div>
            <div class="right_btn" @click="scrollTabs(400)">1</div>
            </div>
        </div>
        <comment_section_box></comment_section_box>
    </div>
</template>

<script>
import { ref, onMounted, onUnmounted, watch, reactive } from 'vue';
import comment_section_box from '../comment_section_box/comment_section_box.vue';
export default {
    name: 'illustration_box',
    components: {
        comment_section_box,
    },
}
</script>

<script setup>
let ill_img_path = ref(['https://127.0.0.1:4434/image/116883317_p0.png', 'https://127.0.0.1:4434/image/65014220_p0.jpg']);
let max_image_box = ref(null);
let max_image_box_is_show = ref(false);
let work_title = ref('作品标题');
let work_brief_introduction = ref('作品简介');
let work_details = ref('作品详情信息');
let age_tag = ref("R-18");
let work_tags = ref(['标签一', '标签二', '标签三']);
let like_count = ref(114514);
let love_count = ref(1919);
let look_count = ref(8190);
let date = new Date();
let year = date.getFullYear();
let month = date.getMonth() + 1;
let day = date.getDate();
let creat_time = ref(year + '年' + month + '月' + day + '日');
let user_avatar = ref('https://127.0.0.1:4434/image/118839253_p1.jpg');
let username = ref('用户名')
let following_btn = ref('关注');
let work_path = ref('https://127.0.0.1:4434/image/116883317_p0.png');
let work_age_list = ref(['R-18', 'R-18G']);
let page_count = ref('12');

function show_max_image(path) {
    max_image_box_is_show.value = true;
    setTimeout(() => {
        let temp_box = document.getElementById('temp_img_box');
        temp_box.src = path;
    }, 100)

}
function hidden_max_image() {
    max_image_box_is_show.value = false;
}

//初始化图片显示，仅显示一张
function init_img_box() {
    let img_box = document.querySelectorAll('.ill_image_box');
    for (let i = 0; i < img_box.length; i++) {
        if (i == 0) {
            img_box[i].style.display = '';
        }
        else {
            img_box[i].style.display = 'none';
        }
    }
}
onMounted(() => {
    setTimeout(() => {
        init_img_box();
    }, 200)
})
onUnmounted(() => {

})

//显示所有图片
function show_all_img() {
    let img_box = document.querySelectorAll('.ill_image_box');
    let show_more_btn = document.querySelector('.show_more_btn');
    for (let i = 0; i < img_box.length; i++) {
        img_box[i].style.display = '';
    }
    show_more_btn.style.display = 'none';
}

//关注按钮功能实现
function following_btn_click() {
    let server_ip = 'https://127.0.0.1:4434';//等待后端实现
    let btn = document.querySelector('.following_btn');
    if (following_btn.value == '关注') {
        following_btn.value = '已关注';
        /*
        const res=fetch('api/following',{
            method:'post',
            headers:{
                'Content-Type':'application/json'
            },
            body:JSON.stringify({
                user_id:user_id,
                user_name:username,
                folloing:folloing
            })
        })
        */
        btn.style.backgroundColor = 'rgba(133,133,133,1)';
    }
    else if (following_btn.value == '已关注') {
        following_btn.value = '关注';
        btn.style.backgroundColor = 'rgba(0,150,250,1)';
        //服务器处理
        /*
        const res=fetch('api/following',{
            method:'post',
            headers:{
                'Content-Type':'application/json'
            },
            body:JSON.stringify({
                user_id:user_id,
                user_name:username,
                folloing:folloing
            })
        })
        */
    }
}

//滚动效果
//模拟横向滚动效果
function scrollTabs(scrollAmount) {
  const tags = document.querySelector('.work_list');
  const animationDuration = 0.2 * 1000; // 0.5秒转为毫秒
  const fps = 24; // 帧率
  const frameDuration = animationDuration / fps; // 每帧持续时间
  const framesCount = Math.ceil(animationDuration / frameDuration); // 总帧数
  let count = 0;

  function animateScroll() {
    if (count < framesCount) {
      tags.scrollLeft += scrollAmount / framesCount;
      count++;
      requestAnimationFrame(animateScroll);
    }
  }

  animateScroll();
}

//用户作品交互
let server_ip ='https://127.0.0.1:4434/'
let like_path=ref(server_ip+'assets/like.svg');
let love_path=ref(server_ip+'assets/love.svg');
let share_path=ref(server_ip+'assets/share.svg');
let is_like_path=ref(server_ip+'assets/is_like.svg');
let is_love_path=ref(server_ip+'assets/is_love.svg');
let show_path=ref(server_ip+'assets/show.svg');
let page_count_svg_path=ref(server_ip+'assets/page_count.svg');
let work_like_svg_path=ref(server_ip+'assets/work_like.svg');
let no_work_like_svg_path=ref(server_ip+'assets/no_work_like.svg');

function like_click(){
    let like=document.querySelectorAll('.like');
    for(let i=0;i<like.length;i++){
        let path=like[i].querySelector('img').src;
        if(path==like_path.value){
            like[i].querySelector('img').src=is_like_path.value;
            like[i].querySelector('span').style.color='rgba(0,150,250,1)';
        }
        else if(path==is_like_path.value){
            like[i].querySelector('img').src=like_path.value;
            like[i].querySelector('span').style.color='';
        }
    }
}

function love_click(){
    let love=document.querySelectorAll('.love');
    for(let i=0;i<love.length;i++){
        let path=love[i].querySelector('img').src;
        if(path==love_path.value){
            love[i].querySelector('img').src=is_love_path.value;  
        }
        else if(path==is_love_path.value){
            love[i].querySelector('img').src=love_path.value;
        }
    }
}


//获取页面连接到剪贴板
function share_click(){
    let page_path=window.location.href;
    navigator.clipboard.writeText(page_path);
  alert('页面链接已复制到剪贴板');
}


</script>

<style scoped>
.mt {
    margin-top: 5px;
}

.mr {
    margin-right: 5px;
}
.float_ill_data{
    display: flex;
    justify-content: flex-end;
}
.float_ill_data img{
    width:25px;
    height: 25px;
    object-fit: cover;
}
.interactive{
    display: flex;
    align-items: center;
}
.interactive  img{
    width:15px;
    height: 15px;
}
.interactive span{
    margin-right: 10px;
    margin-left: 10px;
}

.btn_box{
    display: flex;
    justify-content: space-between;
    align-items: center;
    position: absolute;
    bottom: 0px;
    width: 100%;
    height: 100%;

}
.left_btn{
    display: flex;
    justify-content: center;
    align-items: center;
    left: 0px;
    top:80px;
    width: 50px;
    height: 260px;
    background: linear-gradient(to right, rgba(255, 255, 255, 1), rgba(255, 255, 255, 0));
    opacity: 0;
    position: absolute;
}
.left_btn:hover{
    opacity: 1;
    transform: all 0.3s ease-in-out;
    cursor: pointer;
}
.right_btn{
    display: flex;
    justify-content: center;
    align-items: center;
    right: 0px;
    top:80px;
    width: 50px;
    height: 260px;
    background: linear-gradient(to left, rgba(255, 255, 255, 1), rgba(255, 255, 255, 0));
    opacity: 0;
    position: absolute;
}
.right_btn:hover{
    opacity: 1;
    transform: all 0.3s ease-in-out;
    cursor: pointer;
}

.illustration_box {
    display: flex;
    width: 100%;
    height: auto;
    flex-direction: column;
}

.ill_image {
    display: flex;
    flex-direction: column;
    width: 100%;
    height: auto;
    overflow: hidden;
    position: relative;
}

.ill_image img {
    width: 100%;
    height: auto;
    object-fit: cover;
}

.ill_image_box {
    width: 100%;
    height: auto;
    overflow: hidden;
    margin-top: 10px;
}

.ill_image_box:hover {
    cursor: pointer;
}

.max_image_box {
    width: auto;
    height: auto;
    z-index: 10;
    background-color: rgba(0, 0, 0, 1);
    position: absolute;
    top: 0px;
    left: 0px;
    object-fit: cover;
    cursor: pointer;
}

.overlay {
    width: 100vw;
    height: 100vh;
    background-color: rgba(0, 0, 0, 0.5);
    position: fixed;
    top: 0px;
    left: 0px;
    z-index: 10;
    overflow: auto;
}

.ill_data {
    display: flex;
    justify-content: flex-end;
    align-items: center;
    width: 100%;
    height: 50px;
}

.ill_data img {
    width: 25px;
    height: 25px;
    object-fit: cover;
}

.work_info {
    display: flex;
    padding: 5px;
    margin-top: 10px;
    flex-direction: column;
}

.work_tag {
    color: rgba(0, 150, 250, 1);
    margin-right: 5px;
    font-size: 16px;
    font-weight: bold;
}

.show_more_btn {
    display: flex;
    justify-content: center;
    width: 100%;
    height: 100px;
    margin: 0 auto;
    background: linear-gradient(to top, rgba(255, 255, 255, 1), rgba(255, 255, 255, 0));
    position: absolute;
    bottom: 0px;
    align-items: center;
}

.more_btn {
    display: flex;
    width: 40%;
    height: 60%;
    border-radius: 25px;
    background-color: rgba(0, 0, 0, 1);
    color: white;
    align-items: center;
    padding-left: 30px;
    padding-right: 30px;
    font-size: 20px;
    font-weight: bold;
    justify-content: center;
    margin-bottom: 10px;
    cursor: pointer;
}

.user_work_list {
    display: flex;
    flex-direction: column;
    width: 100%;
    height: auto;
    margin-top: 20px;
    position: relative;
}

.user_info {
    display: flex;
    width: auto;
    height: auto;
    padding-left: 20px;
    padding-right: 20px;
}

.user_avatar {
    width: 60px;
    height: 60px;
    display: flex;
    justify-content: center;
    align-items: center;
    border-radius: 50%;
    overflow: hidden;
    margin-right: 10px;
}

.user_avatar img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.username {
    font-size: 18px;
    font-weight: bold;
    display: flex;
    justify-content: center;
    align-items: center;
}

.following_btn {
    display: flex;
    width: 100px;
    height: 50px;
    border-radius: 25px;
    background-color: rgba(0, 150, 250, 1);
    margin-left: 20px;
    justify-content: center;
    align-items: center;
    font-size: 18px;
    font-weight: bold;
    color: white;
    cursor: pointer;
}

.work_list {
    display: flex;
    width: 100%;
    height: auto;
    min-height: 260px;
    overflow-x: auto;
    white-space: nowrap;
    margin-top: 20px;
    position: relative;
}

.work_item {
    display: flex;
    min-width: 200px;
    min-height: 260px;
    height: 260px;
    width: 200px;
    margin-right: 20px;
    position: relative;
}

.work_item svg {
    width: 25px;
    height: 25px;
    object-fit: cover;
}

.item_img {
    width: 100%;
    height: 100%;
    display: flex;
    border-radius: 15px;
    overflow: hidden;
    justify-content: center;
    align-items: center;
}

.item_img img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.like_svg {
    position: absolute;
    right: 5px;
    bottom: 5px;
    border-radius: 10px;
}
.like,.love,.share{
    display: flex;
    justify-content: center;
    align-items: center;
    overflow: hidden
}
.like img:hover,.love:hover,.share:hover{
    cursor: pointer;
    background-color: rgba(133, 133, 133, 0.5);
    border-radius: 50%;
    transition:all 0.3s ease-in-out;
}


.age_tag {
    position: absolute;
    left: 5px;
    top: 5px;
    font-size: 12px;
    font-weight: bold;
    color: white;
    padding: 5px;
    border-radius: 10px;
    background-color: red;
}

.page_count {
    position: absolute;
    display: flex;
    justify-content: center;
    align-items: center;
    width: 50px;
    height: 30px;
    background-color: rgba(133, 133, 133, 1);
    color: white;
    border-radius: 10px;
    right: 5px;
    top: 5px;
}
.work_icon{
    width: 30px;
    height: 30px;
    object-fit: cover;
}
</style>
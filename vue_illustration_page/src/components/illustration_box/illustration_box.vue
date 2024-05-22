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
            <div class="like" style="margin-right: 20px;">喜欢</div>
            <div class="love" style="margin-right: 20px;">收藏</div>
            <div class="share">分享</div>
        </div>
        <div class="float_ill_data">

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
                <span class="mr">点赞人数：{{ like_count }}</span>
                <span class="mr">收藏人数：{{ love_count }}</span>
                <span class="mr">观看人数：{{ look_count }}</span>
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
                        <svg t="1716389729588" class="icon" viewBox="0 0 1024 1024" version="1.1"
                            xmlns="http://www.w3.org/2000/svg" p-id="1575" width="200" height="200">
                            <path
                                d="M464.213333 657.28l258.56-341.333333 221.226667 179.413333s116.693333 104.106667-122.026667 24.106667c0 0 146.346667 150.613333-66.986666 67.413333 0 0-31.146667 109.44-113.28 58.026667l-112.213334 56.96z"
                                fill="#D8E1F3" p-id="1576"></path>
                            <path
                                d="M533.333333 721.493333l-149.333333-76.16c-82.133333 51.413333-113.28-58.026667-113.28-58.026666-213.333333 83.2-66.986667-67.413333-66.986667-67.413334-238.72 80-122.026667-24.106667-122.026666-24.106666l221.226666-179.413334 256 339.626667z"
                                fill="#D8E1F3" p-id="1577"></path>
                            <path
                                d="M540.8 325.12L512 354.133333l-29.013333-29.013333a149.333333 149.333333 0 0 0-203.733334-7.253333 142.506667 142.506667 0 0 0-1.92 204.373333l33.706667 33.706667 173.866667 173.866666a39.68 39.68 0 0 0 55.893333 0l173.866667-173.866666 32-33.706667a142.72 142.72 0 0 0-2.773334-204.373333 149.333333 149.333333 0 0 0-203.093333 7.253333z"
                                fill="#F4D5E6" p-id="1578"></path>
                            <path
                                d="M411.093333 672.853333l-28.373333-14.506666a74.453333 74.453333 0 0 1-64 8.106666 111.786667 111.786667 0 0 1-55.466667-64c-67.2 25.173333-103.04 28.373333-115.84 10.24-3.84-5.546667-14.933333-21.333333 22.613334-69.973333-96.853333 29.226667-118.186667 19.84-125.866667 6.4-11.52-20.266667 16.853333-48.64 29.44-59.946667l167.893333-136.32 13.44 16.426667-168.106666 135.68c-13.226667 11.733333-25.6 28.586667-24.533334 33.493333 0 0 13.44 11.733333 121.173334-22.826666a14.933333 14.933333 0 0 1 15.786666 23.893333C166.826667 576 161.706667 597.333333 164.266667 599.893333s10.88 13.44 100.906666-21.333333l10.88-4.266667 3.2 11.306667s14.506667 48.853333 46.506667 61.013333a56.32 56.32 0 0 0 50.773333-9.173333l5.12-3.2 39.253334 19.84zM612.906667 672.853333l-9.813334-18.986666 39.253334-19.84 5.12 3.2a56.746667 56.746667 0 0 0 50.986666 9.173333c26.666667-10.24 42.666667-47.573333 46.293334-61.013333l3.2-11.306667 10.88 4.266667c90.24 34.986667 100.48 21.333333 100.906666 21.333333s-2.56-23.253333-34.986666-60.373333a14.933333 14.933333 0 0 1 16-23.893334c106.666667 34.56 120.746667 22.826667 121.386666 21.333334a81.28 81.28 0 0 0-25.386666-33.493334l-167.04-135.68 13.44-16.426666 167.466666 135.893333c13.013333 11.733333 41.386667 40.106667 29.866667 60.373333-7.68 13.44-29.013333 22.826667-125.866667-6.4 37.546667 48.64 26.453333 64 22.613334 69.973334-12.8 18.133333-48.64 14.933333-115.84-10.24a111.786667 111.786667 0 0 1-55.466667 64 74.453333 74.453333 0 0 1-64-8.106667z"
                                fill="#952D2E" p-id="1579"></path>
                            <path
                                d="M512 752.853333a50.346667 50.346667 0 0 1-35.626667-14.72l-207.573333-207.573333a153.386667 153.386667 0 0 1 2.773333-219.733333 160 160 0 0 1 219.093334 7.466666l21.333333 21.333334 21.333333-21.333334a160.213333 160.213333 0 0 1 218.88-7.466666 153.386667 153.386667 0 0 1 2.773334 219.733333l-207.573334 207.573333a50.346667 50.346667 0 0 1-35.413333 14.72z m-137.173333-459.946666a128 128 0 0 0-88.533334 33.493333 132.053333 132.053333 0 0 0-2.56 189.226667l206.933334 207.36a29.013333 29.013333 0 0 0 40.96 0l207.573333-207.36a132.053333 132.053333 0 0 0-2.56-189.226667 139.946667 139.946667 0 0 0-189.013333 7.04L512 369.92l-36.48-36.48a142.506667 142.506667 0 0 0-100.693333-40.533333z"
                                fill="#952D2E" p-id="1580"></path>
                        </svg>
                    </div>
                    <div class="age_tag">
                        <span>{{ work_age_list[0] }}</span>
                    </div>
                    <div class="page_count">
                        <svg t="1715784414381" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg"
                        p-id="9622" width="200" height="200">
                        <path
                          d="M819.2 128H409.6c-56.32 0-102.4 46.08-102.4 102.4v409.6c0 56.32 46.08 102.4 102.4 102.4h409.6c56.32 0 102.4-46.08 102.4-102.4V230.4c0-56.32-46.08-102.4-102.4-102.4z m51.2 512c0 28.16-23.04 51.2-51.2 51.2H409.6c-28.16 0-51.2-23.04-51.2-51.2V230.4c0-28.16 23.04-51.2 51.2-51.2h409.6c28.16 0 51.2 23.04 51.2 51.2v409.6z m-204.8 204.8c0 28.16-23.04 51.2-51.2 51.2H204.8c-28.16 0-51.2-23.04-51.2-51.2V435.2c0-28.16 23.04-51.2 51.2-51.2h51.2v-51.2H204.8c-56.32 0-102.4 46.08-102.4 102.4v409.6c0 56.32 46.08 102.4 102.4 102.4h409.6c56.32 0 102.4-46.08 102.4-102.4v-51.2h-51.2v51.2z"
                          fill="#ccd6de" p-id="9623"></path>
                      </svg>
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
</script>

<style scoped>
.mt {
    margin-top: 5px;
}

.mr {
    margin-right: 5px;
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
    width: 80%;
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
</style>
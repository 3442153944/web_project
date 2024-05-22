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
                <span class="age_tag" style="color:red;font-size:16px;font-weight:bold;">
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
                    <span>{{username}}</span>
                </div>
                <div class="following_btn" @click="following_btn_click">
                    <span>{{following_btn}}</span>
                </div>
            </div>
            <div class="work_list">
                <div class="work_item">
                    <div class="item_img">
                        <img :src="work_path">
                    </div>
                    <div class="like_svg">

                    </div>
                    <div class="age_tag">
                        <span>{{ work_age_list[0] }}</span>
                    </div>
                    <div class="page_count">
                        <span>{{ page_count }}</span>
                    </div>
                </div>
            </div>
        </div>

    </div>
</template>

<script>
import { ref, onMounted, onUnmounted, watch, reactive } from 'vue'
export default {
    name: 'illustration_box',
    components: {

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
let work_path=ref('https://127.0.0.1:4434/image/116883317_p0.png');
let work_age_list=ref(['R-18','R-18G']);
let page_count=ref('12');

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
function following_btn_click(){
    let server_ip='https://127.0.0.1:4434';//等待后端实现
    let btn=document.querySelector('.following_btn');
    if(following_btn.value=='关注'){
        following_btn.value='已关注';
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
        btn.style.backgroundColor='rgba(133,133,133,1)';
    }
    else if (following_btn.value=='已关注'){
        following_btn.value='关注';
        btn.style.backgroundColor='rgba(0,150,250,1)';
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
</script>

<style scoped>
.mt {
    margin-top: 5px;
}

.mr {
    margin-right: 5px;
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
}
.user_info{
    display: flex;
    width: auto;
    height: auto;
    padding-left: 20px;
    padding-right: 20px;
}
.user_avatar{
    width: 60px;
    height: 60px;
    display: flex;
    justify-content: center;
    align-items: center;
    border-radius: 50%;
    overflow:hidden;
    margin-right: 10px;
}
.user_avatar img{
    width:100%;
    height: 100%;
    object-fit: cover;
}
.username{
    font-size: 18px;
    font-weight: bold;
    display: flex;
    justify-content: center;
    align-items: center;
}
.following_btn{
    display: flex;
    width: 100px;
    height: 50px;
    border-radius: 25px;
    background-color: rgba(0,150,250,1);
    margin-left: 20px;
    justify-content: center;
    align-items: center;
    font-size: 18px;
    font-weight: bold;
    color: white;
    cursor: pointer;
}
.work_list{
    display: flex;
    width:100%;
    height: auto;
    min-height: 260px;
    overflow-x:auto ;
    white-space: nowrap;
    margin-top: 20px;
}
.work_item{
    display: flex;
    min-width: 200px;
    min-height: 260px;
    height: 260px;
    width: 200px;
    margin-right: 20px;
    position: relative;
}
.work_item svg{
    width: 25px;
    height: 25px;
    object-fit: cover;
}
.item_img{
    width: 100%;
    height: 100%;
    display: flex;
    border-radius: 15px;
    overflow: hidden;
    justify-content: center;
    align-items: center;
}
.item_img img{
    width:100%;
    height: 100%;
    object-fit: cover;
}
.like_svg{
    position: absolute;
    right: 5px;
    bottom: 5px;
    border-radius: 10px;
}
.age_tag{
    position: absolute;
    left:5px;
    top:5px;
    font-size: 12px;
    font-weight: bold;
    color: white;
    padding: 5px;
    border-radius: 10px;
    background-color: red;
}
.page_count{
    position: absolute;
    display: flex;
    justify-content: center;
    align-items: center;
    width: 50px;
    height: 30px;
    background-color:rgba(133,133,133,1) ;
    color: white;
    border-radius: 10px;
    right: 5px;
    top: 5px;
}

</style>
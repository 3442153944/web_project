<template>
    <div class="illustration_box">
        <div class="ill_image">
            <div class="ill_image_box" v-for="(path,index) in ill_img_path" :key="index">
                <img :src="path" @click="show_max_image(path)">
                
            </div>
            <div class="overlay" v-if="max_image_box_is_show" @click="hidden_max_image">
                <div class="max_image_box" ref="max_image_box" >
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
                <span><b>{{work_title}}</b></span>
            </div>
            <div class="work_brief_introduction mt">
                <span>{{work_brief_introduction}}</span>
            </div>
            <div class="work_details mt">
                <span>{{work_details}}</span>
            </div>
            <div class="tags mt">
                <span class="age_tag" style="color:red;font-size:16px;font-weight:bold;">
                    {{age_tag}}
                </span>
                <span class="work_tag" v-for="(tag,index) in work_tags" :key="index">
                    #{{tag}}
                </span>
            </div>
            <div class="interactive mt">
                <span class="mr">点赞人数：{{like_count}}</span>
                <span class="mr">收藏人数：{{love_count}}</span>
                <span class="mr">观看人数：{{look_count}}</span>
            </div>
            <div class="creat_time mt">
                <span>{{creat_time}}</span>
            </div>
        </div>
        <div class="user_work_list">
            <div class="user_info">
                <div class="user_avatar"></div>
                <div class="username"></div>
                <div class="following_btn"></div>
            </div>
            <div class="work_list">
                <div class="work_item">
                    <div class="item_img">
                        <img>
                    </div>
                    <div class="like_svg">

                    </div>
                </div>
            </div>
        </div>
        
    </div>
</template>

<script>
import {ref,onMounted,onUnmounted,watch,reactive} from 'vue'
export default{
    name:'illustration_box',
    components:{

    },
}
</script>

<script setup>
let ill_img_path=ref(['https://127.0.0.1:4434/image/116883317_p0.png','https://127.0.0.1:4434/image/65014220_p0.jpg']);
let max_image_box=ref(null);
let max_image_box_is_show=ref(false);
let work_title=ref('作品标题');
let work_brief_introduction=ref('作品简介');
let work_details=ref('作品详情信息');
let age_tag=ref("R-18");
let work_tags=ref(['标签一','标签二','标签三']);
let like_count=ref(114514);
let love_count=ref(1919);
let look_count=ref(8190);
let date=new Date();
let year=date.getFullYear();
let month=date.getMonth()+1;
let day=date.getDate();
let creat_time=ref(year+'年'+month+'月'+day+'日');
let user_avatar=ref('https://127.0.0.1:4434/image/118839253_p1.jpg');
let username=ref('用户名')
let following_btn=ref('关注');

function show_max_image(path){
    max_image_box_is_show.value=true;
    setTimeout(()=>{
        let temp_box=document.getElementById('temp_img_box');
        temp_box.src=path;
    },100)
        
}
function hidden_max_image(){
    max_image_box_is_show.value=false;
}
</script>

<style scoped>
.mt{margin-top:5px;}.mr{margin-right: 5px;}
    .illustration_box{
        display: flex;
        width: 80%;
        height: auto;
        flex-direction: column;
    }
    .ill_image{
        display: flex;
        flex-direction: column;
        width: 100%;
        height: auto;
        overflow: hidden;
    }
    .ill_image img{
        width: 100%;
        height: auto;
        object-fit: cover;
    }
    .ill_image_box{
        width:100%;
        height: auto;
        overflow: hidden;
        margin-top:10px;
    }
    .ill_image_box:hover{
        cursor:pointer;
    }
    .max_image_box{
        width: auto;
        height: auto;
        z-index: 10;
        background-color: rgba(0,0,0,1);
        position: absolute;
        top:0px;
        left:0px;
        object-fit: cover;
        cursor: pointer;
    }
    .overlay{
        width: 100vw;
        height: 100vh;
        background-color: rgba(0,0,0,0.5);
        position: fixed;
        top:0px;
        left:0px;
        z-index: 10;
        overflow: auto;
    }
    .ill_data{
        display: flex;
        justify-content: flex-end;
        align-items: center;
        width:100%;
        height: 50px;
    }
    .work_info{
        display: flex;
        padding:5px;
        margin-top:10px;
        flex-direction: column;
    }
    .work_tag{
        color: rgba(0,150,250,1);
        margin-right: 5px;
        font-size: 16px;
        font-weight: bold;
    }
    
</style>
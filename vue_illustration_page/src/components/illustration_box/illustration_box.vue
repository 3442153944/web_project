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

        </div>
        <div class="float_ill_data">

        </div>
        <div class="work_info">
            <div class="work_title"></div>
            <div class="work_brief_introduction"></div>
            <div class="work_details"></div>
            <div class="tags">
                <span class="age_tag"></span>
                <span class="work_tag"></span>
            </div>
            <div class="interactive"></div>
            <div class="creat_time"></div>
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
    .illustration_box{
        display: flex;
        width: 80%;
        height: auto;
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
        width: 100%;
        height: 100%;
        background-color: rgba(0,0,0,0.5);
        position: fixed;
        top:0px;
        left:0px;
        z-index: 10;
        overflow: auto;
    }
    
</style>
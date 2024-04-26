<!-- eslint-disable no-undef -->
<template>
  <div class="comment_box">
    <div class="user_avatar">
        <img :src="avatar_src">
    </div>
    <div class="cotent_box">
        <div class="username mt"><span>{{username}}</span></div>
        <div class="content mt"><span>{{text}}</span></div>
        <div class="time mt">
            <span>{{time}}</span>
            <span class="reply">回复</span>
        </div>
        <reply_box class="mt"></reply_box>
    </div>
    
  </div>
</template>

<script lang="ts">
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted } from 'vue';
import reply_box from './reply_box.vue'
export default {
    props1:['message'],
    components:{reply_box},
  name: 'comment_box',
}
</script>

<script setup lang="ts">
// eslint-disable-next-line no-unused-vars, no-undef
const props=defineProps(['message']);
const text=ref(props.message);
watch(()=>props.message ,(newvalue)=>{text.value=newvalue})

let avatar_src=ref('../../../../image/104705167_p0.jpg');
let username=ref('用户名');
let time=ref('2024年4月26日');
</script>

<style scoped>
  /*通用样式*/
  .mt{margin-top:5px;}.mb{margin-bottom: 5px;}.ml{margin-left: 5px;}.mr{margin-right: 5px;}.pt{padding-top: 5px;}.pb{padding-bottom: 5px;}.pl{padding-left: 5px;}.pr{padding-right: 5px;}
.comment_box{
    display: flex;
    width:100%;
    height: auto;
    min-height: 80px;
    border:1px solid red;
   
}
.user_avatar{
    display: flex;
    width:50px;
    height:50px;
    overflow: hidden;
    border-radius: 50%;
    margin-top:20px;
}
.user_avatar img{
    width:100%;
    height:100%;
    object-fit: cover;
}
.cotent_box{
    display: flex;
    flex-direction: column;
    flex-grow: 1;
    width:auto;
    height: auto;
    margin-left: 10px;
}
.content{
    width:100%;
    height: auto;
    max-width: 60vw;
    word-wrap: break-word;
}
.reply{
    color: #409eff;
    cursor: pointer;
    margin-left: 10px;
    font-size: 12px;
    font-weight: 600;
}
.reply:hover{
    opacity: 0.8;
}
</style>
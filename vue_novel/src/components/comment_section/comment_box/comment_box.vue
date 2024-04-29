<!-- eslint-disable no-undef -->
<template>
  <div class="comment_box" :style="sub_reply_style">
    <div class="user_avatar">
        <img :src="avatar_src">
    </div>
    <div class="cotent_box">
        <div class="username mt"><span>{{username}}</span></div>
        <div class="content mt"><span v-for="(item,index) in main_msgarr" :key="index">{{item}}</span></div>
        <div class="time mt">
            <span>{{time}}</span>
            <span class="reply" @click="s_reply_show">{{repley_text}}</span>
        </div>
        <reply_box class="mt" v-show="reply_show" @messages="update_msg" @click-message="update_msg_click"></reply_box>
    </div>
    
  </div>
</template>

<script lang="ts">
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted, type ,DefineProps,defineEmits } from 'vue';
import reply_box from './reply_box.vue'
export default {
    props:['message','main_msgarr','sub_msgarr'],
    components:{reply_box},
  name: 'comment_box',
}
</script>

<script setup lang="ts">
// eslint-disable-next-line no-unused-vars, no-undef
/*const props1=defineProps(['message']);
const text=ref(props1.message);
watch(()=>props1.message ,(newvalue)=>{text.value=newvalue})*/

let avatar_src=ref('../../../../image/104705167_p0.jpg');
let username=ref('用户名');
let time=ref('2024年4月26日');
let repley_text=ref('回复');
let reply_show=ref(false);
let messages=ref();
let is_sub=ref(0);
let sub_reply_style=ref({});
let emit_msg1=defineEmits(['messages','click_message']);
//获取用户名
function get_username(){
    fetch('/api/get_userinfo',{
        method:'POST',
        headers:{
            'Content-Type':'application/json'
        },
    })
    .then(res=>res.json())
    .then(data=>{
        username.value=data.username.toString();
       
    })
}
onMounted(()=>{get_username();})

function update_msg(msg_text){
    messages.value=msg_text;
    console.log('sub1'+messages.value)
    is_sub.value=1;
    emit_msg1('messages',messages.value);
}
function update_msg_click(click_message){
    emit_msg1('click_message',click_message);
    console.log('来自sub1传递sub2的点击消息');
}
function s_reply_show(){
    if(reply_show.value==false)
    {
        reply_show.value=true;
        repley_text.value='收起';
    }
    else{
        reply_show.value=false;
        repley_text.value='回复';
    }
}


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
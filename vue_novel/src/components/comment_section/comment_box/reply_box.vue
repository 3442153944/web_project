<template>
  <div class="reply_box">
    <div class="user_avatar">
        <img :src="avatar_src">
    </div>
    <div class="input" ref="input" :style="{height:input_height+'px'}"><textarea placeholder="请注意友善哦" v-model="message" ref="textarea"></textarea></div>
    <div class="send_button" @click="send_message"><span>发送</span></div>
  </div>
</template>

<script lang="ts">
// eslint-disable-next-line no-unused-vars
import { emit } from 'process';
import { ref, reactive, toRefs, watch, onMounted, onUnmounted ,defineEmits} from 'vue';
import comment_box from './comment_box.vue';
export default {
  name: 'reply_box',
  
}
</script>

<script setup lang="ts">
let avatar_src=ref('../../../../image/104705167_p0.jpg');
let input=ref<HTMLTextAreaElement|null>(null);
let textarea=ref<HTMLTextAreaElement|null>(null);
let input_height=ref(30);
let message=ref('');
function auto_height(){
    let content=textarea.value.value;
    let main_width=input.value.clientWidth;
    let font_width=get_fontwidth(content);
    let max_line=Math.ceil(main_width/font_width);
    let text_len=content.length;
    if(text_len>=max_line)
    {
        input_height.value=18*1.5*Math.ceil(text_len/max_line)-16.5;
    }
    else if(text_len<=max_line)
    {
        input_height.value=30;
    }
}
function get_fontwidth(text){
    var font_width;
    const span=document.createElement('span');
    span.style.fontFamily='Microsoft YaHei';
    span.style.fontSize='18px';
    span.textContent=text;
    span.style.visibility='hidden';
    span.style.position='absolute';
    span.style.whiteSpace='nowrap';
    document.body.appendChild(span);
    font_width=span.getBoundingClientRect().width;
    document.body.removeChild(span);
    return font_width/text.length;
}
onMounted(()=>{
    textarea.value.addEventListener('input',auto_height);
    window.addEventListener('resize',auto_height);
})
let msg_arr=ref(['']);
let emit_msg=defineEmits(['update:messages']);
function send_message(){
  
    if(message.value.length>0)
    {
        msg_arr.value.push(message.value);
        message.value='';
        emit_msg('update:messages',msg_arr.value);
    }
}
</script>

<style scoped>
  .reply_box{
    display: flex;
    width:100%;
    height: 60px;
    margin-top:30px;
    border:1px solid red;
    align-self: center;
    justify-content: space-between;
  }
  .user_avatar{
    width: 40px;
    height: 40px;
    border-radius: 50%;
    overflow: hidden;
    margin-top:10px;
  }
  .user_avatar img{
    width: 100%;
    height: 100%;
    object-fit: cover;
  }
  .input{
    display: flex;
    width:80%;
    height: 30px;
    min-height: 30px;
    margin-left: 20px;
    background-color: rgb(160, 160, 160);
    border-radius: 15px;
    align-self: center;
    line-height: 1.5;
  }
  .input textarea{
    width: 100%;
    height: 100%;
    border: none;
    outline: none;
    resize: none;
    padding: 0 10px;
    font-size: 18px;
    font-family: 'Microsoft YaHei';
    background:transparent;
    color: rgb(255,255,255);
  }
  .send_button{
    width:70px;
    height: 40px;
    background-color: rgba(0,150,250,1);
    border-radius: 15px;
    align-items: center;
    justify-content: center;
    display: flex;
    align-self: center;
  }
  .send_button:hover{
    cursor: pointer;
    opacity: 0.8;
  }
  
</style>
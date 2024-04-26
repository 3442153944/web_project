<template>
    
    <div class="comment_section">
        <h1 class="section_title">评论</h1>
        <div class="section_content">
            <div class="user_avatar"><img :src="user_avatar_img"></div>
            <div class="user_input_box">
                <div class="user_input" ref="user_input"><textarea placeholder="请友善的评论哦"
                    v-model="message"
                     ref="input_box_1" id="input_box_1" :style="{height:auto_height+'px','min-height':min_height+'px'}"></textarea></div>
                <div class="user_input_btn" @click="send_msg">发送</div>
            </div>
        </div>
        <div class="root_comment_box" v-for="(main_item,main_index) in main_msgarr" :key="main_index"><comment_box :message="get_message" :main_msgarr="main_item"></comment_box>
            <div class="sub_comment_box"><comment_box :message="get_message" :main_msgarr="sub_message" @update:messages="update_msg"></comment_box></div>
           
        </div>
        
    </div>
</template>
<script lang="ts">
// eslint-disable-next-line no-unused-vars
import { ref,onMounted,onUnmounted } from 'vue';
import comment_box from './comment_box/comment_box.vue'

export default {
    name: 'comment_section',
    components:{
        comment_box,
    },
    data(){
        return {
           
        }
    },
}
</script>
<script setup lang="ts">
//自动拓宽逻辑
let user_avatar_img=ref('../../../image/87328997_p0.jpg');
let auto_height=ref('auto');
let user_input=ref<HTMLTextAreaElement|null>(null);
let input_box_1=ref<HTMLTextAreaElement|null>(null);
let min_height=ref(50);
let get_message=ref('');
function auto_text_h(){
    if(user_input.value){
        var width=user_input.value.offsetWidth;
        var heigth=user_input.value.offsetHeight;
        var content_text=input_box_1.value?.value;
        get_message.value=content_text;
        var line_height=18*1.5;
        let text_len=content_text?.length;
        let font_width=get_fontwidth(content_text);
        let max_line=Math.floor(width/font_width);
       if(text_len>=max_line){
        auto_height.value='auto';
        min_height.value=line_height*Math.ceil(text_len/max_line)-18.5;
       }
       else if(text_len<=max_line)
      min_height.value=40;
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
//计算方差


onMounted(()=>{
    auto_text_h();
    input_box_1.value?.addEventListener('input',()=>{
        auto_text_h();
    });
    window.addEventListener('resize',()=>{
        auto_text_h();
    });
})

//评论发送逻辑
let main_msgarr=ref(['消息1']);
let sub_msgarr=ref(['消息2']);
let message=ref('');
//主评论发送逻辑
function send_msg(){
    main_msgarr.value.push(get_message.value);
    message.value='';
    console.log(main_msgarr.value);
}
//子评论发送逻辑
let sub_message=ref('');
function update_msg(msg_text){
    sub_message.value=msg_text;
}
</script>
<style  scoped>
.comment_section{
    display: flex;
    margin-top:20px;
    padding:5px;
    width:80%;
    margin-left:auto;
    margin-right: auto;
    border:1px solid red;
    border-radius: 10px;
    background-color: rgba(233,233,233,1);
    flex-direction: column;
}
.section_title{
    display: flex;
    margin-top:5px;

}
.user_avatar{
    display: flex;
    width:50px;
    height: 50px;
    overflow: hidden;
    border-radius: 50%;
}
.user_avatar img{
    width:100%;
    height: 100%;
    object-fit: cover;
}
.section_content{
    display: flex;
    width:100%;
    min-height: 50px;
    height: auto;
    align-items: center;
    margin-top:5px;
    padding:5px;
    position: relative;
    border:1px solid red;
    justify-content: space-between;
}
.user_input_box{
    display: flex;
    align-items: center;
    margin-left:10px;
    margin-right: 10px;
    padding:5px;
    width:90%;
}
.user_input{
    display: flex;
    width:100%;
    height:auto;
    min-height: 40px;
    background-color: rgba(211,211,211,1);
    border-radius: 15px;
    overflow: hidden;
}
.user_input textarea{
    width:100%;
    height: auto;
    border:none;
    margin-top:auto;
    margin-bottom:auto;
    outline: none;
    resize: none;
    background:transparent;
    font-size: 18px;
    line-height: 1.5;
    overflow-y: hidden;
}
#input_box_1::placeholder{
    display: flex;
    align-content: center;
    align-items: center;
    margin-top:auto;
    margin-bottom:auto;
}
.user_input_btn{
    display: flex;
    width:100px;
    height: 40px;
    align-items: center;
    margin-left: 20px;
    background-color: rgba(0,150,250,1);
    border-radius: 25px;
    align-items: center;
    justify-content: center;
}
.user_input_btn:hover{
    cursor: pointer;
    background-color: rgba(0,150,250,0.8);
}
.root_comment_box{
    display: flex;
    margin-top: 10px;
    width:90%;
    flex-direction: column;
    height: auto;
}
.sub_comment_box{
    display: flex;
    margin-left: 50px;
    height: auto;
}
</style>
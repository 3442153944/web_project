<template>
    
    <div class="comment_section">
        <h1 class="section_title">评论</h1>
        <div class="section_content">
            <div class="user_avatar"><img :src="user_avatar_img"></div>
            <div class="user_input_box">
                <div class="user_input"><textarea placeholder="请友善的评论哦"></textarea></div>
                <div class="user_input_btn">发送</div>
            </div>
        </div>
    </div>
</template>
<script lang="ts">
import { ref } from 'vue'
export default {
    name: 'comment_section',
    data(){
        return {
           
        }
    },
}
</script>
<script setup lang="ts">
let user_avatar_img=ref('../../../image/87328997_p0.jpg');
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
    height: 50px;
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
    height: 100%;
    background-color: rgba(211,211,211,1);
    border-radius: 15px;
    overflow: hidden;
}
.user_input textarea{
    width:100%;
    height: 90%;
    border:none;
    margin-top:auto;
    margin-bottom:auto;
    outline: none;
    resize: none;
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
</style>
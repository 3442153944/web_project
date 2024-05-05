<template>
  <div class="comment_section">
    <div class="comment_title"><h1>评论区</h1></div>
    <div class="reply_box">
        <div class="reply_useravatar">
            <img :src="senduser_avatar">
        </div>
        <div class="reply_input_box"></div>
        <div class="reply_button"></div>
    </div>
  </div>
</template>

<script>
import { ref, reactive, toRefs, watch, onMounted, onUnmounted } from 'vue';
export default {
  name: 'comment_section_box',
}
</script>

<script setup>
let image_src='http://127.0.0.1:11451/image/'
let senduser_avatar=''
function set_senduser_avatar(){
    senduser_avatar=image_src+get_cookie('user_avatar')
    console.log(senduser_avatar)
    return senduser_avatar;
}
onMounted(()=>{
    set_senduser_avatar()
})


function get_cookie(name) {
    let cookies = document.cookie.split('; ')
    for (let i = 0; i < cookies.length; i++) {
        let cookie = cookies[i].split('=');
        if (cookie[0] === name) {
            return cookie[1];
        }
    }
    return null; // Cookie not found
}
async function set_cookie(key, value) {
    expireCookie(key);
    // Get current time
    let now = new Date();

    // Set expiration time to 7 days later
    now.setTime(now.getTime() + 7 * 24 * 60 * 60 * 1000);
    let expires = "expires=" + now.toUTCString();

    // Concatenate new cookie
    let newCookie = key + '=' + value + '; ' + expires;

    // Get current cookies
    let cookies = document.cookie;

    // If the same key already exists, delete the old cookie first
    if (cookies.includes(key + '=')) {
        let cookieArray = cookies.split('; ');
        for (let i = 0; i < cookieArray.length; i++) {
            if (cookieArray[i].startsWith(key + '=')) {
                cookieArray[i] = newCookie;
            }
        }
        document.cookie = cookieArray.join('; ');
    } else {
        // Otherwise, directly set the new cookie
        document.cookie = newCookie;
    }
}
function expireCookie(name) {
    document.cookie = `name=;expires=Thu, 01 Jan 1970 00:00:00 UTC;path=/;`;
}
</script>

<style scoped>
  .comment_section{
    width:85%;
    min-height: 200px;
    border:1px solid red;
    margin-top: 20px;
    display: flex;
    flex-direction: column;
    align-self: center;
    margin-left: auto;
    margin-right: auto;
    background-color: rgba(231, 231, 231, 1);
    padding:5px;
    border-radius: 15px;
  }
  .reply_box{
    display: flex;
    width:100%;
    height: 80px;
    border:1px solid red;
    margin-top:10px;
    justify-content: space-between;
  }
  .reply_useravatar{
    display: flex;
    width:70px;
    height: 70px;
    overflow: hidden;
    border-radius: 50%;
    margin-left: 5px;
    margin-right: 10px;
    margin-top:5px;
    align-items: center;
  }
  .reply_useravatar img{
    width:100%;
    height: 100%;
    object-fit: cover;
  }
</style>
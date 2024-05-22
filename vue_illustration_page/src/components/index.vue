<template>
<div class="index">
    <illustration_box></illustration_box>
    <user_box></user_box>
</div>
</template>
<script>
import {ref,onMounted,onUnmounted,watch} from 'vue';
import illustration_box from './illustration_box/illustration_box.vue'
import user_box from './user_box/user_box.vue'
export default{
    name:'index',
    components:{illustration_box,user_box},
}
</script>
<script setup>
//预设作品ID测试评论区
set_cookie('work_id','1');

//设置cookies
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
.index{
    display: flex;
    width:80%;
    height: auto;
    margin:20px auto;
}
</style>
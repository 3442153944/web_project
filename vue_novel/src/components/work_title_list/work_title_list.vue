<template>
    <div class="work_title_list">
        <div class="show_list_btn" @click="show_list_btn">
            <span>目录</span>
        </div>
        <transition name="fade">
            <div class="title_list" v-show="show_list">
                <div class="title_item" v-for="(item, index) in title_list" :key="index" @click="get_page_title(item)">
                    <span>{{ item }}</span>
                </div>
            </div>
        </transition>
    </div>
</template>

<script>
import { ref, reactive, toRefs, watch, onMounted, onUnmounted } from 'vue';
export default {
    name: 'work_title_list',
}
</script>

<script setup>
let show_list = ref(false);
let title_list = ref([
    '第一章',
    '第二章',
    '第三章',
    '第四章',
    '第五章',
    '第六章',
    '第七章',
    '第八章',
    '第九章',
    '第十章',
    '第十一章',
    '第十二章',
    '第十三章',
    '第十四章',
    '第十五章',
    '第十六章',
    '第十七章',
    '第十八章',
    '第十九章',
    '第二十章',
    '第二十一章',
    '第二十二章',
    '第二十三章',
    '第二十四章',
    '第二十五章',
    '第二十六章',
    '第二十七章',
    '第二十八章',
    '第二十九章',
    '第三十章',
    '第三十一章',
    '第三十二章',
    '第三十三章',
    '第三十四章',
    '第三十五章',
    '第三十六章',
    '第三十七章',
    '第三十八章',
]);
let work_id = ref('0000000001');
function show_list_btn() {
    var main_page=document.querySelector('.title_list');
    show_list.value = !show_list.value;
}
document.addEventListener('click', function(event) {
    var main_page = document.querySelector('.work_title_list');
    var target = event.target;

    // 检查点击位置是否在 main_page 及其子元素之外
    if (!main_page.contains(target)) {
        // 点击位置不在 main_page 及其子元素中，执行收起列表的函数
        show_list.value = false;
    }
});

//获取作品列表及其其他信息
async function get_work_info(){
    const res=await fetch('/api/get_novel_work',{
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            work_id: work_id.value
        })
    })
    const data=await res.json();
    title_list.value=data.work_list;
    console.log(data)
    let author_say=data.work_info[9]
    let age_tag=data.work_info[7]
    let like_num=data.work_info[11]
    let collection_num=data.work_info[12]
    let view_num=data.work_info[13]
    let create_time=data.work_info[10]
    let work_tag=data.work_info[5]
    let work_series=data.work_info[4]
    let work_author_username=data.work_info[2]
    let work_author_id=data.work_info[3]
    let work_cover=data.work_info[8]
    set_cookie('work_author_username', work_author_username);
    set_cookie('work_author_id', work_author_id);
    set_cookie('work_id', work_id.value);
    set_cookie('work_cover', work_cover);
    set_cookie('work_tag', work_tag);
    set_cookie('work_series', work_series);
    set_cookie('work_name', data.work_info[1]);
    set_cookie('author_say', author_say);
    set_cookie('age_tag', age_tag);
    set_cookie('like_num', like_num);
    set_cookie('collection_num', collection_num);
    set_cookie('view_num', view_num);
    set_cookie('create_time', create_time);
}
onMounted(()=>{
    get_work_info();
});

//获取页面标题，设置正文内容
async function get_page_title(title_text)
{
    //通过cookies设置小说标题
    set_cookie('work_title', title_text);
    console.log(title_text)
    console.log(get_cookie('work_title'))
}
async function set_cookie(key, value) {
    expireCookie(key);
    // 获取当前时间
    let now = new Date();

    // 设置过期时间为 7 天后
    now.setTime(now.getTime() + 7 * 24 * 60 * 60 * 1000);
    let expires = "expires=" + now.toUTCString();

    // 拼接新的 cookie
    let newCookie = key + '=' + value + '; ' + expires;

    // 获取当前 cookie
    let cookies = document.cookie;

    // 如果已经存在相同的键，则更新原来的 cookie
    if (cookies.includes(key + '=')) {
        let cookieArray = cookies.split('; ');
        for (let i = 0; i < cookieArray.length; i++) {
            if (cookieArray[i].startsWith(key + '=')) {
                cookieArray[i] = newCookie;
            }
        }
        document.cookie = cookieArray.join('; ');
    } else {
        // 否则直接设置新的 cookie
        document.cookie = newCookie;
    }
}

//清除指定cookies
function expireCookie(name) {
    document.cookie = `${name}=;expires=Thu, 01 Jan 1970 00:00:00 UTC;path=/;`;
}
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

</script>

<style scoped>
/*动画效果*/
.fade-enter-active,
.fade-leave-active {
    transition: opacity 0.2s;
}

.fade-enter,
.fade-leave-to {
    opacity: 0;
}

.work_title_list {
    display: flex;
    flex-direction: column;
    width: auto;
    height: auto;
    z-index: 1;
    background-color: rgba(211, 211, 211, 1);
    padding: 5px;
    border-radius: 10px;
    position: fixed;
}

.show_list_btn {
    display: flex;
    width: 60px;
    height: 20px;
    justify-content: center;
    align-items: center;
    background-color: rgba(243, 243, 243, 1);
    padding: 5px;
    border-radius: 10px;
    z-index: 2;
}

.show_list_btn:hover {
    cursor: pointer;
    transition: 0.2s;
    opacity: 0.6;
}

.title_list {
    display: flex;
    width: 40vw;
    height: auto;
    overflow: auto;
    padding: 5px;
    margin-top: 5px;
    border: 1px solid red;
    background-color: rgba(211, 211, 211, 0.8);
    flex-wrap: wrap;
    max-height: 70vh;
}

.title_item {
    display: flex;
    width: 45%;
    height: 50px;
    max-height: 50px;
    border: 1px solid red;
    border-bottom: 1px solid rgba(255, 255, 255, 1);
    background-color: rgb(233, 233, 233);
    justify-content: center;
    align-items: center;
    text-align: center;
    margin-left: 10px;
    margin-top: 5px;
    overflow: hidden;
}

.title_item:hover {
    cursor: pointer;
    transition: 0.2s;
    opacity: 0.8;
}

.title_item span {
    display: flex;
    width: 100%;
    height: 100%;
    justify-content: center;
    align-items: center;
}
</style>
<template>
    <div class="comment_section">
        <div class="comment_title">
            <h1>评论区</h1>
        </div>
        <div class="reply_box">
            <div class="reply_useravatar">
                <img :src="senduser_avatar">
            </div>
            <div class="reply_input_box" :style="{ hight: reply_input_hight + 'px' }" ref="root_replybox">
                <textarea id="main_reply_input" placeholder="请友善的评论哦"  ref="root_replytextarea" v-model="root_content"></textarea>
            </div>
            <div class="reply_button" @click="send_msg" >
                <span>发送</span>
            </div>
        </div>
        <div class="content_box">
            <div class="main_comment" v-for="(item, index) in main_reply_message" :key="index">
                <div class="main_comment_box">
                    <div class="user_avatar"></div>
                    <div class="user_comment">
                        <div class="username">
                            <span>{{ main_reply_message[index].send_username }}</span>
                        </div>
                        <div class="comment_content">
                            <span>{{ main_reply_message[index].content }}</span>
                        </div>
                        <div class="comment_time">
                            <span>{{ main_reply_message[index].send_time }}</span>
                            <span style="color:royalblue;cursor:pointer;">{{repley_text}}</span>
                        </div>
                        <div class="reply_box">
                            <div class="reply_useravatar">
                                <img :src="senduser_avatar">
                            </div>
                            <div class="reply_input_box" :style="{ hight: reply_input_hight + 'px'}" ref="sub_replybox">
                                <textarea id="main_reply_input" placeholder="请友善的评论哦" ref="sub_replytextarea" v-model="sub_content"></textarea>
                            </div>
                            <div class="reply_button" @click="send_msg">
                                <span>发送</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="sub_reply_box" v-for="(item, index1) in sub_reply_message" :key="index1">
                    <div class="sub_comment_box" v-if="add_sub_comment(main_reply_message[index].send_username,sub_reply_message[index1].send_username,
                    sub_reply_message[index1].main_comment_id,main_reply_message[index].comment_id)">
                        <div class="user_avatar"></div>
                        <div class="user_comment">
                            <div class="username">
                                <span>{{sub_reply_message[index1].send_username}}</span>
                            </div>
                            <div class="comment_content">
                                <span>{{sub_reply_message[index1].content}}</span>
                            </div>
                            <div class="comment_time">
                                <span>{{sub_reply_message[index1].send_time}}</span>
                                <span style="color:royalblue;cursor:pointer;">{{repley_text}}</span>
                            </div>
                            <div class="reply_box">
                                <div class="reply_useravatar">
                                    <img :src="senduser_avatar">
                                </div>
                                <div class="reply_input_box" :style="{ hight: reply_input_hight + 'px'}" ref="sub_replybox">
                                    <textarea id="main_reply_input" placeholder="请友善的评论哦" ref="sub_replytextarea" v-model="sub_content"></textarea>
                                </div>
                                <div class="reply_button" @click="send_msg">
                                    <span>发送</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted } from 'vue';
export default {
    name: 'comment_section_box',
}

</script>

<script setup>
let image_src = 'http://127.0.0.1:11451/image/'
let senduser_avatar = ref('');
let reply_input_hight = ref('0');
let main_reply_message = ref([]);
let sub_reply_message = ref([]);
let repley_text = ref('回复');

//回复框ref和v-model绑定
let root_replybox = ref(null);
let root_replytextarea= ref(null);
let root_content=ref('');

//动态渲染回复框元素
let sub_replybox=ref(null);
let sub_replytextarea=ref(null);
let sub_content=ref('');

function set_senduser_avatar() {
    senduser_avatar.value = image_src + get_cookie('user_avatar')
    console.log(senduser_avatar.value)
    return senduser_avatar;
}
function send_msg() {
    console.log(root_content.value)
}
onMounted(() => {
    set_senduser_avatar()
})
//自动调整输入框高度
function auto_resize() {
    let textarea = root_replytextarea.value;
    let textarea_width = textarea.clientWidth;
    let window_height = root_replybox.value.clientHeight;
    let font_height = 16; // 假设字体高度为16px
    let line_spacing = 1.5 * font_height; // 假设行距为字体高度的1.5倍
    let max_text_length_per_line = Math.floor(textarea_width / get_text_width(root_content.value)); //计算平均字符宽度
    let lines = Math.ceil(root_content.value.length / max_text_length_per_line); // 计算输入文字所占的行数
    let new_height = lines * (font_height + line_spacing) * 0.8; // 计算新的输入框高度，假设输入框高度为包括它元素的80%
    if (new_height > window_height) {
        textarea.style.height = new_height + 'px'; // 设置输入框的新高度
    }
    else if (new_height < window_height) {
        textarea.style.height = new_height + 'px';
    }
}

watch(root_content, () => {
    console.log(root_content.value)
    auto_resize()
})

function sub_auto_resize(){
    let textarea = sub_replytextarea.value;
    let textarea_width = textarea[0].clientWidth;
    console.log(textarea)
    let window_height = sub_replybox.value[0].clientHeight;
    console.log(window_height)
    let font_height = 16;
    let line_spacing = 1.5 * font_height;
    let max_text_length_per_line = Math.floor(textarea_width / get_text_width(sub_content.value));
    let lines = Math.ceil(sub_content.value.length / max_text_length_per_line);
    let new_height = lines * (font_height + line_spacing) * 0.8;
    if (new_height > window_height) {
        textarea[0].style.height = new_height + 'px';
    }
    else if (new_height < window_height) {
        textarea[0].style.height = new_height + 'px';
    }
    console.log(new_height)
}
watch(sub_content, () => {
    console.log(sub_content.value)
    sub_auto_resize()
})
//获取输入文字平均宽度
function get_text_width(text) {
    var font_width = 0;
    const span = document.createElement('span');
    span.style.fontFamily = 'Microsoft YaHei';
    span.style.fontSize = '16px';
    span.textContent = text;
    span.style.visibility = 'hidden';
    span.style.position = 'absolute';
    span.style.whiteSpace = 'nowrap';
    document.body.appendChild(span);
    font_width = span.getBoundingClientRect().width;
    document.body.removeChild(span);
    return font_width / text.length;
}

//获取评论区评论列表信息
async function get_comment_list() {
    let work_id = get_cookie('work_id');
    try {
        const res = await fetch('/api/get_comment_section', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                work_id: work_id
            })
        })
        const data = await res.json();
        let comment_id_list = data.comment_id_list;
        let is_root_comment_list = data.is_root_comment_list;
        for (let i = 0; i < comment_id_list.length; i++) {
            if (is_root_comment_list[i] == '是') {
                main_reply_message.value.push({
                    comment_id: comment_id_list[i],
                    send_username: data.send_username_list[i],
                    content: data.content_list[i],
                    send_time: data.date_list[i]
                })
            }
            else if (is_root_comment_list[i] == '否') {
                sub_reply_message.value.push({
                    comment_id: comment_id_list[i],
                    send_username: data.send_username_list[i],
                    content: data.content_list[i],
                    reply_comment_id: data.reply_comment_id_list[i],
                    main_comment_id: data.main_comment_id_list[i],
                    main_comment_index: data.main_comment_index_list[i],
                    send_time: data.date_list[i],
                })
            }
        }
        console.log(data)
        console.log(main_reply_message.value)
        console.log(sub_reply_message.value)
    }
    catch (e) {
        console.log(e)
    }
}
onMounted(() => {
    get_comment_list()
})

function add_sub_comment(main_username,sub_username,main_comment_id,comment_id) {
    if(main_username == sub_username && main_comment_id == comment_id){
    return true
    }
    else{
    return false}
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
// eslint-disable-next-line no-unused-vars
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
.comment_time {
    display: flex;
    margin-top: 5px;
    width: auto;
    min-width: 100px;
    max-width: 250px;
    height: auto;
    min-height: 20px;
    margin-bottom: 5px;
    border: 1px solid red;
    justify-content: space-between;
}

.comment_content {
    display: flex;
    margin-top: 5px;
    width: auto;
    height: auto;
    min-height: 20px;
    border: 1px solid red;
}

.username {
    display: flex;
    margin-top: 5px;
    margin-bottom: 5px;
    width: auto;
    min-width: 60px;
    max-width: 150px;
    height: auto;
    min-height: 20px;
    border: 1px solid red;
}

.user_comment {
    display: flex;
    flex-direction: column;
    width: 90%;
    margin: 0 auto;
    height: auto;
    min-height: 50px;
    border: 1px solid red;
}

.user_avatar {
    width: 60px;
    height: 60px;
    overflow: hidden;
    display: flex;
    border-radius: 50%;
    border: 1px solid red;
}

.user_avatar img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.sub_comment_box {
    display: flex;
    width: 85%;
    height: auto;
    min-height: 50px;
    margin-top: 10px;
    margin-left: 80px;
    border: 1px solid red;
    padding: 5px;
    border-radius: 15px;
    justify-content: space-between;
}
.sub_reply_box{
    display: flex;
    flex-direction: column;
}

.main_comment_box {
    display: flex;
    width: 95%;
    height: auto;
    min-height: 50px;
    margin-top: 10px;
    border-radius: 10px;
    border: 1px solid red;
    padding: 5px;
    justify-content: space-between;
    margin-right: auto;
}

.main_comment {
    display: flex;
    flex-direction: column;
    width: 100%;
    height: 100%;
    border: 1px solid red;
    margin-top: 10px;
}

.content_box {
    display: flex;
    flex-direction: column;
    width: 100%;
    height: 100%;
    border: 1px solid red;
    margin-top: 20px;
    padding: 5px;
}

.comment_section {
    width: 85%;
    min-height: 200px;
    border: 1px solid red;
    margin-top: 20px;
    display: flex;
    flex-direction: column;
    align-self: center;
    margin-left: auto;
    margin-right: auto;
    background-color: rgba(231, 231, 231, 1);
    padding: 5px;
    border-radius: 15px;
}

.reply_box {
    display: flex;
    width: 100%;
    min-height: 80px;
    height: auto;
    border: 1px solid red;
    margin-top: 10px;
    justify-content: space-between;
}

.reply_useravatar {
    display: flex;
    width: 70px;
    height: 70px;
    overflow: hidden;
    border-radius: 50%;
    margin-left: 5px;
    margin-right: 10px;
    margin-top: 5px;
    align-items: center;

}

.reply_useravatar img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.reply_input_box {
    display: flex;
    width: 70%;
    min-height: 70%;
    height: auto;
    border: 1px solid red;
    margin-left: auto;
    margin-right: auto;
    align-items: center;
}

.reply_input_box textarea {
    width: 100%;
    max-height: 80%;
    min-height: 40px;
    border-radius: 15px;
    outline: none;
    resize: none;
    padding: 5px;
    font-size: 16px;
    font-family: 'Microsoft YaHei', sans-serif;
    background-color: rgba(255, 255, 255, 1);
    line-height: 1.5;
    padding: 5px;
    overflow-y: hidden;
}

.reply_button {
    display: flex;
    width: 100px;
    height: 60%;
    min-height: 40px;
    background-color: rgba(0, 150, 250, 1);
    border-radius: 25px;
    justify-content: center;
    align-items: center;
    align-self: center;
    margin-right: 10px;
}

.reply_button:hover {
    cursor: pointer;
    opacity: 0.8;
    transition: 0.2s;
}
</style>
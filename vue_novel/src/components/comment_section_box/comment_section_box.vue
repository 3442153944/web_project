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
                <textarea id="main_reply_input" placeholder="请友善的评论哦" ref="root_replytextarea"
                    v-model="root_content"></textarea>
            </div>
            <div class="reply_button" @click="main_send_msg">
                <span>发送</span>
            </div>
        </div>
        <div class="content_box">
            <div class="main_comment" v-for="(item, index) in main_reply_message" :key="index" ref="main_comment">
                <div v-if="show_main_reply(index)" class="main_reply_box">
                    <div class="main_comment_box">
                        <div class="user_avatar">
                            <img class="user_avatar_img" src="https://127.0.0.1:4434/image/87328997_p0.jpg">
                        </div>
                        <div class="user_comment">
                            <div class="username">
                                <span>{{ main_reply_message[index].send_username }}</span>
                            </div>
                            <span id="comment_id">{{ main_reply_message[index].comment_id }}</span>
                            <div class="comment_content">
                                <span>{{ main_reply_message[index].content }}</span>
                            </div>
                            <div class="comment_time">
                                <span>{{ main_reply_message[index].send_time }}</span>
                                <span style="color:royalblue;cursor:pointer;" @click="show_root_replybox(index)">{{
                                    repley_text }}</span>
                            </div>
                            <div class="reply_box" v-if="root_replybox_show[index]">
                                <div class="reply_useravatar">
                                    <img :src="senduser_avatar">
                                </div>
                                <div class="reply_input_box" :style="{ hight: reply_input_hight + 'px' }"
                                    ref="sub_replybox">
                                    <textarea id="main_reply_input" placeholder="请友善的评论哦" ref="sub_replytextarea"
                                        v-model="sub_content"></textarea>
                                </div>
                                <div class="reply_button"
                                    @click="sub_send_msg(main_reply_message[index].comment_id, main_reply_message[index].comment_id)">
                                    <span>发送</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="sub_reply_box" v-for="(item, index1) in sub_reply_message" :key="index1">
                        <div class="sub_comment_box" v-if="add_sub_comment(main_reply_message[index].send_username, sub_reply_message[index1].send_username,
                            sub_reply_message[index1].main_comment_id, main_reply_message[index].comment_id)"
                            ref="sub_comment_box" v-show="show_sub_replybox_list(index, index1)">

                            <div class="user_avatar">
                                <img class="user_avatar_img" src="https://127.0.0.1:4434/image/87328997_p0.jpg">
                            </div>
                            <div class="user_comment">
                                <div class="username">
                                    <span>{{ sub_reply_message[index1].send_username }}</span>
                                </div>
                                <span id="comment_id">{{ sub_reply_message[index1].comment_id }}</span>
                                <div class="comment_content">
                                    <span>{{ sub_reply_message[index1].content }}</span>
                                </div>
                                <div class="comment_time">
                                    <span>{{ sub_reply_message[index1].send_time }}</span>
                                    <span style="color:royalblue;cursor:pointer;"
                                        @click="show_sub_replybox(index, index1)">{{ repley_text }}</span>
                                </div>
                                <div class="reply_box" v-if="sub_replybox_show[index][index1]">
                                    <div class="reply_useravatar">
                                        <img :src="senduser_avatar">
                                    </div>
                                    <div class="reply_input_box" :style="{ hight: reply_input_hight + 'px' }"
                                        ref="sub_replybox">
                                        <textarea id="main_reply_input" placeholder="请友善的评论哦" ref="sub_replytextarea"
                                            v-model="sub_content"></textarea>
                                    </div>
                                    <div class="reply_button"
                                        @click="sub_send_msg(main_reply_message[index].comment_id, sub_reply_message[index1].comment_id)">
                                        <span>发送</span>
                                    </div>
                                </div>
                            </div>
                            <div class="more_sub_reply" v-if="show_reply_show_btn(index)"
                                @click="show_more_reply_comment(index)">
                                <div class="more_sub_reply_btn">
                                    <span>查看更多回复{{ index1 }}index的值{{ index }}</span>
                                </div>
                            </div>

                        </div>

                    </div>
                    <div class="more_main_reply" v-if="show_more_main_reply_btn(index)">
                        <div class="show_more_reply_btn" @click="show_more_main_reply">
                            <span>查看更多回复</span>
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
let image_src = 'https://127.0.0.1:4434/image/'
let senduser_avatar = ref('');
let reply_input_hight = ref('0');
let main_reply_message = ref([]);
let sub_reply_message = ref([]);
let repley_text = ref('回复');

//回复框ref和v-model绑定
let root_replybox = ref(null);
let root_replytextarea = ref(null);
let root_content = ref('');

//动态渲染回复框元素
let sub_replybox = ref(null);
let sub_replytextarea = ref(null);
let sub_content = ref('');

//显示更多主评论按钮功能实现
let show_more_count = ref(2);
function show_more_main_reply() {
    show_more_count.value += 3;
    //重新初始化子评论显示
    setTimeout(()=>{
        init_sub_reply_list();
        init_sub_reply_hidden();
    },100)
    
}
function show_more_main_reply_btn(index) {
    if (index >= show_more_count.value) {
        return true;
    } else {
        return false;
    }
}
function show_main_reply(index) {
    if (index <= show_more_count.value) {
        return true;
    } else {
        return false;
    }
}

//子评论框显示隐藏功能实现
let sub_reply_show1 = ref([]);
//初始化显示数组，并且返回显示的值
function show_sub_replybox_list(index, index1) {
    if (!sub_reply_show1.value[index]) {
        sub_reply_show1.value[index] = [];
    }

    if (!sub_reply_show1.value[index][index1]) {
        sub_reply_show1.value[index][index1] = { show: true };
    }

    if (index1 >= 1) {
        sub_reply_show1.value[index][index1].show = true;
    }

    return !!sub_reply_show1.value[index][index1].show;
}

//显示更多子评论函数

//子评论一维列表
let sub_reply_list = ref([])
function init_sub_reply_list() {
    var main_page = document.querySelectorAll('.main_reply_box');
    sub_reply_list.value = Array.from(main_page).map(() => 1)
}
//子评论初始化隐藏和展开按钮隐藏
function init_sub_reply_hidden() {
    var main_page = document.querySelectorAll('.main_reply_box');
    for (var i = 0; i < main_page.length; i++) {
        var sub_page = main_page[i].querySelectorAll('.sub_comment_box')
        
        if (sub_page && sub_page.length > 0) {
            for (var j = sub_reply_list.value[i]; j < sub_page.length; j++) {
                sub_page[j].style.display = 'none'
            }
        }
        var sub_show_more_btn = main_page[i].querySelectorAll('.more_sub_reply')
        if (sub_show_more_btn.length > 0 && sub_show_more_btn[0] !== 'undefined'&&sub_page.length <= 1) {
                for(var a=0;a<sub_show_more_btn.length;a++)
                {
                    sub_show_more_btn[0].style.display = 'none';
                }
        }
        else{
            continue;
        }
    }
    console.log('子评论显示列表初始化')
}
/*
setTimeout(()=>{
    init_sub_reply_list();
    init_sub_reply_hidden();
},1000)*/

function show_more_reply_comment(index) {
    let temp = sub_reply_list.value[index];
    sub_reply_list.value[index] += 2;
    var main_page = document.querySelectorAll('.main_reply_box');
    var sub_page = main_page[index].querySelectorAll('.sub_comment_box')
    for (var i = temp; i < sub_page.length && i < sub_reply_list.value[index]; i++) {
        //排除为空的情况
        if (sub_page[i] !== 'undefined') {
            sub_page[i].style.display = ''
        }
        else {
            console.log('空子评论')
            continue;
        }
    }
    //隐藏多余展开按钮
    var sub_show_more_btn = main_page[index].querySelectorAll('.more_sub_reply')
    for(var j=0;j<sub_reply_list.value[index]-1&&j<sub_show_more_btn.length;j++)
    {
        sub_show_more_btn[j].style.display = 'none';
    }
}

//显示更多子评论按钮显示状态函数
function show_reply_show_btn(index) {
    return true;
}

onMounted(() => {
    setTimeout(() => {
        init_sub_reply_list();
        init_sub_reply_hidden();
        console.log(sub_reply_list.value);
    }, 600)
})

function set_senduser_avatar() {
    senduser_avatar.value = image_src + get_cookie('user_avatar')
    console.log(senduser_avatar.value)
    return senduser_avatar;
}
async function main_send_msg() {
    console.log(root_content.value)
    let all_comment_len = main_reply_message.value.length + sub_reply_message.value.length;
    let username = get_cookie('username');
    let is_root_comment = '是';
    let comment_content = root_content.value;
    //获取当前系统时间
    let date = new Date();
    let year = date.getFullYear();
    let month = date.getMonth() + 1;
    let day = date.getDate();
    let hours = date.getHours();
    let minutes = date.getMinutes();
    let seconds = date.getSeconds();
    let send_time = year + '-' + month + '-' + day + ' ' + hours + ':' + minutes + ':' + seconds;
    if (comment_content == '' && comment_content == null) {
        return
    }
    main_reply_message.value.push({
        comment_id: all_comment_len + 1,
        send_username: username,
        content: comment_content,
        send_time: send_time,
        is_root_comment_list: '是'
    })
    let work_id = get_cookie('work_id');
    //连接服务器增加评论
    try {
        let res = await fetch('/api/add_comment_section', {
            method: 'post',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                work_id: work_id,
                is_root_comment: '是',
                send_username: username,
                send_userid: null,
                content: comment_content,
                data: send_time,
                main_username: null,
                main_comment_index: null,
                main_comment_id: null,
                main_userid: null,
                reply_comment_id: null
            }
            )
        })
        const data = await res.json();
        console.log(data.message)
    }
    catch (e) {
        console.log(e)
    }
}
async function sub_send_msg(root, id) {
    console.log(sub_content.value)
    if (sub_content.value == '' && sub_content.value == null) {
        return
    }
    let is_root_comment_list = '否';
    let comment_id = id;
    let username = get_cookie('username');
    let content = sub_content.value;
    let reply_comment_id = id;
    //获取当前系统时间
    let date = new Date();
    let year = date.getFullYear();
    let month = date.getMonth() + 1;
    let day = date.getDate();
    let hours = date.getHours();
    let minutes = date.getMinutes();
    let seconds = date.getSeconds();
    let send_time = year + '-' + month + '-' + day + ' ' + hours + ':' + minutes + ':' + seconds;
    sub_reply_message.value.push({
        comment_id: comment_id,
        send_username: username,
        content: content,
        send_time: send_time,
        is_root_comment_list: is_root_comment_list,
        reply_comment_id: reply_comment_id,
        main_comment_id: root
    })
    console.log(comment_id)
    console.log(sub_reply_message.value)
    let work_id = get_cookie('work_id');
    try {
        let res = await fetch('/api/add_comment_section', {
            method: 'post',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(
                {
                    work_id: work_id,
                    is_root_comment: '否',
                    send_username: username,
                    send_userid: null,
                    content: content,
                    date: send_time,
                    main_comment_index: null,
                    main_comment_id: root,
                    main_username: null,
                    reply_comment_id: reply_comment_id,
                    main_userid: null
                }
            )
        })
        const data = await res.json();
        console.log(data.message)
    }
    catch (e) {
        console.log(e)
    }
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

function sub_auto_resize() {
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

let root_replybox_show = ref([]);
//主回复框显示

//根据主评论长度填充数组为false
function add_root_replybox() {
    var main_boxarr = document.querySelectorAll('.main_comment');
    for (var i = 0; i < main_boxarr.length; i++) {
        root_replybox_show.value[i] = false;
    }
    sub_content.value = '';
    console.log('主评论显示列表初始化');
}
onMounted(() => {
    add_root_replybox()
})

function show_root_replybox(index) {
    set_temparr();
    // 将所有位置都设置为 false
    for (let i = 0; i < root_replybox_show.value.length; i++) {
        if (i !== index) {
            root_replybox_show.value[i] = false;
        }
    }
    // 切换对应索引处的状态
    root_replybox_show.value[index] = !root_replybox_show.value[index];
}

//设置子回复框的显示状态

//事先声明一个足够长度的数组先让所有的评论都能够显示出来，并且隐藏所有的回复框

let sub_replybox_show = ref([]);
function set_temparr() {
    for (let i = 0; i < 100; i++) {
        // 初始化临时数组
        let temp_sub_replybox = [];
        for (let j = 0; j < 100; j++) {
            temp_sub_replybox[j] = false;
        }
        // 将临时数组添加到子回复框显示状态数组中
        sub_replybox_show.value[i] = temp_sub_replybox;
    }
    console.log('子评论显示列表初始化');
}
onMounted(() => {
    set_temparr();
})


let main_comment = ref(null);
let sub_comment_box = ref(null);

function add_subreply_arr() {

    var main_reply = document.querySelectorAll('.main_comment');
    for (var i = 0; i < main_reply.length; i++) {
        var sub_reply = document.querySelectorAll('.main_comment')[i].querySelectorAll('.sub_comment_box');
        let temp_sub_replybox = [];

        for (var j = 0; j < sub_reply.length; j++) {
            temp_sub_replybox.push(false);
            sub_replybox_show.value[i] = temp_sub_replybox;
        }
    }
    add_root_replybox();
}

onMounted(() => {
    setTimeout(() => {
        add_subreply_arr();
    }, 1000);


});


function show_sub_replybox(index, index1) {
    // 切换指定位置的布尔值
    sub_replybox_show.value[index][index1] = !sub_replybox_show.value[index][index1];
    // 将所有位置设置为 false
    for (let i = 0; i < sub_replybox_show.value.length; i++) {
        for (let j = 0; j < sub_replybox_show.value[i].length; j++) {
            if (i !== index || j !== index1) {
                sub_replybox_show.value[i][j] = false;
            }
        }
    }
    sub_content.value = '';
    add_root_replybox();
}
//获取评论用户名列表
function get_username_list() {
    var username_list = document.querySelectorAll('.username');
    var username_list_arr = [];
    for (var i = 0; i < username_list.length; i++) {
        username_list_arr.push(username_list[i].textContent);
    }
    return username_list_arr;
}
onMounted(() => {
    setTimeout(() => {
        set_comment_avatar();
    }, 1500);
})
//根据服务器返回的头像列表设置评论区头像
async function set_comment_avatar() {
    let username_list_arr = get_username_list();
    try {
        let resp = await fetch('/api/get_comment_userAvatar',
            {
                method: 'post',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    username_list_arr: username_list_arr
                })
            }
        )
        const data = await resp.json();
        const user_avatar_list = data.avatar_list;
        console.log(data)
        var avatar_list = document.querySelectorAll('.user_avatar_img');
        for (let i = 0; i < avatar_list.length; i++) {
            avatar_list[i].src = "https://127.0.0.1:4434/image/" + user_avatar_list[i];
        }
    }
    catch (err) {
        console.log(err);
    }
}

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
    }
    catch (e) {
        console.log(e)
    }
}
onMounted(() => {
    get_comment_list()
})

function add_sub_comment(main_username, sub_username, main_comment_id, comment_id) {
    if (main_username == sub_username && main_comment_id == comment_id) {
        return true
    }
    else {
        return false
    }
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
.more_sub_reply {
    display: flex;
    margin-top: 5px;
    margin-right: 5px;
    position: absolute;
    right: 15px;
    bottom: 5px;
}

.more_sub_reply_btn {
    display: flex;
    background-color: rgba(188, 188, 188, 1);
    padding: 5px;
    border-radius: 15px;
    opacity: 0.8;
}

.more_sub_reply_btn:hover {
    opacity: 1;
    cursor: pointer;
    transition: 0.2s;
}

.more_sub_reply span {
    font-size: 12px;
}

.more_main_reply {
    display: flex;
    margin-top: 5px;
    margin-left: 20px;
    margin-bottom: 10px;
    padding: 5px;
    width: 130px;
    height: 30px;
    justify-content: center;
    align-items: center;
    overflow: hidden;

}

.show_more_reply_btn {
    display: flex;
    background-color: rgba(188, 188, 188, 1);
    padding: 5px;
    border-radius: 15px;
    opacity: 0.8;
}

.show_more_reply_btn:hover {
    opacity: 1;
    cursor: pointer;
    transition: 0.2s;
}

.comment_time {
    display: flex;
    margin-top: 5px;
    width: auto;
    min-width: 100px;
    max-width: 250px;
    height: auto;
    min-height: 20px;
    margin-bottom: 5px;

    justify-content: space-between;
}

.comment_content {
    display: flex;
    margin-top: 5px;
    width: auto;
    height: auto;
    min-height: 20px;

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

}

.user_comment {
    display: flex;
    flex-direction: column;
    width: 90%;
    margin: 0 auto;
    height: auto;
    min-height: 50px;

}

.user_avatar {
    width: 60px;
    height: 60px;
    overflow: hidden;
    display: flex;
    border-radius: 50%;

}

.user_avatar_img {
    display: flex;
    width: 100%;
    height: 100%;
}

.user_avatar_img img {
    width: 100%;
    height: 100%;
    object-fit: cover;
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
    margin-left: 80px;
    border-radius: 15px;
    justify-content: space-between;
    position: relative;
    padding: 5px;
    background-color: rgba(240, 240, 240, 1);
    margin-top: 5px;
    margin-bottom: 5px;
    border-radius: 15px;
}

.sub_show_control {
    display: flex;
    width: 100%;
    height: auto;
    min-height: 50px;
    padding: 5px;
    background-color: rgba(240, 240, 240, 1);
    margin-top: 5px;
    margin-bottom: 5px;
    border-radius: 15px;
}

.sub_reply_box {
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
    background-color: rgba(231, 231, 231, 1);
    margin-left: 5px;
    padding: 5px;
    justify-content: space-between;
    margin-right: auto;
    margin-bottom: 5px;
}

.main_comment {
    display: flex;
    flex-direction: column;
    width: 95%;
    height: 100%;
    background-color: rgba(250, 250, 250, 1);
    margin-top: 10px;
    margin-left: auto;
    margin-right: auto;
    border-radius: 15px;
}

.content_box {
    display: flex;
    flex-direction: column;
    width: 100%;
    height: 100%;

    margin-top: 20px;
    padding: 5px;
}

.comment_section {
    width: 85%;
    min-height: 200px;

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
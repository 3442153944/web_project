<template>
  <div class="author_work_info">
    <div class="author_avatar_box">
      <div class="author_avatar">
        <img :src="avatar_src">
      </div>
      <div class="author_name">{{ username }}</div>
    </div>
    <div class="follow_btn mt " :style="follow_backcolor" @click="follow_btn">{{ follow_text }}</div>
    <div class="work_list">
      <div class="list_title">
        <span>其他作品</span>
        <span>查看作品目录</span>
      </div>
      <div class="list_content">
        <span class="hv" style="margin-top:5px;margin-left:5px;" :style="isChoose(name)"
          v-for="(name, index) in work_name" :key="index">
          {{ name }}
        </span>
      </div>
    </div>
    <div class="work_list mt">
      <div class="list_title">
        <span>系列</span>
      </div>
      <div class="list_content">
        <span class="hv" style="margin-top:5px;margin-left:5px;" v-for="(name, index) in series_name"
          :key="index">#&nbsp;{{ index }}&nbsp;{{ name }}</span>
      </div>
    </div>
    <div class="work_list mt">
      <div class="list_title">
        <span>作品tag</span>
      </div>
      <div class="list_content">
        <span class="hv" style="margin-top:5px;margin-left:5px;" v-for="(name, index) in tag_name"
          :key="index">#&nbsp;{{ index }}&nbsp;{{ name }}</span>
      </div>
    </div>
  </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted } from 'vue';
import * as cookies from '../../../../model/cookies.js'
export default {

  name: 'author_box',
}
</script>

<script setup>
let avatar_src = ref('../../../image/87328997_p0.jpg');
let username = ref('用户名');
let follow_text = ref('已关注');
let follow_backcolor = ref('background-color:rgba(188,188,188,1);');
let work_name = ref([]);
let series_name = ref([]);
let tag_name = ref([]);
let list_content_ischoose = ref('');

function isChoose(text) {
  let work_name = getCookie('work_name');
  if (text == work_name) {
    list_content_ischoose = 'background-color:rgba(188,188,188,1);border-radius:5px;'
  }
  else {
    list_content_ischoose = '';
  }
  return list_content_ischoose;
}
function follow_btn() {
  if (follow_text.value == '已关注') {
    follow_text.value = '关注';
    follow_backcolor.value = 'background-color:rgba(0,150,250,1);';
  } else {
    follow_text.value = '已关注';
    follow_backcolor.value = 'background-color:rgba(188,188,188,1);';
  }
}


  //获取作者头像
  async function get_author_avatar() {
    try {
      const res = await fetch('api/UserIdGetAllUserInfo', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          user_id: cookies.get_cookie('work_author_id')
        })
      })
      const data = await res.json()
      if (data.status == 'success') {
        avatar_src.value = "https://127.0.0.1:4434/image/" + data.data[0].user_avatar;
        cookies.set_cookie('work_author_avatar', data.data.user_avatar);
        username.value = cookies.get_cookie('work_author_username');
      }
      else{
        console.log(data.message)
      }
    }
    catch (err) {
      console.log(err);
    }
  }
function set_userinfo() {
  try {
    work_name.value = getCookie('work_list').split(',');
    series_name.value = getCookie('series_list').split(',');
    tag_name.value = getCookie('tag_list').split(',');
  }
  catch (err) {
    console.log(err);
  }
}
onMounted(() => {
  set_userinfo();
  get_author_avatar();
})

//是否已经关注/是否在关注列表中
async function is_follow() {
  try {
    const res = await fetch('/api/is_follow', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        username: getCookie('username'),
        userid: getCookie('userid')
      })
    })
    const data = await res.json()
    if (data.is_follow == 'True') {
      follow_text.value = '已关注';
      follow_backcolor.value = 'background-color:rgba(188,188,188,1);';
    } else {
      follow_text.value = '关注';
      follow_backcolor.value = 'background-color:rgba(0,150,250,1);';
    }
  }
  catch (err) {
    console.log(err);
  }
}
onMounted(() => { is_follow(); })


function getCookie(name) {
  const cookieString = document.cookie;
  const cookies = cookieString.split(';');
  for (let i = 0; i < cookies.length; i++) {
    const cookie = cookies[i].trim();
    // 判断是否为目标 cookie
    if (cookie.startsWith(name + '=')) {
      return cookie.substring(name.length + 1); // 返回 cookie 的值（去掉名称部分）
    }
  }
  return ''; // 如果找不到目标 cookie，则返回空字符串
}

//获取作者作品系列信息
async function get_author_workinfo() {
  try {
    let work_id = getCookie('work_id')
    let work_name = getCookie('work_name')
    const res = await fetch('/api/get_workInfo',
      {
        method: 'post',
        headers: {
          'Content-Type': 'application/json'
        }
        , body: JSON.stringify({
          work_id: work_id,
          work_name: work_name
        })
      }
    )
    const data = await res.json()
    let work_list = data.work_list;
    set_cookie('work_list', work_list);
    let series_list = data.series_list;
    set_cookie('series_list', series_list);
    let tag_list = data.tag_list;
    set_cookie('tag_list', tag_list);
  }
  catch (err) {
    console.log(err);
  }
}
onMounted(() => { get_author_workinfo(); })

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
  document.cookie = `${name}=;expires=Thu, 01 Jan 1970 00:00:00 UTC;path=/;`;
}

</script>

<style scoped>
/*通用样式*/
@charset "utf-8";

.mt {
  margin-top: 5px;
}

.mb {
  margin-bottom: 5px;
}

.ml {
  margin-left: 5px;
}

.mr {
  margin-right: 5px;
}

.pt {
  padding-top: 5px;
}

.pb {
  padding-bottom: 5px;
}

.pl {
  padding-left: 5px;
}

.pr {
  padding-right: 5px;
}

.hv:hover {
  cursor: pointer;
  background-color: rgba(188, 188, 188, 1);
  border-radius: 5px;
}

.author_work_info {
  display: flex;
  flex-direction: column;
  width: 100%;
  height: auto;
}

.author_avatar_box {
  display: flex;
  width: 100%;
  margin-top: 5px;
}

.author_avatar {
  width: 50px;
  height: 50px;
  border-radius: 50%;
  overflow: hidden;
  align-items: center;
  justify-content: center;
}

.author_avatar img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.author_name {
  margin-left: 5px;
  align-self: center;
}

.follow_btn {
  display: flex;
  width: 90%;
  height: 30px;
  border-radius: 15px;
  cursor: pointer;
  justify-content: center;
  align-items: center;
  margin-top: 10px;
  align-self: center;
}

.work_list {
  display: flex;
  flex-direction: column;
  width: 100%;
  height: 150px;
  margin-top: 20px;
  overflow-x: none;
}

.list_title {
  display: flex;
  width: 100%;
  height: auto;
  justify-content: space-between;

}

.list_content {
  margin-top: 20px;
  display: flex;
  flex-direction: column;
  width: 100%;
  overflow-y: auto;
}
</style>
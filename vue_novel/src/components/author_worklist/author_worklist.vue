<template>
  <div class="author_worklist">
    <div class="author_info_box">
      <div class="author_avatar">
        <div class="author_avatar_img">
          <img :src="user_avatar">
        </div>
        <div class="author_name ml mr"><span>{{ username }}</span></div>
        <div class="follow_btn ml mr" @click="switch_follow" :style="{ 'background-color': follow_btn_color }">
          <span>{{ follow_btn_text }}</span></div>
      </div>
      <div class="show_worklist">
        <span>查看作品目录</span>
      </div>
    </div>
    <div class="author_worklist_box">
      <div class="left_btn"></div>
      <div class="author_worklist_item" v-for="(item,index) in work_name_list" :key="index">
        <div class="author_worklist_item_img"><img :src="image_src+work_cover_list[index]"></div>
        <div class="author_worklist_info_box">
          <div class="info_authorsay mt" >{{ author_say_list[index] }}</div>
          <div class="info_title mt">{{ work_name_list[index] }}</div>
          <div class="info_username mt">{{ author_list[index]}}</div>
          <div class="info_tag mt"><span class="age_tag">R{{ age_classification_list[index] }}</span><span class="tags" v-for="(item ,index) in work_tags_list[index].split(',')" :key="index">#{{ item }}</span></div>
          <div class="info_authorsay mt">{{ authorsay2 }}</div>
        </div>
      </div>
      <div class="right_btn"></div>
    </div>
  </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted } from 'vue';
export default {
  name: 'author_worklist',
}
</script>

<script setup>
let username = ref('用户名');
let follow_btn_text = ref('关注');
let follow_btn_color = ref('');
let item_src = ref('../../../image/104705167_p0.jpg');
let user_avatar=ref('../../../image/87328997_p0.jpg');
//图片资源路径
let image_src="https://127.0.0.1:4434/image/"
function switch_follow() {
  if (follow_btn_text.value == '关注') {
    follow_btn_text.value = '已关注';
    follow_btn_color.value = 'rgba(188,188,188,1)';
  } else {
    follow_btn_text.value = '关注';
    follow_btn_color.value = '';
  }
}
let authorsay1 = ref('一些设定集');
let authorsay2 = ref('大家喜欢什么性格的主角');
let title_text = ref('一些新的设定集');
let age_tag_text=ref('R-18');
let tags=ref({
  '1':'中文/中国语/Chinese/',
  '2':'公告',
  '3':'萝莉',
  '4':'裤袜',
  '5':'白裤袜',
});

let work_name_list;
let work_cover_list;
let author_list;
let age_classification_list;
let work_tags_list;
let author_say_list;
//作品信息
async function get_workinfo(){
  let author_username=ref('');
  try{
    const res=await fetch('/api/get_authorNovelList',{
      method:'POST',
      headers:{
        'Content-Type':'application/json'
      },
      body:JSON.stringify(
        {
          author_username:get_cookie('work_author_username'),
          username:get_cookie('user_name'),
          userid:get_cookie('userid')
        }
      )
    })
    const data=await res.json();
    follow_btn_text.value=data.is_follow;
    switch_follow();
    user_avatar.value=image_src+data.author_avatar;
     work_name_list=data.work_name_list;
     work_cover_list=data.work_cover_list;
     author_list=data.author_list;
     age_classification_list=data.age_classification_list;
     work_tags_list=data.work_tags_list;
     author_say_list=data.author_say_list;
  }catch(error){
    console.log(error);
  }
}

onMounted(()=>{
  username.value=get_cookie('work_author_username'),
  get_workinfo();
});
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
/*通用样式*/
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

.author_worklist {
  display: flex;
  width: 85%;
  height: 280px;
  margin-top: 20px;
  margin-left: auto;
  margin-right: auto;
  flex-direction: column;
  padding: 5px;
}

.author_info_box {
  display: flex;
  justify-content: space-between;
  margin-top: 5px;
}

.author_avatar {
  display: flex;
  align-items: center;
}

.author_avatar_img {
  display: flex;
  width: 50px;
  height: 50px;
  overflow: hidden;
  border-radius: 50%;
}

.author_avatar_img img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.follow_btn {
  display: flex;
  width: 80px;
  height: 30px;
  background-color: rgba(0, 150, 250, 1);
  border-radius: 15px;
  justify-content: center;
  align-items: center;
  align-self: center;
}

.follow_btn:hover {
  cursor: pointer;
  background-color: rgba(0, 150, 250, 0.8);
  opacity: 0.8;
}

.author_worklist_box {
  display: flex;
  flex-wrap: nowrap;
  overflow-x: auto;
  width: 100%;
  height: 100%;
  position: relative;
  overflow-y: hidden;
}

.author_worklist_item {
  display: flex;
  width: 600px;
  min-width: 600px;
  height: 85%;
  margin-top: 15px;
  margin-bottom: 5px;
  margin-left: 10px;
  margin-right: 10px;
  background-color: rgba(231,231,231,1);
  border-radius: 15px;
  overflow: hidden;
  padding: 5px;
}

.author_worklist_item_img {
  width: 150px;
  height: auto;
  overflow: hidden;
  border-radius: 5px;
}

.author_worklist_item_img img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.author_worklist_info_box {
  display: flex;
  flex-direction: column;
  flex-grow: 1;
  
  position: relative;
  margin-left: 5px;
  margin-top: 5px;
  padding: 5px;
}
.age_tag{
  color: rgba(255,0,0,1);
  font-size: 18px;
  font-weight: bold;
  margin-left: 5px;
  margin-right: 5px;
}
.tags{
margin-left: 5px;
color:rgba(0, 150, 250, 1);
cursor: pointer;
}
</style>
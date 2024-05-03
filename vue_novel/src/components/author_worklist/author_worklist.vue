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
      <div class="author_worklist_item" v-for="index in 10" :key="index">
        <div class="author_worklist_item_img"><img :src="item_src"></div>
        <div class="author_worklist_info_box">
          <div class="info_authorsay mt" >{{ authorsay1 }}</div>
          <div class="info_title mt">{{ title_text }}</div>
          <div class="info_username mt">{{ username }}</div>
          <div class="info_tag mt"><span class="age_tag">{{ age_tag_text }}</span><span class="tags" v-for="(item ,index) in tags" :key="index">#{{ item }}</span></div>
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

async function get_username(){
    await fetch('/api/get_userinfo',{
        method:'POST',
        headers:{
            'Content-Type':'application/json'
        },
    })
    .then(res=>res.json())
    .then(data=>{
        username.value=data.username.toString();
    })
}
onMounted(()=>{get_username();})

//作品信息
async function get_workinfo(){
  const res=await fetch('/api/get_workInfo',{
    method:'POST',
    headers:{
      'Content-Type':'application/json'
    },
    body:JSON.stringify(
      {
        
      }
    )
  })
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
  border: 1px solid red;
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
  border: 1px solid red;
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
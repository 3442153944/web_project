<template>
  <div class="user_ill_page">
    <div class="title">
      <div class="left_title_content">
        <span>
          <h3>作品</h3>
        </span>
        <div class="ill_count"><span></span></div>
      </div>
      <div class="right_title_content">
        <div class="search_input">
          <img>
          <span>高级搜索</span>
        </div>
      </div>
    </div>
    <div class="tag_list" ref="item_tag_list">
      <div class="tag_item" v-for="(item,index) in tag_list" :key="index" ref="tag_item">
        <span>{{item}}</span>
      </div>
    </div>
    <div class="user_ill_item_list">
      <div class="item">
        <div class="item_img">
          <img>
        </div>
        <div class="ill_title">
          <span></span>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted } from 'vue';
//导入所有包
import * as cookies from '../../../../../model/cookies.js'
export default {
  name: 'user_ill_page',
}
</script>

<script setup>
let username = cookies.get_storage('username');
let user_id = cookies.get_cookie('user_id');
let tag_background_color_list=ref(['rgb(126, 135, 200)','rgb(126, 200, 199)','rgb(200, 126, 181)','rgb(180, 126, 200)','rgb(199, 200, 126)']);
// 请求用户的插画作品列表
let ill_list = ref([]);
let ill_id_list = ref([]);
let tag_list = ref([]);
let tag_item=ref(null);
let item_tag_list=ref(null);
// 获取插画列表的函数
async function set_ill_list() {
  let temp_list = ill_id_list.value;
  ill_list.value = [];
  for (let i = 0; i < temp_list.length; i++) {
    ill_list.value.push(await get_ill_list(temp_list[i]));
  }
}

// 获取单个插画的详细信息
async function get_ill_list(id) {
  try {
    const res = await fetch('api/useIdGetWorkInfo', {
      method: 'post',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        type: "ill",
        ill_id: id
      })
    });
    const data = await res.json();
    if (data.status == 'success') {
      return data.data;
    } else {
      console.log(data.message);
      return null;
    }
  } catch (err) {
    console.log(err);
    return null;
  }
}

// 获取用户的插画ID列表
async function get_ill_id_list() {
  try {
    const res = await fetch('api/getSelectWorkList', {
      method: 'post',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        user_id: user_id,
        username: username
      })
    });
    const data = await res.json();
    if (data.status == 'success') {
      ill_id_list.value = data.data.ill_id;
    } else {
      console.log(data.message);
    }
  } catch (err) {
    console.log(err);
  }
}

//请求标签列表
async function get_tag_list(id) {
  try{
    const res=await fetch('api/GetAllIllustrationInfo',{
      method:'post',
      headers:{
        'Content-Type':'application/json'
      },
      body:JSON.stringify({
        username:cookies.get_storage('username'),
        user_id:cookies.get_cookie('user_id'),
        ill_id:id
      })
    })
    const data=await res.json();
    if(data.status=='success')
    {
      return data.data;
    }
    else{
      console.log(data.message);
      return undefined;
    }
  }
  catch(err){
    console.log(err);
  }
}
async function set_tag_list() {  
  let temp_data = [];  
  for (let i = 0; i < ill_id_list.value.length; i++) {  
    const tag_list = await get_tag_list(ill_id_list.value[i]);  
    if (tag_list) {  
      temp_data.push(tag_list[0].work_tags);  
    }  
  } 
  let merged_tags = [];
  for (let i = 0; i < temp_data.length; i++) {
    merged_tags = merged_tags.concat(temp_data[i].split(/[,，]/).map(tag => tag.trim()));
  }
  merged_tags = merged_tags.filter(tag => tag);
  const unique_tags = [...new Set(merged_tags)];
  tag_list.value = unique_tags;
  return unique_tags;
}

//设置tag的随机颜色
function set_tag_random_color(){
  let color_list_len=tag_background_color_list.value.length;
  let random=Math.floor(Math.random()*color_list_len);
  let tag=tag_item.value;
 for(let i=0;i<tag.length;i++)
 {
  tag[i].style.backgroundColor=tag_background_color_list.value[Math.floor(Math.random()*color_list_len)]
  tag[i].style.color='#fff';
 }
}

// 在组件挂载时调用函数
onMounted(async () => {
  await get_ill_id_list();
  await set_ill_list();
  await set_tag_list();
  set_tag_random_color();
});
</script>

<style scoped>
.user_ill_page{
  width:90%;
  height: auto;
  display: flex;
  flex-direction: column;
  margin:10px auto;
}
.title{
  display: flex;
  width:100%;
  height: auto;
  padding:5px;
  justify-content: space-between;
  align-items: center;
}
.tag_list{
  display: flex;
  width:100%;
  height: auto;
  padding:5px;
  overflow-x: auto;
  white-space: nowrap;
  margin-top:15px;
}
.tag_item{
  display: flex;
  width:auto;
  height: auto;
  padding:5px;
  border-radius: 10px;
  margin-right: 15px;
  margin-left: 15px;
  white-space: break-spaces;
  justify-content: center;
  align-items: center;
  padding-left:15px;
  padding-right: 15px;
  font-size: 16px;
  font-weight: bold;
}
</style>
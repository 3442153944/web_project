<template>
  <div class="user_index_page">
    <div class="set_selected">
      <h2>精选</h2>
      <div class="set_btn" @click="set_select_show">
        <span>设置精选</span>
      </div>
    </div>
    <div class="content_list">
      <div class="item" v-for="(item,index) in user_select_work" :key="index" ref="item" >
        <div class="item_title" >
          <span>{{item.work_type}}</span>
        </div>
        <div class="content_box">
          <div class="img_box">
            <img class="work_img" :src="item.work_cover_img">
          </div>
          <div class="content_info">
            <span>{{item.work_title}}</span>
            <span style="font-size:18px;font-weight:bold;">{{item.work_chapter}}</span>
            <span>{{item.work_brief_introduction}}</span>
            <span>{{item.work_word_count}}</span>
          </div>
        </div>
      </div>
      <div class="add_box_item" @click="show_chose_set_select" v-show="add_box_show">
        <div class="add_img">
          <img :src="add_img">
        </div>
        <div class="add_title">新增精选</div>
      </div>
    </div>
    <set_select @close_set_select="set_select_close_handle" v-if="set_select_close_show"></set_select>
    <chose_project @chose_close_btn_click="chose_show_show_handle" v-if="chose_set_select_show"></chose_project>
  </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted } from 'vue';
import set_select from './set_select.vue'
import chose_project from './chose_project.vue'
import {set_cookie, expireCookie, get_cookie, set_storage, get_storage } from '../../../../../model/cookies.js'
export default {
  name: 'user_index_page',
  components:{
    set_select,chose_project,
  }
}
</script>

<script setup>
set_cookie('username', 'admin')
set_cookie('user_id','f575b4d3-0683-11ef-adf4-00ffc6b98bdb')
set_storage('username', 'admin')
let add_box_show=ref(true);
let item=ref(null);
function add_box_show_handle(){
  let len=item.value.length;
  if(len>2)
  {
    add_box_show.value=false;
  }
  else
  {
    add_box_show.value=true;
  }
}
  onMounted(()=>{
    setTimeout(()=>{
      add_box_show_handle();
      watch(user_select_work.value,()=>{
        add_box_show_handle();
      })
    },200)
  })
  

let user_select_work=ref({
  work_id:0,
  work_title:'作品名称',
  work_type:'作品类型',
  work_chapter:'作品章节',
  work_word_count:'作品字数',
  work_brief_introduction:'作品简介',
  work_cover_img:'65014220_p0.jpg',
})
let server_ip='https://127.0.0.1:4434/'
let add_img=ref(server_ip+'assets/add.svg');


// 请求精选作品列表
async function get_select_work_list() {
  try {
    const res = await fetch('api/getSelectWorkList', {
      method: 'post',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        username: get_storage('username'),
        user_id: get_cookie('user_id')
      }),
    });
    const data = await res.json();
    if (data.status == 'success') {
      const temp_work_info_list = data.data;
      let ill_list = [];
      let work_id = [];
      if (temp_work_info_list.ill_id) {
        ill_list = temp_work_info_list.ill_id;
      }
      if (temp_work_info_list.work_id) {
        work_id = temp_work_info_list.work_id;
      }

      await set_workinfo_list(ill_list, work_id);
    } else if (data.status == 'error') {
      console.log(data.message);
    }
  } catch (err) {
    console.log(err);
  }
}

// 通过ID请求作品信息
async function get_work_info(type, id) {
  try {
    const res = await fetch('api/useIdGetWorkInfo', {
      method: 'post',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        [type]: id,
        type: type === 'ill_id' ? 'ill' : 'work'
      })
    });
    return await res.json();
  } catch (err) {
    console.log(err);
    return null;
  }
}

// 组装work_info_list
function set_work_info_list(type, data_value) {
  let temp = [];
  let data = data_value[0].data;
  for (let i = 0; i < data.length; i++) {
    let temp_obj = {};
    if (type === 'ill') {
      temp_obj.work_cover_img = 'https://127.0.0.1:4434/image/' + data[i].content_file_list.split(',')[0];
      temp_obj.work_type = '插画';
      temp_obj.work_chapter = data[i].name;
      temp_obj.id = data[i].Illustration_id;
      temp_obj.work_brief_introduction=data[i].brief_introduction;
    } else if (type === 'work') {

      temp_obj.work_cover_img = 'https://127.0.0.1:4434/image/' + data[i].work_cover;
      temp_obj.work_type = '小说';
      temp_obj.work_chapter = data[i].work_name;
      temp_obj.id = data[i].work_id;
      temp_obj.work_brief_introduction=data[i].brief_introduction;
    }
    temp.push(temp_obj);
  }
  return temp;
}

// 设置work_info_list
async function set_workinfo_list(ill_list, work_list) {
  let work_info = [];

  for (let i = 0; i < ill_list.length; i++) {
    let info = await get_work_info('ill_id', ill_list[i]);
    if (info) {
      work_info.push(...set_work_info_list('ill', [info]));
    }
  }

  for (let i = 0; i < work_list.length; i++) {
    let info = await get_work_info('work_id', work_list[i]);
    if (info) {
      work_info.push(...set_work_info_list('work', [info]));
    }
  }
  console.log(work_info);
  user_select_work.value=[];
  user_select_work.value = work_info;
  console.log(user_select_work.value);
}

onMounted(()=>{

  get_select_work_list();
  console.log(get_cookie('user_id'));
  console.log(get_storage('username'));
})

//接收精选框关闭消息
let set_select_close_show=ref(false)

//显示精选框
function set_select_show(){
  set_select_close_show.value=true;
}
function set_select_close_handle(tag){
  set_select_close_show.value=tag.value;
}

//选择精选项目组件显示控制
let chose_set_select_show=ref(false);
function show_chose_set_select(){
  chose_set_select_show.value=true;
}
//接收子组件关闭消息
function chose_show_show_handle(tag){
  chose_set_select_show.value=tag.value;
}
</script>

<style scoped>
  .user_index_page {
    display: flex;
    flex-direction: column;
    width: 100%;
    height: auto;
    margin:10px auto;
  }
  .content_list{
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
    margin-top: 20px;
    overflow-x:auto;
    overflow: auto;
  }
  .item{
    display: flex;
    flex-direction: column;
    width: calc(100% / 3 - 40px);
    margin: 5px 20px;
    height: 350px;
    min-height: 300px;
    min-width: 450px;
  }
  .item_title{
    display: flex;
    align-items: center;
    width:100%;
    padding:5px;
  }
  .set_selected{
    display: flex;
    width: 100%;
    height: auto;
    margin-top:10px;
    margin-bottom: 10px;
    justify-content: space-between;
  }
  .set_btn{
    display: flex;
    justify-content: center;
    align-items: center;
    width:auto;
    height: auto;
    height: 40px;
    width:100px;
  }
  .set_btn:hover{
    background-color: rgba(133,133,133,0.6);
    cursor: pointer;
    border-radius: 15px;
    transition: all 0.3s ease-in-out;
  }
  .content_box{
    display: flex;
    justify-content: space-between;
    margin-top: 5px;
    border-radius: 15px;
    overflow: hidden;
    width:100%;
    height: calc(100% - 50px);
    flex: 1;
  }
  .img_box{
    width:40%;
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    border-radius: 15px;
    overflow: hidden;
  }
  .work_img{
    width:100%;
    height: 100%;
    object-fit: cover;
  }
  .content_info{
    display: flex;
    flex-direction: column;
    justify-content: flex-end;
    align-items: flex-start;
    width:auto;
    flex: 1;
  }
  .content_info span{
    margin:20px;
    font-size: 16px;

  }
  .add_box_item{
    width:300px;
    margin-left: 10px;
    margin-right: 10px;
    height: 300px;
    max-height: 350px;
    max-width: 350px;
    box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
    border-radius: 15px;
    display: flex;
    justify-content: center;
    align-items: center;
    background-color: rgba(133,133,133,0.6);
    flex-direction: column;
    margin:auto;
  }
  .add_box_item:hover{
    cursor: pointer;
    background-color: rgba(133,133,133,0.8);
    transition: all 0.3s ease-in-out;
  }
  .add_box_item img{
    width:150px;
    height: 150px;
    object-fit: cover;
  }
</style>
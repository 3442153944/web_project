<template>
  <div class="user_index_page">
    <div class="set_selected">
      <h2>精选</h2>
      <div class="set_btn" @click="set_select_show">
        <span>设置精选</span>
      </div>
    </div>
    <div class="content_list">
      <div class="item">
        <div class="item_title">
          <span>{{user_select_work.work_type}}</span>
        </div>
        <div class="content_box">
          <div class="img_box">
            <img class="work_img" :src="server_ip +'image/'+user_select_work.work_cover_img">
          </div>
          <div class="content_info">
            <span>{{user_select_work.work_title}}</span>
            <span style="font-size:18px;font-weight:bold;">{{user_select_work.work_chapter}}</span>
            <span>{{user_select_work.work_brief_introduction}}</span>
            <span>{{user_select_work.work_word_count}}</span>
          </div>
        </div>
      </div>
      <div class="add_box_item" @click="show_chose_set_select">
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
export default {
  name: 'user_index_page',
  components:{
    set_select,chose_project,
  }
}
</script>

<script setup>
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
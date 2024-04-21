<template>
  <div class="author_work_info">
    <div class="author_avatar_box">
        <div class="author_avatar">
            <img :src="avatar_src">
        </div>
        <div class="author_name">{{username}}</div>
    </div>
    <div class="follow_btn mt " :style="follow_backcolor" @click="follow_btn">{{follow_text}}</div>
    <div class="work_list">
        <div class="list_title">
            <span>其他作品</span>
            <span>查看作品目录</span>
        </div>
        <div class="list_content">
            <span class="hv" style="margin-top:5px;margin-left:5px;" v-for="(name,index) in work_name" :key="index">{{name}}</span>
        </div>
    </div>
  <div class="work_list mt">
    <div class="list_title">
        <span>系列</span>
    </div>
    <div class="list_content">
        <span class="hv" style="margin-top:5px;margin-left:5px;" v-for="(name,index) in series_name" :key="index">#&nbsp;{{index}}&nbsp;{{name}}</span>
    </div>
  </div>
  <div class="work_list mt">
    <div class="list_title">
        <span>作品tag</span>
    </div>
    <div class="list_content">
        <span class="hv" style="margin-top:5px;margin-left:5px;" v-for="(name,index) in tag_name" :key="index">#&nbsp;{{index}}&nbsp;{{name}}</span>
    </div>
  </div>
  </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted } from 'vue';
export default {
    
  name: 'author_box',
}
</script>

<script setup>
let avatar_src='../../../image/87328997_p0.jpg';
let username=ref('用户名');
let follow_text=ref('已关注');
let follow_backcolor=ref('background-color:rgba(188,188,188,1);');
let work_name=ref({
    1:'《三体》',
    2:'露出少女育成计划',
});
let series_name=ref({
    1:'系列一',
    2:"系列二",
    3:"系列三",
    4:"系列四",
    5:"系列五",
    6:"系列六",
    7:"系列七",
    8:"系列八",
    9:"系列九",
    10:"系列十",
});
let tag_name=ref({
    1:'R-18',
    2:'百合',
    3:'少女',
    4:'露出',
    5:'扶她',
    6:'裤袜',
    7:'连裤袜',
    8:'黑丝',
    9:'黑丝袜',
    10:'白裤袜',
});
function follow_btn(){
    if(follow_text.value=='已关注'){
        follow_text.value='关注';
        follow_backcolor.value='background-color:rgba(0,150,250,1);';
    }else{
        follow_text.value='已关注';
        follow_backcolor.value='background-color:rgba(188,188,188,1);';
    }
}
</script>

<style scoped>
/*通用样式*/
@charset "utf-8";
.mt{margin-top:5px;}.mb{margin-bottom:5px;}.ml{margin-left:5px;}.mr{margin-right:5px;}.pt{padding-top:5px;}.pb{padding-bottom:5px;}.pl{padding-left:5px;}.pr{padding-right:5px;}.hv:hover{cursor: pointer;background-color: rgba(188,188,188,1);border-radius: 5px;}
  .author_work_info{
    display: flex;
    flex-direction: column;
    width:100%;
    height: auto;
  }
  .author_avatar_box{
    display: flex;
    width:100%;
    margin-top:5px;
  }
  .author_avatar{
    width:50px;
    height: 50px;
    border-radius: 50%;
    overflow: hidden;
    align-items: center;
    justify-content: center;
  }
  .author_avatar img{
    width:100%;
    height: 100%;
    object-fit: cover;
  }
  .author_name{
    margin-left:5px;
    align-self: center;
  }
  .follow_btn{
    display: flex;
    width: 90%;
    height: 30px;
    border-radius: 15px;
    cursor: pointer;
    justify-content: center;
    align-items: center;
    margin-top:10px;
    align-self: center;
  }
  .work_list{
    display: flex;
    flex-direction: column;
    width:100%;
    height: 150px;
    margin-top:20px;
    overflow-x:none ;
  }
  .list_title{
    display: flex;
    width:100%;
    height: auto;
    justify-content: space-between;

  }
  .list_content{
    margin-top:20px;
    display: flex;
    flex-direction: column;
    width:100%;
    overflow-y:auto ;
  }
</style>
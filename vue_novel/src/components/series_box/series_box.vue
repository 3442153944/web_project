<template>
  <div class="box_content">
    <div class="content_title">系列</div>
    <div class="series_title">{{title}}</div>
    <div class="pervious">#2{{pervious_name}}</div>
    <div class="next">#3{{next_name}}</div>
    <br>
    <div class="join_chasing_f_update_list" @click="updata_list_btn" :style="update_list_back">{{updata_list}}</div>
  </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted } from 'vue';
export default {
  name: 'series_box',
}
</script>

<script setup>
let title=ref('杂事儿，闲扯，设定集');
let pervious_name=ref('《杂事儿，闲扯》');
let next_name=ref('《杂事儿，闲扯》');
let updata_list=ref('加入追更列表');
let update_list_back=ref('background-color:rgb(0,150,250)');
function updata_list_btn(){
    if(updata_list.value=='加入追更列表'){
        updata_list.value='已加入追更列表';
        update_list_back.value='background-color:rgb(188,188,188)';
    }else{
        updata_list.value='加入追更列表';
        update_list_back.value='background-color:rgb(0,150,250)';
    }
}
</script>

<style scoped>
  .box_content{
    display: flex;
    flex-direction: column;
    width:100%;
    height: auto;
    justify-content: center;
    align-items: center;
    align-self: center;
  }
  .series_title{
    font-size: 20px;
    font-weight: bold;
    margin-top: 10px;
  }
  .pervious{
    font-size: 20px;
    margin-top: 10px;
    font-weight: bold;
    border-radius: 15px;
    background-color: rgb(202, 201, 201);
    width:70%;
    height: 40px;
    text-align: center;
    justify-content: center;
    align-items: center;
    display: flex;
    align-self: center;
  }
  .next{
    font-size: 20px;
    margin-top: 10px;
    font-weight: bold;
    border-radius: 15px;
    background-color: rgb(188,188,188);
    width:70%;
    height: 40px;
    text-align: center;
    justify-content: center;
    align-items: center;
    display: flex;
    align-self: center;
  }
  .join_chasing_f_update_list{
    display: flex;
    width:70%;
    height: 40px;
    justify-content: center;
    align-items: center;
    align-self: center;
    border-radius: 15px;
    color: rgb(255, 255, 255);
    font-size: 20px;
    font-weight: bold;
    cursor: pointer;
  }
</style>
<!-- eslint-disable vue/multi-word-component-names -->
<template>
  <div class="sidebar">
    <div class="content">
        <div class="item">
            <span @click="choose_page('user_control_page')">用户管理</span>
            <span @click="choose_page('ill_control_page')">插画作品审核</span>
            <span @click="choose_page('comic_control_page')">漫画作品审核</span>
            <span @click="choose_page('novel_control_page')">小说作品审核</span>
            <span @click="choose_page('commection_control_page')">评论管理</span>
        </div>
    </div>
  </div>
</template>

<script setup>
import { useStore } from 'vuex';

const store = useStore();

function choose_page(page_name){
  store.commit('change_page',{'page_key':page_name,'page_value':true})
}

</script>

<style scoped>
  .sidebar{
    width:150px;
    height: auto;
    background-color:rgba(100, 100, 100, 0.5);
    display: flex;
    flex-direction: column;
    border-radius: 10px;
    position: fixed;
    top:80px;
    left: 10px;
    z-index:5;
  }
  .content{
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column;
    align-items: center;
  }
  .item{
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 10px;
  }
  .item span{
    width:100%;
    height: auto;
    margin: 5px ;
    padding:5px 0px;
    cursor: pointer;
    font-size: 18px;
    color: white;
    font-weight: bold;
    align-items: center;
    display: flex;
    justify-content: center;
  }
  .item span:hover{
    background-color: rgba(133,133,133,1);
    border-radius: 10px;
    transition: all 0.2s ease-in-out;
    transform: scale(1.05);
    transform: translateY(-2px);
  }
</style>
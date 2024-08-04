<template>
  <div class="add_select_page">
    <div class="content">
        <div class="title">
            <span></span>
            <span><b>新增精选作品</b></span>
            <div class="close_btn" @click="close_btn">
                <img class="icon" src="https://www.sunyuanling.com/assets/close.svg">
            </div>
        </div>
        <div class="choose_item">
            <div class="item" @click="item_index=0" :class="item_index==0?'choose_status':''">
                <span>插画·漫画</span>
            </div>
            <div class="item" @click="item_index=1" :class="item_index==1?'choose_status':''">
                <span>小说</span>
            </div>
            <div class="item" @click="item_index=2" :class="item_index==2?'choose_status':''">
                <span>约稿</span>
            </div>
        </div>
        <div class="item_page">
            <div class="item_page_ill" v-if="item_index==0">
                <span>选择插画或者漫画作品</span>
            </div>
            <div class="item_page_novel" v-if="item_index==1">
                <span>选择小说作品</span>
            </div>
            <div class="item_page_contract" v-if="item_index==2">
                <span>选择完成的约稿作品</span>
            </div>
        </div>
    </div>
  </div>
</template>

<script setup>
import { ref, defineProps, onMounted ,defineEmits} from 'vue';
import {get_user_all_worklist} from '../../../../js/get_workinfo.js'

const props = defineProps({
  user_info: {
    type: Object,
    default: () => ({})
  },
  token: {
    type: String,
    default: ''
  }
})
const emit=defineEmits(['close_page'])
function close_btn() {
  emit('close_page',false)
}
let work_list=ref()
let item_index=ref(0)

onMounted(async ()=>{
    work_list.value=await get_user_all_worklist(props.token)
    console.log(work_list.value)
})
</script>

<style scoped>
.add_select_page{
    position: fixed;
    top: 0;
    left: 0;
    width: 100vw;
    height: 100vh;
    max-height: 100vh;
    background-color: rgba(0, 0, 0, 0.5);
    z-index: 10;
    display: flex;
    align-items: center;
    justify-content: center;
    overflow-y: auto;
}
.content{
    width: auto;
    height: auto;
    display: flex;
    flex-direction: column;
    min-width: 450px;
    min-height: 100px;
    background-color: white;
    border-radius: 15px;
    padding: 10px;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.5);
    overflow-y: auto;
}
.content::-webkit-scrollbar {
    width: 0px;
}
.title{
    width: 100%;
    height: auto;
    padding: 5px 0px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}
.icon{
    width: 25px;
    height: 25px;
    object-fit: cover;
}
.close_btn{
    width: 35px;
    height: 35px;
    display: flex;
    justify-content: center;
    align-items: center;
}
.close_btn:hover{
    cursor: pointer;
    transform: scale(1.1);
    transition: all 0.2s ease-in-out;
    background-color: rgba(133, 133, 133, 0.5);
    border-radius: 50%;
}
.choose_item{
    width: 100%;
    height: auto;
    display: flex;
    align-items: center;
}
.item{
    width: auto;
    height: auto;
    flex:1;
    flex-grow: 1;
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: center;
    padding: 5px 10px;
    cursor: pointer;
}
.choose_status{
    border-bottom: 3px solid rgba(0,150,250,1);
    color: rgba(0,150,250,1);
    transform: translateY(-2px);
    transform: scale(1.1);
    transition: all 0.2s;
    font-weight: bold;
}
</style>
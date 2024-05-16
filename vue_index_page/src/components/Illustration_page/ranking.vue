
<template>
  <div class="ranking">
    <span><b>每日排行榜</b></span>
    <h3>{{daytime}}的排行榜</h3>
    <div class="work_list">
        <div class="work_item" v-for="index in 10" :key="index">
            <div class="item">
                <div class="rank"><span>{{rank}}</span></div>
                <div class="page_count"><span>{{page_count}}</span></div>
                <img :src="item_path">
            </div>
            <div class="work_title"></div>
            <div class="user_info">
                <div class="user_avatar">
                    <img :src="user_avatar">
                </div>
                <div class="username">
                    <span>{{username}}</span>
                </div>
            </div>
        </div>
        <div class="left_btn">1</div>
        <div class="right_btn">1</div>
    </div>
  </div>
</template>

<script>
import { ref,onMounted,onUnmounted,watch } from 'vue';

export default {
  name: 'ranking',
  
};
</script>
<script setup>
let daytime=ref();

onMounted(()=>{
    const date=new Date();
    const year=date.getFullYear();
    const month=date.getMonth()+1;
    const day=date.getDate();
    const datetime=year+'年'+month+'月'+day+'日';
    daytime.value=datetime;
})

let item_path=ref('http://127.0.0.1:11451/image/65014220_p0.jpg');
let rank=ref(1);
let page_count=ref(12);
let work_title=ref('作品标题');
let user_avatar=ref('http://127.0.0.1:11451/image/87328997_p0.jpg');
let username=ref('用户名');

</script>

<style scoped>
.ranking{
    display: flex;
    margin-top: 30px;
    height: auto;
   width: 100%;
   margin-top:30px;
   flex-direction: column;
}
.work_list{
    display: flex;
    overflow-x: auto;
    overflow: hidden;
    scrollbar-width: none;
    width: 100%;
    height: auto;
    position: relative;
    white-space: normal;
}
.left_btn{
    display: flex;
    position: absolute;
    left:0px;
    width: 50px;
    height: 100%;
    background: linear-gradient(to right, rgba(255, 255, 255,1), rgba(255, 255, 255,0));
    z-index: 2;
    opacity: 0;
}
.left_btn:hover{
    opacity: 1;
    cursor: pointer;
    transition: all 0.3s ease;
}
.right_btn{
    display: flex;
    right: 0px;
    position: absolute;
    width: 50px;
    height: 100%;
    background:linear-gradient(to right, rgba(255, 255, 255,0), rgba(255, 255, 255,1)) ;
    z-index: 2;
    opacity: 0;
}
.right_btn:hover{
    opacity: 1;
    cursor: pointer;
    transition: all 0.3s ease;
}

.work_item{
    width: 200px;
    height: 260px;
    display: flex;
    flex-direction: column;
    margin-right: 20px;
    min-width: 200px;
}
.item{
    display: flex;
   position: relative;
    width: 100%;
    height: 80%;
    min-height: 260*0.8px;
    overflow: hidden;
    border-radius: 15px;
}
.item img{
    display: flex;
    width: 100%;
    height: 100%;
    object-fit: cover;
}
.rank{
    position: absolute;
    width: 30px;
    height: 30px;
    top:5px;
    left: 5px;
   display: flex;
   justify-content: center;
   align-items: center;
  border-radius: 50%;
  background-color: rgba(255, 131, 99,1);
}
.page_count{
    position: absolute;
    width: 40px;
    height: 20px;
    top:5px;
    right: 5px;
   display: flex;
   justify-content: center;
   align-items: center;
  border-radius: 10px;
  background-color: rgba(255, 131, 99,1);
  font-size: 12px;
  color: white;
}
.work_title{
    display: flex;
    margin-top:10px;
}
.user_info{
    display: flex;
    margin-top: 10px;
}
.user_avatar{
    display: flex;
    width: 30px;
    height: 30px;
    border-radius: 50%;
    overflow: hidden;
    margin-right: 5px;
}
.user_avatar img{
    width: 100%;
    height: 100%;
    object-fit: cover;
}
.username{
    display: flex;
    justify-content: center;
    align-items: center;
}


</style>


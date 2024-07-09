<template>
  <div class="ill_page" @wheel="onWheel">
    <div class="content">
      <div class="sort_fun_box">
        排序方法
      </div>
      <div class="popular_works">
        热门作品
      </div>
      <div class="ill_box">
        <div class="ill_item" v-for="(item,index) in data" :key="index">
            <div class="age_classifiction" v-if="item.age_classification>16">
              <span>R-{{item.age_classification}}</span>
            </div>
            <div class="page_count">
              <img class="icon" src="https://www.sunyuanling.com/assets/page_count.svg" style="margin-right:5px;">
              <span>{{item.content_file_list.split(/[,，]/).length}}</span>
            </div>
            <img class="ill_img" :src="'https://www.sunyuanling.com/image/thumbnail/'+item.content_file_list.split(/[,，]/)[0]"
            @click="jump_to_page(item.Illustration_id)">
            <span class="work_title">{{item.name}}</span>
            <div class="author_info">
              <img class="author_avatar" :src="item.avatar">
              <div class="author_name">
                <span>{{item.belong_to_user}}</span>
              </div>
            </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted,defineEmits,defineProps } from 'vue';
export default {
  name: 'ill_page',
}
</script>

<script setup>
let ill_data=defineProps({
    ill_data:{
        type:Object,
        default(){
            []
        }
    }
})
let data=ref(ill_data.ill_data)
watch(()=>ill_data.ill_data,async (newValue,oldValue)=>{
    data.value=newValue;
    await set_avatar();
})
onMounted(async ()=>{
  data.value=ill_data.ill_data;
 
})
//请求作品列表的作者头像
async function get_author_avatar(userid){
  const res=await fetch('https://www.sunyuanling.com/api/GetUserInfo/GetAllUserInfo/',{
    method:'POST',
    body:JSON.stringify({
      userid:userid
    })
  })
  if(res.ok)
  {
    const data=await res.json()
    if (data.status=='success')
  {
    return 'https://www.sunyuanling.com/image/avatar_thumbnail/'+data.data[0].user_avatar
  }
  }
}
//设置data中的头像数据
async function set_avatar(){
  for(let i=0;i<data.value.length;i++)
{
  data.value[i].avatar=await get_author_avatar(data.value[i].belong_to_user_id)
}
}
//阻止滚动事件传播
function onWheel(event) {
      event.stopPropagation();
    }
//带参跳转
function jump_to_page(id)
{
  console.log(id)
  //window.location.href='https://localhost:3002/?work_id='+id+'work_type=ill';
}
</script>

<style scoped>
  .ill_page{
    width:80%;
    height: auto;
    display: flex;
    margin:5px auto;
  }
  .ill_box{
    width: 100%;
    height: auto;
    display: flex;
    flex-wrap: wrap;
  }
  .ill_item{
    width: 210px;
    padding:5px;
    height: auto;
    max-height: 300px;
    overflow: hidden;
    display: flex;
    flex-direction: column;
    position: relative;
    border-radius: 10px;
    margin:10px 20px;
  }
  .icon{
    width:25px;
    height: 25px;
    object-fit: cover;
  }
  .age_classifiction{
    display: flex;
    width: auto;
    height: auto;
    padding: 2px 5px;
    color: white;
    font-weight: bold;
    font-size: 14px;
    background-color: red;
    position: absolute;
    left: 5px;
    top:5px;
    border-radius: 5px;
    z-index: 5;
  }
  .page_count{
    position: absolute;
    right: 5px;
    top:5px;
    width: auto;
    height: auto;
    padding: 3px 5px;
    color: white;
    font-weight: bold;
    font-size: 14px;
    background-color: rgba(0,0,0,0.5);
    z-index: 5;
    display: flex;
    align-items: center;
    border-radius: 5px;
  }
  .ill_img{
    width: auto;
    height: auto;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    border-radius: 10px;
  }
  .author_info{
    width: 100%;
    height: auto;
    display: flex;
    align-items: center;
  }
  .author_avatar{
    width:35px;
    height: 35px;
    border-radius: 50%;
    margin-right: 5px;
    overflow: hidden;
  }
  .work_title{
    width: 100%;
    height: auto;
    display: flex;
    align-items: center;
    margin:3px 0;
    font-size: 16px;
    font-weight: bold;
  }
</style>
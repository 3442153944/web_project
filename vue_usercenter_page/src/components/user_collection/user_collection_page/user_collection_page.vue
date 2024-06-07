<template>
  <div class="user_collection_page">
    <div class="switch_page">
      <div class="switch_item" ref="ill_page_item" @click="switch_page(0)"><span>插画·漫画</span></div>
      <div class="switch_item" ref="novel_page_item" @click="switch_page(1)"><span>小说</span></div>
    </div>
    <ill_page v-if="ill_page_show"></ill_page>
    <novel_page v-if="novel_page_show"></novel_page>
  </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted } from 'vue';
import ill_page from './ill_page/ill_page.vue'
import novel_page from './novel_page/novel_page.vue'
export default {
  name: 'user_collection_page',
  components:{
    ill_page,novel_page,
  }
}
</script>

<script setup>
let ill_page_show=ref(true)
let novel_page_show=ref(true)
let ill_page_item=ref(null)
let novel_page_item=ref(null)

//切换作品页面
function switch_page(index)
{
  if(index==0)
  {
    ill_page_show.value=true;
    novel_page_show.value=false;
    ill_page_item.value.style.backgroundColor='rgba(133,133,133,0.5)';
    novel_page_item.value.style.backgroundColor='';
  }
  else if(index==1)
  {
    ill_page_show.value=false;
    novel_page_show.value=true;
    novel_page_item.value.style.backgroundColor='rgba(133,133,133,0.5)';
    ill_page_item.value.style.backgroundColor='';
  }
}
onMounted(()=>{
  switch_page(0);
})
</script>

<style scoped>
  .user_collection_page{
    display: flex;
    width:100%;
    height: auto;
    flex-direction: column;
  }
  .switch_page{
    display: flex;
    width: auto;
    padding: 10px;
    align-items: center;
  }
  .switch_item{
    margin-right: 20px;
    padding:5px 10px;
    border-radius: 15px;
    display: flex;
    justify-content: center;
    align-items: center;
  }
  .switch_item:hover{
    background-color:rgba(133,133,133,0.2);
    cursor: pointer;
    transition: all 0.3s ease-in-out;
  }
</style>
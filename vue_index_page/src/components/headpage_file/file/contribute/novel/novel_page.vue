<template>
  <div class="novel_page">
    <div class="page_title">
      小说投稿
    </div>
    <div class="content">
      <span>投稿形式</span>
      <div class="work_typeof">
        <input type="radio" value="系列作品" name="novel_typeof">
        <label for="">系列作品</label>
        <input type="radio" value="单篇完结作品" name="novel_typeof">
        <label for="">单篇完结作品</label>
        <div class="contribute_tips" style="margin-top: 10px;color:rgba(77,77,77,0.9);font-size:14px;">
          <span>若是连载作品，或是类似短篇小说集等分多个篇章叙述的作品，还请选为系列作品进行投稿。
            在新建系列后才能投稿系列作品。</span>
        </div>
      </div>
      <div class="work_series">
        <re_select :select_title="select_title" :select_list="select_list" @select-item="get_select_item"></re_select>
      </div>
      <div class="work_item">
        <div class="work_title">
          <input type="text" placeholder="作品标题" v-model="work_title">
        </div>
        <div class="work_content">
          <auto_textarea v-model="work_content"
          :maxlength="2000"
          :rows="5"
          placeholder="请输入正文内容..."
          :fontsize="14"
          :lineheight="1.6"></auto_textarea>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { ref, reactive, toRefs, watch, onMounted, onUnmounted } from 'vue';
export default {
  name: 'novel_page',
}
</script>

<script setup>
import re_select from '../../../../models/select.vue'
import auto_textarea from '../../../../models/auto_textarea.vue'
let select_title=ref('新建系列')
let select_list=ref([
  '新建系列',
  '作品系列一'
])
let select_item=ref();
let work_content=ref()
let work_title=ref();
function get_select_item(item){
  select_item.value=item
  console.log(item)
}
</script>

<style scoped>
  .novel_page{
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column;
    gap: 10px;
  }
  .page_title{
    width: 100%;
    height: auto;
    min-height: 35px;
    display: flex;
    justify-content: center;
    margin:0px 5px auto auto;
    font-size: 18px;
    font-weight: bold;
    background-color: #f5f5f5;
    align-items: center;
    padding: 5px 10px;

  }
  .content{
    width: 80%;
    height: 100%;
    display: flex;
    flex-direction: column;
    align-self: center;
    gap: 10px;
  }
  .work_typeof{
    width: 100%;
    height: auto;
    gap: 10px;
  }
  .work_series{
    width: 300px;
    height: auto;
    display: flex;
  }
  .work_item{
    width: 100%;
    height: auto;
    display: flex;
    flex-direction: column;
    gap: 10px;
  }
  .work_title{
    width: 100%;
    height: 30px;
    display: flex;
    align-items: center;
    border:1px solid rgba(133,133,133,1);
    padding: 2px;
    border-radius: 5px;
  }
  .work_title input{
    width: 100%;
    height: 100%;
    border-radius: 5px;
    border: none;
  }
  .work_content{
    width: 100%;
    height: auto;
    border: 1px solid rgba(133,133,133,1);
    padding: 5px;
    border-radius: 5px;
  }
</style>
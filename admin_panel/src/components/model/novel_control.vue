<template>
  <div class="novel_control">
    <h1>小说审核</h1>
    <div class="search_box">
      <span>搜索：</span>
      <input type="text" placeholder="请输入小说名/ID">
      <div class="search_btn"><span>搜索</span></div>
      <div class="novel_work_status">
        <span>小说状态：</span>
        <select>
          <option value="all">全部</option>
          <option value="1">已上架</option>
          <option value="0">未上架</option>
          <option value="2">未审核</option>
        </select>
      </div>
    </div>
    <div class="content">
      <div class="item" v-for="(item, index) in novel_work_list" :key="index">
        <div class="novel_cover">
          <img :src="'https://www.sunyuanling.com/image/novel/thumbnail/'+item.work_cover" alt="小说作品封面">
          <div class="show_novel_work_content" @click="show_novel_content_page(item.work_id)">
            <span>查看小说详情</span>
          </div>
        </div>
        <div class="novel_work_info">
          <div class="info_item">
            <span>名称：</span>
            <span>{{ item.work_name }}</span>
          </div>
          <div class="info_item">
            <span>作者：</span>
            <span>{{ item.username }}</span>
          </div>
          <div class="info_item">
            <span>简介：</span>
            <span>{{ item.brief_introduction }}</span>
          </div>
          <div class="info_item">
            <span>作品类型：</span>
            <span>{{ item.category }}</span>
          </div>
          <div class="info_item">
            <span>年龄分级：</span>
            <span>{{ item.age_classification }}</span>
          </div>
          <div class="info_item">
            <span>作品状态：</span>
            <span>{{ item.work_status }}</span>
          </div>
          <div class="info_item">
            <span>作品字数：</span>
            <span>{{ item.novel_word_count }}</span>
          </div>
          <div class="info_item">
            <span>作品上架状态：</span>
            <span>{{ item.work_approved == 1 ? '已上架' : item.work_approved == 0 ? '未上架' : '未审核' }}</span>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="show_novel_content_page" v-if="show_novel_content_page_show">
    <div class="close" @click="show_novel_content_page_show = false">
      <div class="close_btn">
        <img src="https://www.sunyuanling.com/assets/close.svg" alt="退出">
      </div>
    </div>
    <div class="novel_content_page" v-if="content_info_list">
      <div class="novel_info">
        <div class="content_novel_cover">
          <img :src="'https://www.sunyuanling.com/image/novel/thumbnail/'+title_list[0].work_cover" alt="小说封面">
        </div>
      </div>
      <div class="title_list">
        <div class="title_item" v-for="(item,index) in title_list" :key="index">
          <span>{{item.title}}</span>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { get_novel_work_list, get_novel_work_content_list } from './js/get_work_list'
import { ref, onMounted, watch, onUnmounted } from 'vue'

const novel_info_list = ref([])
const novel_work_list = ref([])
const limit = ref(10)
const offset = ref(0)
const total = ref(0)
const show_novel_content_page_show = ref(false)
const content_info_list = ref()
const title_list = ref([])

//获取小说作品列表
async function get_novel_work() {
  const res = await get_novel_work_list(limit.value, offset.value)
  if (res.status == 'success') {
    novel_info_list.value = res.data
    total.value = novel_info_list.value.total
    console.log(novel_info_list.value)
    novel_work_list.value = [...novel_work_list.value, ...novel_info_list.value.work_list]
  }
  else {
    console.log(res.message)
  }
}

//获取指定ID的小说章节列表
async function get_title_list(work_id) {
  let res = await get_novel_work_content_list(work_id)
  if (res.status == 'success') {
    content_info_list.value = res.data
    console.log(content_info_list.value)
    title_list.value=[...title_list.value,...content_info_list.value.work_list]
  }
}

async function show_novel_content_page(work_id){
  show_novel_content_page_show.value = true
  await get_title_list(work_id)
}

onMounted(async () => {
  await get_novel_work()
})

</script>

<style scoped>
.novel_control{
  width:100%;
  height: auto;
  display: flex;
  flex-direction: column;
  gap:20px;
}
.search_box{
  width:100%;
  height: 80px;
  display: flex;
  flex-direction: row;
  justify-content: flex-start;
  align-items: center;
  gap:20px;
}
.content{
  width:100%;
  height: auto;
  display: flex;
  flex-direction: column;
  gap:15px;
}
.item{
  width:90%;
  height: auto;
  display: flex;
  flex-direction: row;
  max-height: 350px;
  background-color: rgb(190, 190, 190);
  border-radius: 10px;
  padding:10px;
}
.novel_cover{
  width:25%;
  max-width: 30%;
  margin-right: 10px;
  height: auto;
  max-height: 100%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  gap:20px;
}
.novel_cover img{
  width: 100%;
  height: auto;
  max-height: 80%;
  object-fit: cover;
  border-radius: 10px;
}
.show_novel_work_content{
  width:75%;
  height: auto;
  display: flex;
  background-color: rgb(0,150,250);
  align-items: center;
  justify-content: center;
  text-align: center;
  color: white;
  padding:5px 10px;
  border-radius: 10px;
  font-weight: bold;
}
.show_novel_work_content:hover{
  cursor: pointer;
  opacity: 0.8;
  transition: all 0.2s;
  transform: scale(1.03);
  transform: translateY(-1px);
}
</style>

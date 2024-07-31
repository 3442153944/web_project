<script setup>
import { ref ,defineProps,onMounted} from 'vue'
import work_info from './model/work_info.vue';
import directory_page from './model/directory_page.vue';
import { get_workinfo,get_novel_content } from './model/js/get_workinfo';
import novel_content_page from './model/novel_content_model/novel_content.vue';
let data=ref()
let author_info=ref()
let work_list=ref()
let word_count=ref()
let novel_content=ref()
let work_title=ref('')
onMounted(async ()=>{
  data.value=await get_workinfo('sunyuanling','10')
  author_info.value=data.value.author_info
  work_list.value=data.value.work_list
  word_count.value=data.value.word_count
  
  console.log(data.value)
})
async function get_chapter(item)
{
  novel_content.value=await get_novel_content('sunyuanling',item.belong_to_series_id,item.title)
  work_title.value=item.title
}

</script>

<template>
<div class="novel_conteng_page">
  <div class="novel_brief_introduction">
    <div class="work_info">
      <work_info :work_info="work_list" :author_info="author_info" :word_count="word_count"></work_info>
    </div>
    <div class="directory_page">
      <directory_page :work_info="work_list" @get_chapter="get_chapter"></directory_page>
    </div>
  </div>
  <div class="novel_content">
    <novel_content_page :content="novel_content" :title="work_title"></novel_content_page>
  </div>
</div>
</template>

<style scoped>
.novel_conteng_page{
  width: 100%;
  height: auto;
  display: flex;
  flex-direction: column;
  gap: 10px;
}

</style>

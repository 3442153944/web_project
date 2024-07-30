<script setup>
import { ref ,defineProps,onMounted} from 'vue'
import work_info from './model/work_info.vue';
import directory_page from './model/directory_page.vue';
import { get_workinfo } from './js/get_workinfo';

let data=ref()
let author_info=ref()
let work_list=ref()
let word_count=ref()
onMounted(async ()=>{
  data.value=await get_workinfo('sunyuanling','10')
  author_info.value=data.value.author_info
  work_list.value=data.value.work_list
  word_count.value=data.value.word_count
  console.log(data.value)
})

</script>

<template>
<div class="novel_conteng_page">
  <div class="work_info">
    <work_info :work_info="work_list" :author_info="author_info" :word_count="word_count"></work_info>
  </div>
  <div class="directory_page">
    <directory_page :work_info="work_list"></directory_page>
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

<script setup>
import { ref ,defineProps} from 'vue'
import work_info from './model/work_info.vue';
import directory_page from './model/directory_page.vue';

</script>

<template>
<div class="novel_conteng_page">
  <div class="work_info">
    <work_info></work_info>
  </div>
  <div class="directory_page">
    <directory_page></directory_page>
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

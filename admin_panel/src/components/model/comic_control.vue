<template>
  <div class="comic_control">
    <h1>漫画管理</h1>
  </div>
</template>


<script setup>
import {ref,onMounted} from 'vue'
import {get_comic_worklist} from './js/get_work_list'

const work_info_list=ref()
const limit=ref(10)
const offset=ref(0)
const total=ref(0)

onMounted(async()=>{
  work_info_list.value=await get_comic_worklist(limit.value,offset.value)
  console.log(work_info_list.value)
  total.value=work_info_list.value.data.total
})

</script>

<style scoped>
  
</style>
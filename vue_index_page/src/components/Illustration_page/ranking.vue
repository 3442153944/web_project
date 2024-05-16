
<template>
  <div class="ranking">
    <span><b>每日排行榜</b></span>
    <h3>{{daytime}}的排行榜</h3>
    <div class="work_list">
        <div class="work_item">

        </div>
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
}
.work_item{
    width: 200px;
    height: 260px;
    display: flex;
    flex-direction: column;
}
</style>


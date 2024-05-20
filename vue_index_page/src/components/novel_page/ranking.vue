<template>
  <div class="ranking">
    <h5 style="margin-bottom:0px;">每日排行榜</h5>
    <h3 style="margin-top:5px;">{{dateStr}}的排行榜</h3>
    <div class="ranking_work_list">
        <div class="work_item"></div>
    </div>
  </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted } from 'vue';
export default {
  // eslint-disable-next-line vue/multi-word-component-names
  name: 'ranking',
}
</script>

<script setup>
let date=new Date();
let year=date.getFullYear();
let month=date.getMonth()+1;
let day=date.getDate();
let dateStr=year+'-'+month+'-'+day;
</script>

<style scoped>
  .ranking{
    display: flex;
    width:100%;
    height: auto;
    flex-direction: column;
    margin-top:20px;
  }
</style>
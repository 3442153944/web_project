<template>
  <div class="author_work_info">
    <div class="author_avatar_box">
        <div class="author_avatar">
            <img :src="avatar_src">
        </div>
        <div class="author_name">{{username}}</div>
    </div>
  </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted } from 'vue';
export default {
    
  name: 'author_box',
}
</script>

<script setup>
let avatar_src='../../../image/87328997_p0.jpg';
let username=ref('用户名');
</script>

<style scoped>
/*通用样式*/
@charset "utf-8";
.mt{margin-top:5px;}.mb{margin-bottom:5px;}.ml{margin-left:5px;}.mr{margin-right:5px;}.pt{padding-top:5px;}.pb{padding-bottom:5px;}.pl{padding-left:5px;}.pr{padding-right:5px;}
  .author_work_info{
    display: flex;
    flex-direction: column;
    width:100%;
    height: auto;
  }
  .author_avatar_box{
    display: flex;
    width:100%;
    margin-top:5px;
  }
</style>
<template>
  <div class="novel_content">
    <div class="novel_content_box">
        <novel_content_box></novel_content_box>
    </div>
    <div class="author_box">
        <author_box></author_box>
    </div>
  </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted } from 'vue';
// @ts-ignore
import novel_content_box from './novel_content_box/novel_content_box.vue';
import author_box from './author_box/author_box.vue';
export default {
  name: 'novel_content',
  components:{novel_content_box,author_box},
}
</script>

<script setup>
</script>

<style scoped>
  .novel_content{
    display: flex;
    margin-top:20px;
    margin-left: auto;
    margin-right: auto;
    width:85%;
    height: auto;
    min-height: 200px;
    border:1px solid red;
    position: relative;
    background-color: rgba(240,240,240,1);
    padding:5px;
  }
  .novel_content_box{
    display: flex;
    width:70%;
    min-height: 200px;
    border:1px solid red;
    padding:5px;
  }
  .author_box{
    display: flex;
    width:30%;
    min-height: 200px;
    border:1px solid red;
    padding:5px;
}
</style>
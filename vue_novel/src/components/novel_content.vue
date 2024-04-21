<template>
  <div class="novel_content">
    <div class="novel_content_box">
        <novel_content_box></novel_content_box>
        <word_content></word_content>
    </div>
    <div class="author_box">
        <author_box></author_box>
    </div>
  </div>
  <hr style="width:86%">
  <div class="series_box">
    <seriex_box></seriex_box>
  </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted } from 'vue';
// @ts-ignore
import novel_content_box from './novel_content_box/novel_content_box.vue';
import author_box from './author_box/author_box.vue';
import word_content from './word_content/word_content.vue';
import seriex_box from './series_box/series_box.vue';

export default {
  name: 'novel_content',
  components:{novel_content_box,author_box,word_content,seriex_box},
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
    flex-direction: column;
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
.series_box{
    display: flex;
    flex-direction: column;
    width:60%;
    height: auto;
    min-height: 100px;
    border:1px solid red;
    align-content: center;
    align-self: center;
    margin-left: auto;
    margin-right: auto;
    margin-top:20px;
    padding: 5px;
    margin-bottom: 5px;
}
</style>
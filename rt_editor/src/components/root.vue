<template>
  <div class="rt_editor">
    <head_box/>
    <div class="input_box" contenteditable="true" ref="content">{{rt_content}}</div>
  </div>
</template>

<script setup>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted } from 'vue';
import head_box from './head_box/head_box.vue'
let content =ref(null)
let rt_content=ref('默认内容')
</script>

<style scoped>
  .rt_editor {
    width:100%;
    height: 100%;
    display: flex;
    flex-direction: column;
    gap: 10px; 
  }
</style>
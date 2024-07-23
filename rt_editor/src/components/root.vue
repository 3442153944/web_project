<template>
  <div class="rt_editor">
    <div class="input_box" contenteditable="true" ref="content"></div>
  </div>
</template>

<script setup>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted } from 'vue';
let content =ref(null)
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
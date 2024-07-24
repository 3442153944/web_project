<template>
  <div class="head_box">
    <div>富文本编辑器头部工具栏</div>
  </div>
</template>

<script setup>
import { ref, reactive, toRefs, watch, onMounted, onUnmounted } from 'vue';
</script>

<style scoped>
  .head_box {
    width:100%;
    height: auto;
    display: flex;
    flex-wrap: wrap;
    align-items: center;
  }
</style>
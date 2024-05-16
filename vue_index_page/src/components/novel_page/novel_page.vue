<template>
  <div class="novel_page">
    小说
  </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted } from 'vue';
export default {
  name: 'novel_page',
}
</script>

<script setup>
</script>

<style scoped>
  .novel_page {
  display: flex;
  flex-direction: column;
  width: 80%;
  height: auto;
  margin:0 auto;
  margin-top: 20px;
  }
</style>
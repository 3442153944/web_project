<!-- eslint-disable vue/multi-word-component-names -->
<script setup>
import { ref } from 'vue'
import drawing_index_page from './model/drawing_index_page.vue';
const count = ref(0)
</script>

<template>
<div class="root">
  <h1>作品数据分析</h1>
  <drawing_index_page></drawing_index_page>
</div>
</template>

<style scoped>

</style>

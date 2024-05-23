<template>
  <div class="rootpage">
    <header_box></header_box>
    主vue页面
  </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted } from 'vue';
import header_box from './headpage_file/header_box.vue';
export default {
  // eslint-disable-next-line vue/multi-word-component-names
  name: 'rootpage',
  components:{header_box},
}
</script>

<script setup>
</script>

<style scoped>
  
</style>
<template>
  <div class="rootpage">
    <header_box></header_box>
    <back_img_box></back_img_box>
    <user_index></user_index>
  </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted } from 'vue';
import header_box from './headpage_file/header_box.vue';
import back_img_box from './back_img_box/back_img_box.vue';
import user_index from './user_collection/user_index.vue'
export default {
  // eslint-disable-next-line vue/multi-word-component-names
  name: 'rootpage',
  components:{header_box,back_img_box,user_index},
}
</script>

<script setup>
</script>

<style scoped>
  
</style>
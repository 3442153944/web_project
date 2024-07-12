<template>
  <div class="root">
    <index></index>
  </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted } from 'vue';
import index from './page/index.vue'
export default {
  // eslint-disable-next-line vue/multi-word-component-names
  name: 'root',
  components:{
    index,
  }
}
</script>

<script setup>
</script>

<style scoped>
  
</style>
<template>
  <div class="select">
    重写的select组件
  </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted ,defineEmits} from 'vue';
export default {
  name: 'rewrite_select',
}
</script>

<script setup>
</script>

<style scoped>
.select{
    width: 100%;
    height: 100%;
    background-color: #fff;
}
  
</style>
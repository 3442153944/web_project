<template>
  <div class="header_box">
    
  </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted } from 'vue';
export default {
  name: 'header_box',
}
</script>

<script setup>

</script>

<style scoped>
.header_box{
    display: flex;
    flex-direction: column;
    width:200px;
    height: auto;
    min-height: 200px;
    border:1px solid red;
    position:absolute;
    right: 0px;
    top:60px;
}
  
</style>
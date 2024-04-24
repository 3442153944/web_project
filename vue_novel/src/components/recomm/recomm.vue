<!-- eslint-disable no-unused-vars -->
<template>
  <div class="recomm">
    111
  </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted } from 'vue';
export default {
  // eslint-disable-next-line vue/multi-word-component-names
  name: 'recomm',
}
</script>

<script setup>
</script>

<style scoped>
  .recomm{
    display: flex;
    position: relative;
    border:1px solid red;
    width:300px;
    height:150px ;
    flex-grow: 1;
    margin-left:5px;
    margin-right: 5px;
    margin-top:10px;
    margin-bottom: 10px;
  }
</style>
<template>
  <div class="comment_box">
    111{{text}}
  </div>
</template>

<script lang="ts">
import { ref, reactive, toRefs, watch, onMounted, onUnmounted } from 'vue';
export default {
    props1:['message'],
  name: 'comment_box',
}
</script>

<script setup lang="ts">
// eslint-disable-next-line no-unused-vars
const props=defineProps(['message']);
const text=ref(props.message);
watch(()=>props.message ,(newvalue)=>{text.value=newvalue})

</script>

<style scoped>
  
</style>
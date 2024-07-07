<template>
  <div class="comic_page">
    
  </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted,defineEmits,defineProps } from 'vue';
export default {
  name: 'comic_page',
}
</script>

<script setup>
let comic_data=defineProps({
    comic_data:{
        type:Object,
        default(){
            []
        }
    }
})
</script>

<style scoped>
  
</style>
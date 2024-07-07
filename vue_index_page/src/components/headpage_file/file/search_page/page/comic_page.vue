<template>
  <div class="comic_page">
    {{data}}
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
            return {}
        }
    }
})
let data=ref()
watch(()=>comic_data.comic_data,(newValue,oldValue)=>{
    data.value=newValue
})
</script>

<style scoped>
  
</style>
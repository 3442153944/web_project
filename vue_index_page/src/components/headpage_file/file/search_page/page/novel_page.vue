<template>
  <div class="novel_page">
    {{data}}
  </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted,defineEmits,defineProps } from 'vue';
export default {
  name: 'novel_page',
}
</script>

<script setup>
let novel_data=defineProps({
    novel_data:{
      type:Object,
      default:()=>{
        return {}
      }
    }
})
let data=ref(novel_data.novel_data)
watch(()=>novel_data.novel_data,(newValue,oldValue)=>{
    data.value=newValue
})
onMounted(()=>{
  data.value=novel_data.novel_data
})
</script>

<style scoped>
  
</style>
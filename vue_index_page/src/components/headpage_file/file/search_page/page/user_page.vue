<template>
  <div class="user_page">
    {{data}}
  </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted,defineEmits,defineProps } from 'vue';
export default {
  name: 'user_page',
}
</script>

<script setup>
let user_data=defineProps({
  user_data:{
    type:Object,
    default:()=>{
      return {}
    }
  }
})
let data=ref(user_data.user_data)
watch(()=>user_data.user_data,(newValue,oldValue)=>{
    data.value=newValue
})
onMounted(()=>{
    data.value=user_data.user_data;
})
</script>

<style scoped>
  
</style>
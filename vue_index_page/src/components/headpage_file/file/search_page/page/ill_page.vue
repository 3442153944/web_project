<template>
  <div class="ill_page">
    <span>{{data}}</span>
  </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted,defineEmits,defineProps } from 'vue';
export default {
  name: 'ill_page',
}
</script>

<script setup>
let ill_data=defineProps({
    ill_data:{
        type:Object,
        default(){
            []
        }
    }
})
let data=ref(ill_data.ill_data)
watch(()=>ill_data.ill_data,(newValue,oldValue)=>{
    data.value=newValue
})
</script>

<style scoped>
  
</style>
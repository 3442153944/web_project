<template>
    <div class="novel_recommend">
      
    </div>
  </template>
  
  <script setup>
  import {ref,defineProps,defineEmits,computed} from 'vue'
  const props=defineProps({
      work_info:{
          type:Array,
          default:()=>{
              return []
          }
      },
  })
  const emit=defineEmits(['choose_item'])
  function choose_item(item)
  {
      emit('choose_item',item)
  }
  let work_cover=computed(()=>props.work_info)
  </script>
  
  <style scoped>
    
  </style>
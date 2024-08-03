<template>
  <div class="novel_select">
    小说
  </div>
</template>

<script setup>
import {ref,defineProps} from 'vue'
const props=defineProps({
    user_info:{
        type:Object,
        default:()=>{
            return {}
        }
    },
    token:{
        type:String,
        default:''
    }
})
</script>

<style scoped>
  
</style>
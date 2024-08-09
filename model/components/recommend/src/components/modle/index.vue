<!-- eslint-disable vue/multi-word-component-names -->
<template>
  <div class="index" v-if="work_list">
    <ill_recommend v-if="work_type=='ill'" :work_info="work_list"></ill_recommend>
    <comic_recommend v-if="work_type=='comic'" :work_info="work_list"></comic_recommend>
    <novel_recommend v-if="work_type=='novel'" :work_info="work_list"></novel_recommend>
  </div>
</template>

<script setup>
import {defineProps,ref,onMounted} from 'vue'
import {get_recommend} from './js/get_recommend'
import ill_recommend from './ill_recommend.vue';
import comic_recommend from './comic_recommend.vue';
import novel_recommend from './novel_recommend.vue';
const props=defineProps({
    token:{
        type:String,
        default:''
    },
    work_type:{
        type:String,
        default:'ill'
    }
}
)

let work_list=ref()
let work_offset=ref(0)
let work_limit=ref(3)
onMounted(async()=>{
    work_list.value=await get_recommend(props.token,props.work_type,work_offset.value,work_limit.value)
})
</script>

<style scoped>
  
</style>
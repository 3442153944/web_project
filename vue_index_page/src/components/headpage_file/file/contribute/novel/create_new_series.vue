<template>
  <div class="create_new_series">
    <div class="title">
        <div></div>
        <span>新建系列</span>
        <div class="close_btn" @click="close_page()">
            <img class="icon" src="https://www.sunyuanling.com/assets/close.svg">
        </div>
    </div>
  </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted ,defineEmits} from 'vue';
export default {
  name: 'create_new_series',
}
</script>

<script setup>
let emit=defineEmits(['close_create_new_series'],['new_series_info'])
let new_series_info=ref({})
function close_page()
{
    emit('close_create_new_series',false)
}
function create_new_series()
{
    emit('new_series_info',new_series_info.value)
}
watch(new_series_info,(new_value,old_value)=>{
    create_new_series()
    console.log(new_value)
})
</script>

<style scoped>
  
</style>
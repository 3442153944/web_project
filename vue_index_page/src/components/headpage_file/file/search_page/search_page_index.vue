<template>
  <div class="search_page_index">
    <div class="close_btn">
      <img src="https://www.sunyuanling.com/assets/close.svg" alt="close_btn">
    </div>
    <div>搜索内容框</div>
    <div>{{search_data}}</div>
  </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted,defineProps,defineEmits } from 'vue';
import * as cookies from '../../../../../../model/cookies.js'
export default {
  name: 'search_page_index',
}
</script>

<script setup>
let props=defineProps({
    search_item:{
        type:String,
        default:'德丽莎'
    }
})
let search_data=ref(props.search_item)
watch(()=>props.search_item,(new_value,old_value)=>{
    search_data.value=new_value
    console.log(new_value)
    console.log(old_value)
}
)

</script>

<style scoped>
  .search_page_index{
    position: fixed;
    top:50px;
    left: 0;
    width:100vw;
    height: 100vh;
    z-index: 15;
    background-color: rgba(255,255,255,1);
  }
</style>
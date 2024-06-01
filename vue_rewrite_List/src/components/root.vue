<template>
  <div class="root">
    <rewrite_select @select-item="get_item"
    :select_title="select_title"
    :select_list="select_list"></rewrite_select>
    <span>{{test}}</span>
  </div>
</template>

<script>
import { ref, reactive, toRefs, watch, onMounted, onUnmounted } from 'vue';
import rewrite_select from './select.vue'
export default {
  name: 'root',
  components: {rewrite_select},
}
</script>

<script setup>
//接收子组件的传值
const test=ref();
function get_item(item){
    test.value=item;
    console.log(item);
}
let select_title=ref('请选择');
let select_list=ref(['选项1','选项2','选项3']);
</script>

<style scoped>
  
</style>
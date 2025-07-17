<template>
  <view class="content">
    <view class="head-placeholder" />
    <view class="head-box-wrapper">
      <head_box />
    </view>

    <ill_index v-if="page_index==0" />
    <comic_index v-if="page_index==1" />
    <novel_index v-if="page_index==2" />
  </view>
</template>

<script setup>
import head_box from './head.vue'
import ill_index from './ill_page/ill_index.vue'
import comic_index from './comic/comic_index.vue';
import { useIndexStore } from './index_store';
import novel_index from './novel/novel_index.vue';
import { computed,watch } from 'vue';

const store = useIndexStore();
const page_index=computed(()=>{
  return store.$state.now_page;
})
watch(()=>(store.$state.now_page),(value)=>{  
  console.log(value)
})
</script>

<style scoped>
.content {
  display: flex;
  flex-direction: column;
  width: 100vw;
}

.head-placeholder {
  height: 60px;
}

.head-box-wrapper {
  position: fixed;
  top: 0;
  z-index: 100;
  width: 100%;
  height: 60px;
  background: #fff;
}
</style>


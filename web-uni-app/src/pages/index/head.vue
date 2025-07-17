<template>
  <div class="head">
    <div
      v-for="(item, index) in head_item"
      :key="index"
      :class="['head_item', { head_item_active: index === now_page }]"
      @click="change_page(index)"
    >
      <span>{{ item }}</span>
    </div>
  </div>
</template>

<script setup>
import {computed, ref} from 'vue'
import { useIndexStore } from './index_store';

const store = useIndexStore();
const head_item=ref(['插画','漫画','小说'])
const change_page=(index)=>{
    store.$state.now_page=index
}
const now_page=computed(()=>{return store.$state.now_page})

</script>

<style lang="scss" scoped>
.head {
  width: 100vw;
  height: 50px;
  display: flex;
  background: #ffffff;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
  border-bottom: 1px solid #eaeaea;

  .head_item {
    flex: 1;
    text-align: center;
    font-size: 16px;
    color: #333;
    display: flex;
    align-items: center;
    justify-content: center;
    position: relative;
    cursor: pointer;
    transition: background-color 0.2s ease;

    &:active {
      background-color: rgba(0, 0, 0, 0.04);
    }

    span {
      padding: 6px 12px;
      border-radius: 8px;
      transition: all 0.2s ease;
    }
  }

  .head_item_active {
    color: #007aff;

    span {
      background-color: #e6f2ff;
      color: #007aff;
      font-weight: 600;
    }

    &::after {
      content: "";
      position: absolute;
      bottom: 0;
      left: 25%;
      width: 50%;
      height: 3px;
      background-color: #007aff;
      border-radius: 2px;
      transition: all 0.3s ease;
    }
  }
}
</style>
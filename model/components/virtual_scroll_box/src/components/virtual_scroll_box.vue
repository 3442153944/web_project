<script setup>
import { ref } from 'vue'
import { VirtualList } from 'vue3-virtual-list'

// 示例数据
const items = ref(Array.from({ length: 100 }, (_, i) => `Item ${i + 1}`)) // 生成 100 个示例项
const itemSize = 100 // 每项的高度
</script>

<template>
  <div>虚拟无限滚动</div>
  <VirtualList :size="itemSize" :remain="10" :total="items.length">
    <template #default="{ item }">
      <div class="item">{{ item }}</div>
    </template>
  </VirtualList>
</template>

<style scoped>
.item {
  height: 100px; /* 与 itemSize 变量值保持一致 */
  border-bottom: 1px solid #ddd;
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>

<template>
  <view class="content">
    <view class="introduce">
      <text>
        {{ work_info.brief_introduction ?? '暂无简介' }}
      </text>
    </view>
    <view class="work_tags">
      <view v-for="(i, k) in tags" :key="k" class="tag">
        <text class="tag-hash">#</text>
        <text class="tag-text">{{ i }}</text>
      </view>
    </view>
  </view>
</template>
<script setup>
import { defineProps, computed } from 'vue'

const props = defineProps({
  work_info: Object
})

const tags = computed(() => {
  if (!props.work_info?.work_tags) return []
  return Array.from(
    new Set(
      props.work_info.work_tags
        .split(/[,，]/)
        .map(i => i.trim())
        .filter(Boolean)
    )
  )
})
</script>
<style lang="scss" scoped>
.content {
  display: flex;
  flex-direction: column;
  padding: 16px;
  font-size: 14px;
  line-height: 1.6;

  .introduce {
    margin-bottom: 12px;
    color: #333;
  }

  .work_tags {
    display: flex;
    flex-wrap: wrap;
    gap: 8px;
  }

  .tag {
    display: inline-flex;
    align-items: center;
    white-space: nowrap;
    padding: 4px 10px;
    background-color: #f2f2f2;
    border-radius: 4px;
    font-size: 13px;
    color: #444;
  }

  .tag-hash {
    color: #007aff;
    margin-right: 1rem;
  }

  .tag-text {
    display: inline-block;
  }
}
</style>

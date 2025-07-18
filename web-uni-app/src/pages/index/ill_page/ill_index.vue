<template>
  <scroll-view
    class="content"
    scroll-y
    refresher-enabled
    @refresherrefresh="onRefresh"
  >
    <span>关注用户的插画作品</span>
    <follow_user_work v-if="showComponent" />
    <re_work />
  </scroll-view>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import follow_user_work from './follow_user_work.vue'
import re_work from './re_work.vue'

const showComponent = ref(true)

const onRefresh = () => {
  // 用 v-if 重新加载组件，达到刷新目的
  showComponent.value = false
  setTimeout(() => {
    showComponent.value = true
    uni.stopPullDownRefresh?.() // 结束下拉刷新动画
  }, 1000)
}

onMounted(() => {
  // 页面首次挂载时，确保下拉刷新状态被清除
  uni.stopPullDownRefresh?.()
})
</script>

<style lang="scss" scoped>
</style>

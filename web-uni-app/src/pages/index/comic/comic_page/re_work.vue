<template>
  <scroll-view
    class="content"
    scroll-y
    @scrolltolower="onReachBottom"
    lower-threshold="100"
  >
    <text class="title">推荐作品</text>

    <view class="work_list">
      <view
        class="work_item"
        v-for="(item, index) in re_work"
        :key="index"
      >
        <image
          class="work_image"
          :src="static_url + (item.content_file_list?.[0] ?? '图像.png')"
          mode="aspectFill"
          @error="onImageError"
          @click="to_content_page(item.id)"
        />
        <text class="page_count">{{ item.content_file_list?.length ?? 0 }}</text>
      </view>
    </view>

    <view class="loading" v-if="loading">加载中...</view>
    <view class="done" v-else-if="!hasMore">已加载全部</view>
  </scroll-view>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import BaseApi from '@/BaseApi'
import { useStore } from '@/store';
const store = useStore();

const to_content_page=(work_id)=>{
    uni.navigateTo({url:'../content/content_index'})
    store.$state.jump_page_info={work_id:work_id,work_type:'comic'}
}

const re_work = ref([])
const limit = 10
const offset = ref(0)
const total = ref(0)
const loading = ref(false)
const hasMore = ref(true)
const api = BaseApi
const static_url = BaseApi.IMG_URL+'comic/'
const defaultImage = static_url + '图像.png'
const onImageError = (item) => {
  item.imgSrc = defaultImage
}

const get_re_work = async () => {
  if (loading.value || !hasMore.value) return
  loading.value = true

  try {
    const res = await api.post('api/ReWork', {
      limit,
      offset: offset.value,
      work_type: 'comic'
    })

    if (res.code === 200 && Array.isArray(res.data)) {
      const list = res.data.map(item => {
        if (item.content_file_list) {
          item.content_file_list = item.content_file_list
            .split(/[,，]+/)
            .map(f => f.trim())
        }
        return item
      })

      re_work.value.push(...list)
      offset.value += list.length
      total.value = res.total

      if (offset.value >= res.total) {
        hasMore.value = false
      }
    }
  } catch (e) {
    console.error('获取失败:', e)
  } finally {
    loading.value = false
  }
}

const onReachBottom = () => {
  get_re_work()
}

onMounted(() => {
  get_re_work()
})
</script>

<style lang="scss" scoped>
.content {
  height: 100vh;
  overflow: auto;
  padding: 20rpx;
  box-sizing: border-box;
}

.title {
  display: block;
  font-size: 36rpx;
  font-weight: bold;
  margin-bottom: 20rpx;
}

.work_list {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 20rpx;
}

.work_item {
  background: #f2f2f2;
  border-radius: 12rpx;
  overflow: hidden;
  position: relative;
  width: 100%;
  height: 0;
  padding-bottom: 100%; /* 保证宽高比1:1 */
}

.work_image {
  position: absolute;
  width: 100%;
  height: 100%;
  object-fit: cover;
  top: 0;
  left: 0;
  border-radius: 12rpx;
}

.page_count {
  text-align: center;
  position: absolute;
  z-index: 2;
  right: 0;
  top: 0;
  background-color: rgba(0, 0, 0, 0.6);
  padding: 5px;
  border-radius: 0 0 0 12rpx;
  color: white;
}

.loading,
.done {
  text-align: center;
  font-size: 26rpx;
  color: #999;
  margin: 20rpx 0;
  padding: 10rpx;
}
</style>
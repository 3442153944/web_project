<template>
    <scroll-view class="content" scroll-y @scrolltolower="onReachBottom" lower-threshold="100">
        <text class="title">推荐小说</text>

        <view class="work_list">
            <view class="work_item" v-for="(item, index) in re_work" :key="index">
                <image class="work_image" :src="static_url + (item.work_cover || '默认封面.jpg')" mode="aspectFill"
                    @error="onImageError" @click="to_content_page(item.work_id)" />
                <text class="work_name">{{ item.work_name || '未命名作品' }}</text>
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

const to_content_page = (work_id) => {
    uni.navigateTo({ url: '../content/content_index' })
    store.$state.jump_page_info = { work_id: work_id, work_type: 'novel' }
}

const re_work = ref([])
const limit = 10
const offset = ref(0)
const total = ref(0)
const loading = ref(false)
const hasMore = ref(true)

const static_url = BaseApi.IMG_URL + 'novel/'
const defaultImage = static_url + '默认封面.jpg'

const get_re_work = async () => {
    if (loading.value || !hasMore.value) return
    loading.value = true

    try {
        const res = await BaseApi.post('api/ReWork', {
            limit,
            offset: offset.value,
            work_type: 'novel'
        })
        console.log('获取推荐的小数作品', res)

        if (res.code === 200 && Array.isArray(res.data)) {
            const list = res.data.map(item => {
                return {
                    ...item,
                    work_cover: item.work_cover?.trim() || '',
                }
            })

            re_work.value.push(...list)
            offset.value += list.length
            total.value = res.total

            if (offset.value >= res.total) {
                hasMore.value = false
            }
        }
    } catch (e) {
        console.error('获取推荐小说失败:', e)
    } finally {
        loading.value = false
    }
}

const onImageError = (e) => {
    e.target.src = defaultImage
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
    background-color: #f9f9f9;
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
    background: #fff;
    border-radius: 12rpx;
    overflow: hidden;
    position: relative;
    display: flex;
    flex-direction: column;
    box-shadow: 0 4rpx 8rpx rgba(0, 0, 0, 0.05);
}

.work_image {
    width: 100%;
    aspect-ratio: 2 / 3; // 6:9 的等价比例
    object-fit: cover;
    border-radius: 12rpx 12rpx 0 0;
}

.work_name {
    font-size: 28rpx;
    padding: 10rpx;
    text-align: center;
    color: #333;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
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
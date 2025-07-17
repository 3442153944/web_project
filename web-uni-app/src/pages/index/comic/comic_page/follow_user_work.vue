<template>
    <view class="content" v-if="is_loding">
        <view class="work_item" v-for="(value, key) in work_list" :key="key">
            <!-- 用户信息部分 -->
            <user_box :user_id="key"></user_box>

            <!-- 作品列表 -->
            <view class="work_list">
                <view class="work" v-for="(item, index) in value" :key="index">
                    <image 
                        :src="static_url + (item.content_file_list[0] ?? '图像.png')" 
                        mode="aspectFill"
                        @load="(e) => setAspectRatio(e, key, index)"
                        :style="{ aspectRatio: aspectRatios[`${key}_${index}`] || '3/4' }"
                    />
                    <view class="page_count">
                        <text>{{ item.content_file_list.length ?? 0 }}</text>
                    </view>
                </view>
            </view>
        </view>
    </view>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue';
import BaseApi from "@/BaseApi";
import user_box from './user_box.vue';

const api = BaseApi;
const work_list = ref({});
const static_url = computed(() => BaseApi.IMG_URL+'comic/');
const is_loding = ref(false);
const aspectRatios = ref({}); // 存储宽高比

const get_re_work = async () => {
    try {
        const res = await api.post("GetUserInfo/GetUserFollowToComic/", {});
        console.log('获取关注用户的插画作品', res);
        return res.status === 'success' ? res.data : [];
    } catch (error) {
        console.error('获取作品信息失败:', error);
        return [];
    }
};

onMounted(async () => {
    const data = await get_re_work();
    if (!data?.length) return;

    work_list.value = data.reduce((acc, item) => {
        const userId = item.belong_to_userid;
        acc[userId] = acc[userId] || [];
        
        // 处理 content_file_list
        if (item.content_file_list) {
            item.content_file_list = item.content_file_list.split(/[,，]+/).map(file => file.trim());
        }
        
        acc[userId].push(item);
        return acc;
    }, {});

    is_loding.value = true;
});

// 设置宽高比
const setAspectRatio = (e, userId, index) => {
    const { width, height } = e.detail;
    if (width && height) {
        aspectRatios.value[`${userId}_${index}`] = `${width}/${height}`;
    }
};
</script>

<style lang="scss" scoped>
.content {
    display: flex;
    flex-direction: column;
    gap: 20px;
    padding: 20px;
}

.work_item {
    display: flex;
    flex-direction: column;
    gap: 15px;
}

.work_list {
    display: flex;
    gap: 10px;
    padding: 0;
    overflow-x: auto;
    scrollbar-width: none;
    
    &::-webkit-scrollbar {
        display: none;
    }
}

.work {
    position: relative;
    height: 180px;
    flex-shrink: 0;
    border-radius: 8px;
    overflow: hidden;
    border: 1px solid #ccc;
    min-width: 80px;
    max-width: 360px;
    
    image {
        width: 100%;
        height: 100%;
        object-fit: cover;
        display: block;
    }
}

.page_count {
    position: absolute;
    top: 5px;
    right: 5px;
    background-color: rgba(0, 0, 0, 0.6);
    color: white;
    padding: 2px 8px;
    border-radius: 12px;
    font-size: 12px;
    z-index: 10;
}

.user_box {
    margin-bottom: 10px;
}
</style>
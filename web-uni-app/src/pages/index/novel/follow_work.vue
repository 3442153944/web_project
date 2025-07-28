<template>
    <view class="content">
        <text>关注用户的小说作品</text>
        <scroll-view class="user_list" scroll-y enable-flex="true">
            <view class="item" v-for="(value, key) in work_list" :key="key">
                <user_box :user_id="key" />
                <scroll-view class="item_list" scroll-x enable-flex="true">
                    <view class="work" v-for="(item, index) in value" :key="index">
                        <image
                            :src="cover_url + item.work_cover"
                            mode="aspectFill"
                            @click="to_content_page(item.work_id)"
                        />
                        <text class="work_name">{{ item.work_name }}</text>
                    </view>
                </scroll-view>
            </view>
        </scroll-view>
    </view>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import BaseApi from '@/BaseApi';
import user_box from './user_box.vue';
import { useStore } from '@/store';
const store = useStore();

const work_list = ref({});
const cover_url = computed(() => { return BaseApi.IMG_URL + 'novel/' });

const to_content_page=(work_id)=>{
    uni.navigateTo({url:'../content/content_index'})
    store.$state.jump_page_info={work_id:work_id,work_type:'novel'}
}

const get_work_list = async () => {
    try {
        const res = await BaseApi.post("GetUserInfo/GetUserFollowNovel/", {});
        console.log('获取关注小说列表', res);
        if (res.status == 'success') {
            return res.data;
        }
        return null;
    }
    catch (e) {
        console.error('获取用户信息失败:', e);
        return null;
    }
}

onMounted(async () => {
    let data = await get_work_list();
    if (!data || !Array.isArray(data)) return;  // 确保 data 是一个数组
    data = data.reduce((acc, item) => {
        if (!item || !item.belong_to_userid) return acc;  // 检查 item 和 belong_to_userid 是否有效
        if (!acc[item.belong_to_userid]) {
            acc[item.belong_to_userid] = [];
        }
        acc[item.belong_to_userid].push(item);
        return acc;
    }, {});
    work_list.value = data;
});
</script>

<style lang="scss" scoped>
.content {
    display: flex;
    flex-direction: column;
    gap: 10px;
    padding: 20px;
    background-color: #f8f8f8;
}

.user_list {
    display: flex;
    flex-direction: column;
    gap: 15px;
}

.item {
    display: flex;
    flex-direction: column;
    gap: 10px;
    padding: 10px;
    background: #fff;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    border-radius: 10px;
    border: 1px solid rgba(0, 0, 0, 0.1);
}

.item_list {
    display: flex;
    gap: 20px;
    padding: 0;
    overflow-x: auto;
}

.work {
    display: flex;
    flex-direction: column;
    gap: 5px;
    height: auto;
    width: 32%; /* 每行3列 */
    padding: 5px;
    background: #f9f9f9;
    border-radius: 8px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    border: 1px solid rgba(0, 0, 0, 0.1);
    &:first-child{
        margin-left: 0;
    }
    &:last-child{
        margin-right: 0;
    }
    margin-left: 10px;
}

.work_name {
    font-size: 14px;
    color: #333;
    text-align: center;
    margin-top: 8px;
    text-overflow: ellipsis;
    white-space: nowrap;
    overflow: hidden;
}

.work image {
    width: 100%;
    height: 100%;
    object-fit: cover;
    border-radius: 8px;
    aspect-ratio: 6 / 9; /* 固定6:9的宽高比 */
    min-width: 200px;
    min-height: 300px;
}

.head-box-wrapper {
    margin-bottom: 15px;
}

/* 小屏幕适配 */
@media (max-width: 768px) {
    .work {
        width: 48%; /* 小屏时每行显示 2 个 */
    }
}

@media (max-width: 480px) {
    .work {
        width: 100%; /* 超小屏时每行显示 1 个 */
    }
}
</style>

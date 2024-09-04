<template>
  <div class="comment_page">
    <h1>评论管理</h1>
    <div class="content" v-if="comment_list.length > 0">
      <div class="search_box">
        搜索评论：
      </div>
      <div class="item_list">
        <div class="item" v-for="(item, index) in comment_list" :key="index">
          <div class="user_info">
            <div class="user_avatar">
              <img :src="getAvatarUrl(item.user_avatar)" alt="用户头像" />
            </div>
            <div class="user_name">
              <span>{{ item.username }}</span>
            </div>
          </div>
          <div class="work_info">
            <span>作品名称：</span>
            <span>{{ getWorkName(item) }}</span>
            <span>作品类型：</span>
            <span>{{ getWorkType(item.work_type) }}</span>
          </div>
          <div class="comment_content">
            <span>{{item.content}}</span>
          </div>
        </div>
        <div class="check_point" ref="check_point" style="width:1px;height:1px;display:none;"></div>
        <div class="loding" v-if="is_loding">
          <span>加载中……</span>
        </div>
      </div>
    </div>
    <div v-else>
      <p>暂无评论</p>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted, nextTick } from 'vue'
import { get_comment_list } from './js/get_work_list'

const comment_list = ref([])
const limit = ref(10)
const offset = ref(0)
const total = ref(0)
const check_point = ref(null)
const is_loding = ref(false)

// IntersectionObserver 回调函数
const observer = new IntersectionObserver(async (entries) => {
  if (entries[0].isIntersecting && comment_list.value.length < total.value) {
    is_loding.value = true
    offset.value += limit.value
    await get_comment_info_list()
    is_loding.value = false
  }
}, {
  root: null,
  rootMargin: '400px',
  threshold: 0
})

const getAvatarUrl = (avatar) => `https://www.sunyuanling.com/image/avatar_thumbnail/${avatar}`

const getWorkName = (item) => {
  if (item.work_type === 'ill') {
    return item.work_data.name
  }
  return item.work_data.work_name
}

const getWorkType = (workType) => {
  return workType === 'ill' ? '插画' : workType === 'comic' ? '漫画' : '小说'
}

// 获取评论列表
async function get_comment_info_list() {
  const response = await get_comment_list(limit.value, offset.value)
  if (response && response.data) {
    comment_list.value = [...comment_list.value, ...response.data.comment_list]
    total.value = response.data.total
  }
}

onMounted(async () => {
  await get_comment_info_list()
  await nextTick()  // 确保 DOM 元素已经渲染
  if (check_point.value) {
    observer.observe(check_point.value)
  }
})

onUnmounted(() => {
  observer.disconnect()
})

</script>

<style scoped>
.comment_page {
  width:100%;
  height: 100%;
  display: flex;
  flex-direction: column;
  gap:20px;
}
.content{
  width:100%;
  height: 100%;
  display: flex;
  flex-direction: column;
  gap:10px;
}
.user_info {
  display: flex;
  align-items: center;
}

.user_avatar img {
  width: 50px;
  height: 50px;
  border-radius: 50%;
  object-fit: cover;
}

.user_name {
  margin-left: 10px;
}

.work_info {
  margin-top: 10px;
  font-size: 14px;
  color: #333;
}

.item_list {
  width:100%;
  height: auto;
  display: flex;
  flex-direction: column;
  gap:10px;
}

.item {
  padding: 10px;
  border-bottom: 1px solid #ddd;
}
</style>

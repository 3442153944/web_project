<template>
  <div class="collect_page">
    <div class="content">
      <div class="is_open">
        <div class="switch_open_status">
          <span>公开</span>
          <span>不公开</span>
        </div>
      </div>
      <div class="title">
        <span>作品</span>
        <span>管理收藏</span>
      </div>
      <div class="collect_list" v-if="collect_worklist.length">
        <div class="collect_item" v-for="(item, index) in collect_worklist" :key="index">
          <div class="item_box" v-if="item.work_status === 'normal'">
            <div class="work_type">
              <span>{{ getWorkType(item.type) }}</span>
            </div>
            <div class="work_item">
              <div class="image_container">
                <img :src="getImageSrc(item)" alt="作品封面">
                <div class="age_tag" v-if="item.work_info.age_classification && item.work_info.age_classification > 18">
                  <span class="age_num">{{ item.work_info.age_classification }}</span>
                </div>
                <div class="work_count" v-if="getFileCount(item) > 1">
                  <span class="work_num">{{ getFileCount(item) }}</span>
                </div>
              </div>
              <div class="work_name">
                <span>{{ item.work_info.work_name }}</span>
              </div>
              <div class="author_info">
                <div class="author_avatar">
                  <img :src="'https://www.sunyuanling.com/image/avatar_thumbnail/' + item.authorinfo.user_avatar" alt="作者头像">
                </div>
                <div class="author_name">
                  <span>{{ item.authorinfo.username }}</span>
                </div>
              </div>
            </div>
          </div>
          <div class="item_box_deleted" v-else-if="item.work_status === 'deleted'">
            <div class="item_box_deleted_text">作品已删除或者被管理员或者作者隐藏</div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, defineProps, onMounted } from 'vue'
import { get_user_collect_worklist } from '../../../js/get_workinfo'

const props = defineProps({
  user_info: {
    type: Object,
    default: () => ({})
  },
  token: {
    type: String,
    default: ''
  }
})

const collect_worklist = ref([])

onMounted(async () => {
  collect_worklist.value = await get_user_collect_worklist(props.token)
  console.log(collect_worklist.value)
})

function getWorkType(type) {
  switch (type) {
    case 'novel':
      return '小说'
    case 'ill':
      return '插画'
    case 'comic':
      return '漫画'
    default:
      return '其他'
  }
}

function getImageSrc(item) {
  const { type, work_info } = item
  const baseUrl = 'https://www.sunyuanling.com/image/'
  if (type === 'novel') {
    return `${baseUrl}novel/thumbnail/${work_info.work_cover}`
  } else if (type === 'ill') {
    return `${baseUrl}thumbnail/${work_info.content_file_list.split(/[,，]/)[0]}`
  } else if (type === 'comic') {
    return `${baseUrl}comic/thumbnail/${work_info.content_file_list.split(/[，,]/)[0]}`
  }
  return ''
}

function getFileCount(item) {
  const { content_file_list } = item.work_info
  if (content_file_list) {
    const files = content_file_list.split(/[,，]/)
    return files.length
  }
  return 0
}
</script>

<style scoped>
.collect_page {
  display: flex;
  flex-direction: column;
  padding: 20px;
}

.content {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.collect_list {
  display: flex;
  flex-wrap: wrap;
  gap: 20px;
  width: 100%;
  height: auto;
  overflow-y: auto;
}

.collect_item {
  flex: 1 1 calc(33.333% - 20px);
  box-sizing: border-box;
  max-width: 220px;
  max-height: 300px;
  min-width: 200px;
  min-height: 300px;
  display: flex;
  overflow: hidden;
  margin:10px;
}

.item_box {
  position: relative;
  display: flex;
  flex-direction: column;
  border: 1px solid #ddd;
  border-radius: 8px;
  overflow: hidden;
  background: #fff;
  width: 100%;
  height: 100%;
}

.work_type {
  position: absolute;
  top: 10px;
  left: 10px;
  background: #f1f1f1;
  padding: 4px 8px;
  border-radius: 4px;
}

.image_container {
  position: relative;
}

.age_tag {
  position: absolute;
  top: 10px;
  left: 10px;
  background: red;
  color: white;
  padding: 4px 8px;
  font-size: 16px;
  font-weight: bold;
  border-radius: 4px;
}

.work_count {
  position: absolute;
  top: 10px;
  right: 10px;
  background: rgba(0, 0, 0, 0.5);
  color: white;
  padding: 4px 8px;
  border-radius: 4px;
  display: flex;
  align-items: center;
  gap: 5px;
}

.work_item {
  display: flex;
  flex-direction: column;
  padding: 10px;
}

.work_name {
  margin-top: 10px;
}

.author_info {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-top: 10px;
}

.author_avatar img {
  width: 40px;
  height: 40px;
  border-radius: 50%;
}

.item_box_deleted {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100%;
  background: #f8d7da;
  color: #721c24;
  padding: 20px;
  border-radius: 8px;
}

.item_box_deleted_text {
  text-align: center;
}
</style>

<script setup>
import { defineProps, ref, onMounted } from 'vue'
import BaseApi from '@/BaseApi'
import content_head from "@/pages/content/content_head.vue"

const props = defineProps({ work_id: String })
const work_info = ref()
const img_url = ref(BaseApi.IMG_URL)
const size_dict = ref({})
const file_list = ref([])
const max_show = ref(1)
const now_file_list = ref([])

// 获取设备宽度
const device_width = ref(375) // 默认值，onMounted中获取

const get_size = async (e, index) => {
  try {
    const { width, height } = e.detail
    if (width && height) {
      const ratio = height / width
      const display_height = device_width.value * ratio
      size_dict.value[index] = {
        width,
        height,
        display_height,
      }
    }
  } catch (e) {
    console.log(e)
    size_dict.value[index] = { width: 0, height: 0, display_height: 200 }
  }
}

const get_work_info = async () => {
  try {
    const res = await BaseApi.post('get_work_info/GetIllInfo/', {
      work_id: props.work_id,
    })
    console.log(res)
    if (res.code === 200) {
      let data = res.data[0]
      data.content_file_list = data.content_file_list.split(/[,，]+/).map(f => f.trim())
      work_info.value = data
      file_list.value = data.content_file_list
      now_file_list.value.push(data.content_file_list[0])
    }
  } catch (e) {
    console.log(e)
  }
}

onMounted(() => {
  // 获取系统信息
  uni.getSystemInfo({
    success: res => {
      device_width.value = res.windowWidth
    },
  })
  get_work_info()
})
</script>


<template>
  <view class="work_content">
    <content_head></content_head>
    <view class="item" v-for="(item, index) in now_file_list" :key="index">
      <image :src="img_url + item" mode="widthFix" @load="(e) => get_size(e, index)"
        :style="{ width: device_width + 'px', height: size_dict[index]?.display_height + 'px' }" />
    </view>
  </view>
</template>

<style scoped></style>
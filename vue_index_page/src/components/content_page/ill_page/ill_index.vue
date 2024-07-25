<template>
    <div class="ill_index" ref="ill_index">
      <go_back></go_back>
      <div class="content" v-if="work_info">
        <div class="item_box">
          <div class="item" v-for="(item, index) in work_info.content_file_list.split(/[,，]/)" :key="index">
            <img :src="'https://www.sunyuanling.com/image/content_thumbnail/' + item" class="item_img"
                 @click="show_work_info(item)">
          </div>
        </div>
      </div>
    </div>
    <img_content_page :item_path="item_path" v-if="img_content_page_show" @close_img_content_page="close_content_page">
    </img_content_page>
  </template>
  
  <script setup>
  import { ref, watch, onMounted } from 'vue';
  import { useStore } from 'vuex';
  import go_back from '../go_back.vue';
  import img_content_page from '../img_content_page/img_content_page.vue';
  
  const store = useStore();
  const work_id = ref('');
  const work_info = ref();
  const img_content_page_show = ref(false);
  const item_path = ref('');
  
  const props = defineProps({
    work_id: {
      type: String,
      default: '1'
    }
  });
  
  watch(() => props.work_id, (newValue) => {
    work_id.value = newValue;
  });
  
  watch(() => store.getters.work_id, (newValue) => {
    work_id.value = newValue;
  });
  
  onMounted(async () => {
    work_id.value = store.getters.work_id;
    await get_work_info();
    console.log(work_info.value);
  });
  
  // 使用ID请求作品信息
  async function get_work_info() {
    try {
      const res = await fetch('https://www.sunyuanling.com/api/get_work_info/GetIllInfo/', {
        method: 'post',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          work_id: work_id.value
        })
      });
      if (res.ok) {
        const data = await res.json();
        if (data.status === 'success') {
          work_info.value = data.data[0];
        } else {
          console.log(data.message);
        }
      }
    } catch (e) {
      console.log(e);
    }
  }
  
  // 查看作品详情
  function show_work_info(item) {
    img_content_page_show.value = true;
    item_path.value = item;
    store.commit('SET_ITEM_PATH',item)
  }
  
  watch(img_content_page_show, (newValue) => {
    if (newValue) {
      // 禁止父组件滚动
      document.body.style.overflow = 'hidden';
    } else {
      // 恢复父组件滚动
      document.body.style.overflow = '';
    }
  });
  
  function close_content_page() {
    img_content_page_show.value = false;
  }
  </script>
  
  <style scoped>
  .ill_index {
    display: flex;
    flex-direction: column;
    width: 80%;
    height: auto;
    margin: 10px auto;
    background-color: rgba(0, 0, 0, 0.05);
    border-radius: 10px;
  }
  
  .content {
    display: flex;
    flex-direction: column;
    width: 100%;
    height: 100%;
    position: relative;
    gap: 10px;
  }
  
  .item_box {
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column;
    gap: 10px;
  }
  
  .item {
    display: flex;
    width: 90%;
    height: auto;
    justify-content: center;
    margin: 5px auto;
    border-radius: 10px;
    overflow: hidden;
    cursor: zoom-in;
  }
  
  .item_img {
    width: 100%;
    height: auto;
    object-fit: cover;
  }
  </style>
  
<template>
  <div class="search_page_index">
    <div class="close_btn" @click="close_btn_click()">
      <img class="icon" src="https://www.sunyuanling.com/assets/close.svg" alt="close_btn">
    </div>
    <div class="content">
      <div class="head_box">
        <div class="search_result_cover"></div>
        <div class="search_result_info_box">
          <div  class="search_tag_name"></div>
          <div calss='search_result_count'></div>
        </div>
      </div>
      <ill_page :ill_data="ill_list"></ill_page>
      <comic_page :comic_data='comic_list'></comic_page>
      <novel_page :novel_data="novel_list"></novel_page>
    </div>
  </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted, defineProps, defineEmits,defineExpose } from 'vue';
// eslint-disable-next-line no-unused-vars
import * as cookies from '../../../../../../model/cookies.js'
import ill_page from './page/ill_page.vue'
import comic_page from './page/comic_page.vue'
import novel_page from './page/novel_page.vue'
export default {
  name: 'search_page_index',
  components:{
    ill_page,
    comic_page,
    novel_page
  }
}

</script>

<script setup>
let props = defineProps({
  search_item: {
    type: String,
    default: '德丽莎'
  }
})
let search_data = ref(props.search_item)
let ill_list = ref([])
let comic_list = ref([])
let novel_list = ref([])
let tag_list=ref()
watch(() => props.search_item, async (new_value, old_value) => {
  search_data.value = await get_search_data(new_value)
  categorize_data(search_data.value)
  set_tag_list(search_data.value)
  console.log(tag_list.value)
}
)
function categorize_data(data) {
  ill_list.value = [];
  comic_list.value = [];
  novel_list.value = [];
  if (data == null) {
    return
  }
  else {
    data.forEach(item => {
      if (item.type === 'ill') {
        ill_list.value.push(item);
      } else if (item.type === 'comic') {
        comic_list.value.push(item);
      } else if (item.type === 'novel') {
        novel_list.value.push(item);
      }
    });
  }
}
//放入所有的tag
function set_tag_list(data) {
  if (data == null) {
    tag_list.value = []
    return
  }
  let all_tags = data.flatMap(item => item.work_tags.split(/[,，]/).map(tag => tag.trim()))
  tag_list.value = [...new Set(all_tags)]
}

let close_msg = defineEmits(['close_msg'])
function close_btn_click() {
  close_msg('close_msg', false)
}

async function get_search_data(data) {
  search_data.value = null
  try {
    const res = await fetch('https://www.sunyuanling.com/api/GetUserInfo/GetSearch/', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        'search_key': data
      })
    })
    if (res.ok) {
      const data = await res.json()
      if (data.status == 'success') {
        console.log(data.data)
        return data.data
      }
      else {
        console.log(data.message)
        return []
      }
    }
  } catch (error) {
    console.log(error)
    return []
  }
}
defineExpose({
  get_search_data
})

</script>

<style scoped>
.search_page_index {
  position: fixed;
  top: 65px;
  left: 0;
  width: 100vw;
  height: 100vh;
  z-index: 15;
  background-color: rgba(255, 255, 255, 1);
}

.close_btn {
  display: flex;
  width: 35px;
  height: 35px;
  align-items: center;
  justify-content: center;
  position: absolute;
  right: 30px;
}

.close_btn:hover {
  cursor: pointer;
  background-color: rgba(0, 0, 0, 0.5);
  border-radius: 50%;
  transition: all 0.3s ease-in-out;
}

.icon {
  width: 25px;
  height: 25px;
}

.content {
  display: flex;
  flex-direction: column;
  width: 100%;
  height: 100%;
  margin-top: 30px;
}
.head_box{
  display: flex;
  width: 80%;
  height: 150px;
}
</style>
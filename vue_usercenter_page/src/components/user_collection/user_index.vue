<template>
  <div class="user_index">
    <div class="switch_page">
      <div class="page1" @click="switchPage(1)">主页</div>
      <div class="page3" @click="switchPage(3)">插画</div>
      <div class="page4" @click="switchPage(4)">小说</div>
      <div class="page2" @click="switchPage(2)">收藏</div>
    </div>
    <user_index_page v-if="page1"></user_index_page>
    <user_collection_page v-if="page2"></user_collection_page>
    <user_ill_page v-if="page3"></user_ill_page>
    <user_novel_page v-if="page4"></user_novel_page>
  </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted } from 'vue';
import user_index_page from './user_index_page/user_index_page.vue';
import user_collection_page from './user_collection_page/user_collection_page.vue'
import user_ill_page from './user_ill_page/user_ill_page.vue'
import user_novel_page from './user_novel_page/user_novel_page.vue'
export default {
  name: 'user_index',
  components: { user_index_page, user_collection_page, user_ill_page, user_novel_page },
}
</script>

<script setup>
let page1 = ref(true);
let page2 = ref(false);
let page3 = ref(false);
let page4 = ref(false);
//页面切换的同时为按钮切换点击样式
function switchPage(index) {
  let p1 = document.querySelector(".page1");
  let p2 = document.querySelector(".page2");
  let p3 = document.querySelector(".page3");
  let p4 = document.querySelector(".page4");

  if (index == 1) {
    page2.value = false;
    page1.value = true;
    page3.value = false;
    page4.value = false;
    p2.style = ''
    p3.style = ''
    p4.style = ''
    p1.style.boxShadow = "0px 0px 5px 0px rgba(0,0,0,0.3)";
    p1.style.borderBottom = "3px solid rgba(0,150,250,1)";
  }
  else if (index == 2) {
    page1.value = false;
    page2.value = true;
    page3.value = false;
    page4.value = false;
    p1.style = ''
    p3.style = ''
    p4.style = ''
    p2.style.boxShadow = "0px 0px 5px 0px rgba(0,0,0,0.3)";
    p2.style.borderBottom = "3px solid rgba(0,150,250,1)";
  }
  else if (index == 3) {
    page1.value = false;
    page2.value = false;
    page3.value = true;
    page4.value = false;
    p1.style = ''
    p2.style = ''
    p4.style = ''
    p3.style.boxShadow = "0px 0px 5px 0px rgba(0,0,0,0.3)";
    p3.style.borderBottom = "3px solid rgba(0,150,250,1)";
  }
  else if (index == 4) {
    page1.value = false;
    page2.value = false;
    page3.value = false;
    page4.value = true;
    p1.style = ''
    p2.style = ''
    p3.style = ''
    p4.style.boxShadow = "0px 0px 5px 0px rgba(0,0,0,0.3)";
    p4.style.borderBottom = "3px solid rgba(0,150,250,1)";
  }
}
onMounted(() => {
  switchPage(1);
})
</script>

<style scoped>
.user_index {
  display: flex;
  margin-top: 40px;
  width: 90%;
  height: auto;
  margin-left: auto;
  margin-right: auto;
  justify-content: center;
  margin-bottom: 40px;
  justify-content: flex-start;
  flex-direction: column;
}

.switch_page {
  display: flex;
  max-width: 300px;
  width: auto;
  height: auto;
  padding: 5px;
  align-self: flex-start;
  font-size: 18px;
  font-weight: bold;
}

.page1 {
  padding: 10px;
  cursor: pointer;
}

.page2,
.page3,
.page4 {
  padding: 10px;
  cursor: pointer;
}
</style>
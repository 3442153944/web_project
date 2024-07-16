<!-- eslint-disable no-unused-vars -->
<template>
  <work_tags></work_tags>
  <div class="switch_page">
    <span class="active" @click="choosePage(0)">插画</span>
    <span class="active" @click="choosePage(1)">漫画</span>
    <span class="active" @click="choosePage(2)">小说</span>
  </div>
  <illustration_page v-if="pageIndex === 0"></illustration_page>
  <cartoon_page v-if="pageIndex === 1"></cartoon_page>
  <novel_page v-if="pageIndex === 2"></novel_page>
</template>

<script setup>
// eslint-disable-next-line no-unused-vars
import { onMounted, ref, watch } from 'vue';
import work_tags from './work_tags/work_tags.vue';
import illustration_page from './Illustration_page/Illustration_page.vue';
import cartoon_page from './cartoon/cartoon_page.vue';
import novel_page from './novel_page/novel_page.vue';
import { useStore } from 'vuex';

const store = useStore();

const pageIndex = ref(store.state.pageStatus);
watch(
  () => store.state.pageStatus,
  (newValue) => {
    pageIndex.value = newValue;
    updateButtonStyles(newValue);
  }
);
onMounted(async () => {
  await store.dispatch('getUserInfo');
  console.log('User Info:', store.getters.userinfo);
});
function choosePage(index) {
  store.commit('SET_PAGESTATUS', index);
}

function updateButtonStyles(index) {
  let btns = document.querySelectorAll('.switch_page > span.active');

  // 遍历所有按钮
  btns.forEach((button, i) => {
    if (i === index) {
      // 当索引匹配时，添加样式并显示对应的页面
      button.style.backgroundColor = 'rgba(233, 233, 233, 1)';
      button.style.borderBottom = '3px solid rgba(0, 150, 250, 1)';
    } else {
      // 否则，移除样式并隐藏页面
      button.style.backgroundColor = '';
      button.style.borderBottom = '';
    }
  });
}

onMounted(() => {
  updateButtonStyles(pageIndex.value);
  choosePage(0)
});
</script>

<style scoped>
.switch_page {
  display: flex;
  width: 80%;
  margin: 0 auto;
  margin-top: 20px;
}
.active {
  margin-left: 10px;
  padding: 5px;
  margin: 0px;
  font-size: 18px;
  cursor: pointer;
  font-weight: bold;
}
/* 图像抗锯齿处理 */
img {
  image-rendering: -moz-crisp-edges;
  image-rendering: -webkit-optimize-contrast;
  image-rendering: crisp-edges;
  -ms-interpolation-mode: nearest-neighbor;
  image-rendering: smooth;
}
</style>

<!-- eslint-disable no-unused-vars -->

<template>
 <work_tags></work_tags>
 <div class="switch_page">
  <span class="active" @click="choose_page(0)">插画</span>
  <span class="active" @click="choose_page(1)">漫画</span>
  <span class="active" @click="choose_page(2)">小说</span>
 </div>
 <illustration_page></illustration_page>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { onMounted, ref } from 'vue';
import work_tags from './work_tags/work_tags.vue'
import illustration_page from './Illustration_page/Illustration_page.vue'

export default {
  // eslint-disable-next-line vue/multi-word-component-names
  name: 'index',
  components: {
    work_tags,illustration_page,
  },
};
</script>
<script setup>
function choose_page(index) {
  let btn = document.querySelectorAll('.active');

  // 遍历所有按钮，重置样式
  btn.forEach((button, i) => {
    if (i === index) {
      // 当传入的值等于特定的值时，为其添加背景和边框样式
      button.style.backgroundColor = 'rgba(233, 233, 233, 1)';
      button.style.borderBottom = '3px solid rgba(0, 150, 250, 1)';
    } else {
      // 否则，移除背景和边框样式
      button.style.backgroundColor = '';
      button.style.borderBottom = '';
    }
  });
}
onMounted(()=>{
  choose_page(0)
})

</script>

<style scoped>
/* 在这里添加组件的样式 */
.switch_page{
  display: flex;
  width:80%;
  margin:0 auto;
  margin-top: 20px;
}
.active{
  margin-left:10px;
 
  padding:5px;
  margin:0px;
  font-size:18px;
  cursor: pointer;
  font-weight: bold;
}
/*图像抗锯齿处理*/
img {
  image-rendering: -moz-crisp-edges;
  image-rendering: -webkit-optimize-contrast;
  image-rendering: crisp-edges;
  -ms-interpolation-mode: nearest-neighbor;
  image-rendering: smooth;
}
</style>

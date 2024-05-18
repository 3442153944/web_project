<!-- eslint-disable no-unused-vars -->

<template>
 <work_tags></work_tags>
 <div class="switch_page">
  <span class="active" @click="choose_page(0)">插画</span>
  <span class="active" @click="choose_page(1)">漫画</span>
  <span class="active" @click="choose_page(2)">小说</span>
 </div>
 <illustration_page v-if="ill_show"></illustration_page>
 <cartoon_page v-if="cartoon_show"></cartoon_page>
 <novel_page v-if="novel_show"></novel_page>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { onMounted, ref } from 'vue';
import work_tags from './work_tags/work_tags.vue'
import illustration_page from './Illustration_page/Illustration_page.vue'
import cartoon_page from './cartoon/cartoon_page.vue'
import novel_page from './novel_page/novel_page.vue'

export default {
  // eslint-disable-next-line vue/multi-word-component-names
  name: 'index',
  components: {
    work_tags,illustration_page,cartoon_page,novel_page,
  },
};
</script>
<script setup>
let ill_show=ref(true);
let cartoon_show=ref(false);
let novel_show=ref(false);
function choose_page(index) {
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
  })
  switch_show(index);
}

onMounted(()=>{
  choose_page(0)
})

function switch_show(index){
  switch(index){
    case 0:
      ill_show.value=true;
      cartoon_show.value=false;
      novel_show.value=false;
      break;
    case 1:
      ill_show.value=false;
      cartoon_show.value=true;
      novel_show.value=false;
      break;
    case 2:
      ill_show.value=false;
      cartoon_show.value=false;
      novel_show.value=true;
      break;
  }
}

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

<template>
  <div class="novel_content" >
    <div class="novel_content_box">
        <novel_content_box></novel_content_box>
        <word_content></word_content>
    </div>
    <div class="author_box">
        <author_box></author_box>
    </div>
  </div>
  <hr style="width:86%">
  <div class="series_box">
    <seriex_box></seriex_box>
  </div>
  <div class="interactive" v-show="act1" :style="{position:posi, bottom:bot+'px',width:'100%',transform:`translateY(${ad_y}px)`}"><interactive_box></interactive_box></div>
  <div class="interactive" id="interactive"><interactive_box></interactive_box></div>
  <test></test>
</template>

<script lang="ts">
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted,mounted } from 'vue';
// @ts-ignore
import novel_content_box from './novel_content_box/novel_content_box.vue';
import author_box from './author_box/author_box.vue';
import word_content from './word_content/word_content.vue';
import seriex_box from './series_box/series_box.vue';
import interactive_box from './interactive_box/interactive_box.vue';
import test from './test/test.vue';

export default {
  name: 'novel_content',
  components:{novel_content_box,author_box,word_content,seriex_box,interactive_box,test,},
}
</script>

<script setup lang="ts">
const lastScrollPosition = ref(0);
const posi = ref('fixed');
const bot = ref(0);
const ad_y = ref(0);
const act1 = ref(true);

function do_action() {
  let main_page = document.getElementById('interactive');
  let main_top_hight = main_page.getBoundingClientRect().top;
  let root_hight = window.innerHeight;
  const currentScrollPosition = window.scrollY || document.documentElement.scrollTop;

  // 确定滚动方向  
  if (currentScrollPosition > lastScrollPosition.value) {
    act1.value = false;
    ad_y.value=0;
    const intervalId = setInterval(() => {
      ad_y.value += 1;
      if (ad_y.value >= 100) {
        clearInterval(intervalId);
      }
    }, 50);
  } else if (currentScrollPosition < lastScrollPosition.value) {
    act1.value = true;
    ad_y.value=100;
    bot.value=-60;
    const intervalId = setInterval(() => {
      ad_y.value -= 2;
      bot.value+=1;
      if (ad_y.value <= 0||bot.value>=0) {
        clearInterval(intervalId);
        bot.value=0;
        ad_y.value=0;
      }
    }, 50);
  }

  // 更新最后的滚动位置  
  lastScrollPosition.value = currentScrollPosition;
}

onMounted(() => {
  // 监听window对象的滚动事件  
  window.addEventListener('scroll', do_action);
  // 首次挂载时执行一次do_action  
  do_action();
});
    
</script>

<style scoped>
  .novel_content{
    display: flex;
    margin-top:20px;
    margin-left: auto;
    margin-right: auto;
    width:85%;
    height: auto;
    min-height: 200px;
    position: relative;
    background-color: rgba(240,240,240,1);
    padding:5px;
   
  }
  .novel_content_box{
    display: flex;
    flex-direction: column;
    width:70%;
    min-height: 200px;
    padding:5px;
  }
  .author_box{
    display: flex;
   
    width:30%;
    min-height: 200px;
    padding:5px;
}
.series_box{
    display: flex;
    flex-direction: column;
    width:60%;
    height: auto;
    min-height: 100px;
    align-content: center;
    align-self: center;
    margin-left: auto;
    margin-right: auto;
    margin-top:20px;
    padding: 5px;
    margin-bottom: 5px;
}
.interactive{
  margin-top:20px;
}
</style>
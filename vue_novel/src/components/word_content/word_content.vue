<template>
  <div class="word_content">
    {{word}}
  </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted } from 'vue';
export default {
  name: 'word_content',
}
</script>

<script setup>
let word = ref(`最近发生了不少事情，也让我对某些事情有了一点新的体验，同时也带来了不少的灵感。
尤其是那部《憧憬成为魔法少女》，哦牛逼，魔法少女题材还能这样写。
有点打算写一个阴暗系主角的故事，不过无论是诺霖诺汐还是林萱她们都不太适合阴暗系，也不太能够成为新系列的主角（我的脑子会不够用的），因此考虑把养女转正来当新系列的主角。
新系列的故事可能会更多倾向于反派视角，讲述幻觉魔法在反派手中的运用方法（？
至于玩法方面可能会比较无底线一点。反派主角调教别人和她被调教都会有吧（笑
甚至比较过激，因此不打算写任何的百合感情线，以单女主h文的情况来写。

唯一的问题就是可能我本人的道德水平比较高，写不出那种反派主角的心理活动（
所以也不清楚自己能不能写好（不过我本人也确实比较阴暗就是，虽然模拟不出原主的那种阴暗度（（
（所以我也不清楚要不要写，如果大家喜欢的话会开坑？）
（再加上如果写这个的话还可以名正言顺地看到诺霖和诺汐的败北剧情也挺不错的（（

`);
</script>

<style scoped>
  .word_content{
    display: flex;
    width:80%;
    height: auto;
    font-size: 18px;
    line-height: 1.8;
    font-weight: 500;
    justify-content: center;
    align-self: center;
    margin-top:20px;
  }
</style>
<template>
  <div class="ranking">
    <h5 style="margin-bottom:0px;">每日排行榜</h5>
    <h3 style="margin-top:5px;">{{ dateStr }}的排行榜</h3>
    <div class="ranking_work_list">
      <div class="work_item" v-for="index in 5" :key="index">
        <div class="cover">
          <div class="rank_svg">
            1
          </div>
          <img :src="cover_path">
        </div>
        <div class="work_info">
          <div class="work_title">
            <span>{{work_title}}</span>
          </div>
          <div class="work_chapter">
            <span>{{work_chapter}}</span>
          </div>
          <div class="user_info">
            <div class="user_avatar">
              <img :src="user_avatar">
            </div>
            <div class="username">
              <span>{{username}}</span>
            </div>
          </div>
          <div class="work_tags">
            <span v-for="(tag,index) in work_tags" :key="index" style="margin-right: 5px;">#{{tag}}</span>
          </div>
          <div class="brief_introduction">
            <span>{{brief_introduction}}</span>
          </div>
          <div class="read_data">
            <span>{{read_data.word}}字</span>
            <span>{{read_data.read_time}}分钟</span>
            <span>{{read_data.read_num}}次</span>
          </div>
        </div>
      </div>
      
    </div>
    <div class="left_btn" @click="scrollTabs(-600)">1</div>
      <div class="right_btn" @click="scrollTabs(600)">1</div>
  </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted } from 'vue';
export default {
  // eslint-disable-next-line vue/multi-word-component-names
  name: 'ranking',
}
</script>

<script setup>
let date = new Date();
let year = date.getFullYear();
let month = date.getMonth() + 1;
let day = date.getDate();
let dateStr = year + '-' + month + '-' + day;

let cover_path=ref('https://www.sunyuanling.com/image/118839253_p1.jpg');
let rank=ref(1);
let work_title=ref('作品标题');
let work_chapter=ref('章节标题');
let user_avatar=ref('https://www.sunyuanling.com/image/116883317_p0.png');
let username=ref('用户名');
let work_tags=ref(['标签1','标签2','标签3','标签1','标签2','标签3','标签1','标签2','标签3']);
let brief_introduction=ref('作品简介');
let read_data=ref({
  word:1000,
  read_time:10,
  read_num:1000
});

//滚动函数
function scrollTabs(scrollAmount) {
  const tags = document.querySelector('.ranking_work_list');
  const animationDuration = 0.2 * 1000; // 0.5秒转为毫秒
  const fps = 24; // 帧率
  const frameDuration = animationDuration / fps; // 每帧持续时间
  const framesCount = Math.ceil(animationDuration / frameDuration); // 总帧数
  let count = 0;

  function animateScroll() {
    if (count < framesCount) {
      tags.scrollLeft += scrollAmount / framesCount;
      count++;
      requestAnimationFrame(animateScroll);
    }
  }

  animateScroll();
}
</script>

<style scoped>
.ranking {
  display: flex;
  width: 100%;
  height: auto;
  flex-direction: column;
  margin-top: 20px;
  position: relative;
}

.ranking_work_list {
  display: flex;
  width: 100%;
  height: auto;
  min-height: 350px;
  margin-top: 10px;
  overflow-x: auto;
  scrollbar-width: none;
  white-space: nowrap;
  position: relative;
}

.work_item {
  display: flex;
  width: calc(100%/2);
  min-width: 450px;
  height: auto;
  min-height: 350px;
  position: relative;
  border-radius: 15px;
  overflow: hidden;
  margin-right: 40px;
}

.cover {
  display: flex;
  width: 30%;
  height: 100%;
  position: relative;
  border-radius: 15px;
  overflow: hidden;
}

.cover img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.rank_svg {
  position: absolute;
  left: 5px;
  top: 5px;
  width: 40px;
  height: 40px;
  display: flex;
  border-radius: 50%;
  justify-content: center;
  align-items: center;
  background-color: rgba(236, 87, 41, 1);
}

.work_info {
  display: flex;
  width: 70%;
  height: 100%;
  flex-direction: column;
  padding: 10px;
  flex-grow: 1;
  justify-content: space-around;

}

.work_title {
  display: flex;
  width: 100%;
  height: auto;
  font-size: 20px;
  font-weight: bold;
  color: rgba(123, 123, 123, 1);
}

.work_chapter {
  width: 100%;
  height: auto;
  font-size: 18px;
  font-weight: bold;
}
.work_tags{
  font-size: 16px;
  font-weight: bold;
  color:rgba(0,150,250,1);
  white-space: break-spaces;
}

.user_info {
  display: flex;
  width: 100%;
  height: auto;
}

.user_avatar {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  overflow: hidden;
}

.user_avatar img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.username {
  margin-left: 10px;
}
.read_data{
  display: flex;
  justify-content: space-between;
}
.left_btn{
  position: absolute;
  width: 50px;
  height: 350px;
  left:0px;
  display: flex;
  justify-content: center;
  align-items: center;
  background:linear-gradient(to right,rgba(255,255,255,1),rgba(255,255,255,0));
  top:98px;
  opacity: 0;
  z-index: 2;
}
.left_btn:hover,.right_btn:hover{
  cursor: pointer;
  opacity: 1;
  transition:all 0.3s ease-in-out;
  z-index: 2;
}
.right_btn{
  position: absolute;
  width:50px;
  height: 350px;
  right: 0px;
  display: flex;
  justify-content: center;
  align-items: center;
  background:linear-gradient(to left,rgba(255,255,255,1),rgba(255,255,255,0));
  top:98px;
  opacity: 0;
  z-index: 2;
}
</style>
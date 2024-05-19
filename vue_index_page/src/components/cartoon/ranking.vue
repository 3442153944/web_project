<template>
  <div class="ranking">
    <h3>每日排行榜</h3>
    <div class="work_list_carton_page">
      <div class="work_item" v-for="index in 10" :key="index">
        <div class="work_img">
          <div class="rank">{{rank}}</div>
          <div class="count_page">
            <svg t="1715784414381" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg"
              p-id="9622" width="200" height="200">
              <path
                d="M819.2 128H409.6c-56.32 0-102.4 46.08-102.4 102.4v409.6c0 56.32 46.08 102.4 102.4 102.4h409.6c56.32 0 102.4-46.08 102.4-102.4V230.4c0-56.32-46.08-102.4-102.4-102.4z m51.2 512c0 28.16-23.04 51.2-51.2 51.2H409.6c-28.16 0-51.2-23.04-51.2-51.2V230.4c0-28.16 23.04-51.2 51.2-51.2h409.6c28.16 0 51.2 23.04 51.2 51.2v409.6z m-204.8 204.8c0 28.16-23.04 51.2-51.2 51.2H204.8c-28.16 0-51.2-23.04-51.2-51.2V435.2c0-28.16 23.04-51.2 51.2-51.2h51.2v-51.2H204.8c-56.32 0-102.4 46.08-102.4 102.4v409.6c0 56.32 46.08 102.4 102.4 102.4h409.6c56.32 0 102.4-46.08 102.4-102.4v-51.2h-51.2v51.2z"
                fill="#ccd6de" p-id="9623"></path>
            </svg>
            {{count_page}}</div>
          <img :src="img_path">
        </div>
        <div class="work_title">
          <span>{{title}}</span>
        </div>
        <div class="user_info">
          <div class="user_avatar">
            <img :src="user_avatar">
          </div>
          <div class="username">
            <span>{{username}}</span>
          </div>
        </div>
      </div>
      <div class="left_btn" @click="scrollTabs(-400)"><svg t="1715776937217" class="icon" viewBox="0 0 1024 1024"
        version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="4252" width="200" height="200">
        <path
          d="M510.86222222 1020.58666667c281.71377778 0 510.86222222-229.14844445 510.86222223-510.86222222S792.576-1.13777778 510.86222222-1.13777778 0 228.01066667 0 509.72444445s229.14844445 510.86222222 510.86222222 510.86222222z m0-950.72711112c242.57422222 0 439.86488889 197.29066667 439.86488889 439.8648889S753.43644445 949.58933333 510.86222222 949.58933333c-242.57422222 0-439.86488889-197.29066667-439.86488889-439.86488888S268.288 69.85955555 510.86222222 69.85955555zM307.65511111 532.48c-13.88088889-13.88088889-13.88088889-36.29511111 0-50.176l260.89244444-260.89244445c13.88088889-13.88088889 36.29511111-13.88088889 50.176 0 13.88088889 13.88088889 13.88088889 36.29511111 0 50.176L382.976 507.33511111l235.86133333 235.86133334c13.88088889 13.88088889 13.88088889 36.29511111 0 50.176-6.94044445 6.94044445-16.04266667 10.35377778-25.03111111 10.35377777-9.10222222 0-18.20444445-3.41333333-25.03111111-10.35377777L307.65511111 532.48z"
          fill="#333303" p-id="4253"></path>
      </svg></div>
      <div class="right_btn" @click="scrollTabs(400)"><svg t="1715776983773" class="icon" viewBox="0 0 1024 1024"
        version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="6057" width="200" height="200">
        <path
          d="M896 512a384 384 0 1 0-384 384 384 384 0 0 0 384-384z m64 0A448 448 0 1 1 512 64a448 448 0 0 1 448 448z"
          p-id="6058"></path>
        <path
          d="M425.28 310.72a32 32 0 0 1 45.44-45.44l224 224a32 32 0 0 1 0 45.44l-224 224a32 32 0 0 1-45.44-45.44L626.88 512z"
          p-id="6059"></path>
      </svg></div>
    </div>
  </div>
</template>

<script>
import { ref, reactive, toRefs, watch, onMounted, onUnmounted } from 'vue';
export default {
  name: 'ranking',
}
</script>

<script setup>
let img_path=ref('https://127.0.0.1:443/image/100213135_p0.jpg');
let rank=ref(1);
let count_page=ref(12);
let title=ref('作品标题');
let user_avatar=ref('https://127.0.0.1:443/image/118839253_p1.jpg');
let username=ref('用户名');

//滚动函数
function scrollTabs(scrollAmount) {
  const tags = document.querySelector('.work_list_carton_page');
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
      height: 100%;
      display: flex;
      flex-direction: column;
      margin: 0 auto;
      width: 100%;
      margin-top:20px;
    }
    .work_list_carton_page {
      display: flex;
      overflow-x:auto ;
      scrollbar-width: none;
      width: 100%;
      height: auto;
      padding:5px;
      margin-top: 10px;
    }
    .work_item{
      display: flex;
      flex-direction: column;
      width: auto;
      max-width: calc(100%*0.3);
      height: auto;
      min-height: 320px;
      min-width: 260px;
      margin-right: 10px;
      white-space: nowrap;
      position: relative;
    }
    .work_img{
      display: flex;
      justify-content: center;
      align-items: center;
      height: 80%;
      width: 100%;
      position: relative;
      overflow: hidden;
      border-radius: 15px;
    }
    .work_img img{
      width:100%;
      height:100%;
      object-fit: cover;
      border-radius: 15px;
    }
    .rank{
      position: absolute;
      top:5px;
      left: 5px;
      width:40px;
      height: 40px;
      border-radius: 50%;
      overflow: hidden;
      background-color: rgba(248, 138, 87,1);
      font-size: 18px;
      color:#fff;
      text-align: center;
      font-weight: bold;
      display: flex;
      justify-content: center;
      align-items: center;
    }
    .count_page{
      position: absolute;
      top:5px;
      right: 5px;
      width:50px;
      height: 20px;
      border-radius: 10px;
      background-color: rgba(83,83,83,0.8);
      display: flex;
      justify-content: center;
      align-items: center;
      color:#fff;
      font-size: 12px;
      font-weight: bold;
    }
    .count_page svg{
      width:20px;
      height: 20px;
      object-fit: cover;
      margin-right: 5px;
      fill:#fff;
    }
    .work_title{
      display: flex;
      margin-top:10px;
    }
    .user_info{
      display: flex;
      align-items: center;
      margin-top: 10px;
      flex-grow: 1;
    }
    .user_avatar{
      width:40px;
      height: 40px;
      border-radius: 50%;
      overflow: hidden;
      margin-right: 5px;
    }
    .user_avatar img{
      width:100%;
      height:100%;
      object-fit: cover;
      border-radius: 50%;
    }
    .username{
      display: flex;
      justify-content: center;
      align-items: center;
    }
    .left_btn{
      position: absolute;
      left: 0px;
      width:50px;
      height: 100%;
      background:linear-gradient(to right,rgba(255,255,255,1),rgba(255,255,255,0));
      display: flex;
      align-items: center;
      justify-content: center;
      max-height: 260px;
      opacity: 0;
    }
    .left_btn:hover{
      opacity: 1;
      cursor: pointer;
      transition:all 0.3s ease;
    }
    .right_btn{
      position: absolute;
      right: -10px;
      width:50px;
      height: 100%;
      background:linear-gradient(to left,rgba(255,255,255,1),rgba(255,255,255,0));
      display: flex;
      align-items: center;
      justify-content: flex-end;
      max-height: 260px;
      opacity: 0;
    }
    .right_btn:hover{
      opacity: 1;
      cursor: pointer;
      transition:all 0.3s ease;
    }
    .left_btn svg,
    .right_btn svg{
      width:40px;
      height: 40px;
      object-fit: cover;
    }
</style>
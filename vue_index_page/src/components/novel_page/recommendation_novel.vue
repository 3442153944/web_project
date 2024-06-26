<template>
  <div class="recommendation_novel">
    <h3>编辑推荐作品</h3>
    <div class="recommendation_novel_list">
        <div class="novel_item" v-for="index in 10" :key="index">
            <div class="novel_cover">
                <div class="novel_img">
                    <img :src="img_path">
                </div>
                <div class="novel_info">
                    <div class="info_title">
                        <span style="color:rgba(133,133,133,1);">{{novel_info.state}}</span>
                    </div>
                    <span>{{novel_info.title}}</span>
                    <div class="user_info">
                        <div class="user_avatar">
                            <img :src="novel_info.useravatar">
                        </div>
                        <div class="username">
                            <span>{{novel_info.username}}</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="edit_msg">
                <div class="edit_title">
                    <span style="color:rgba(133,133,133,1);margin-bottom:10px;" >小编寄语</span>
                </div>
                <div class="edit_content">
                    <span>{{edit_msg}}</span>
                </div>
            </div>
        </div>
        <div class="left_btn" @click="scrollTabs(-400)">1</div>
        <div class="right_btn" @click="scrollTabs(400)">1</div>
    </div>
  </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted } from 'vue';
export default {
  name: 'recommendation_novel',
}
</script>

<script setup>
let img_path=ref('https://www.sunyuanling.com/image/65014220_p0.jpg');
let novel_info=ref({
    state:'单篇完结作品',
    title:'作品标题',
    useravatar:'https://www.sunyuanling.com/image/100213135_p1.jpg',
    username:'用户名',
})
let edit_msg=ref('编辑寄语，说的啥，不知道随便')

//滚动函数
function scrollTabs(scrollAmount) {
  const tags = document.querySelector('.recommendation_novel_list');
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
  
.recommendation_novel{
    display: flex;
    flex-direction: column;
    margin-top: 20px;
    width: 100%;
    height: auto;
    position: relative;
}
.recommendation_novel_list{
    display: flex;
    width:100%;
    height: auto;
    margin-top: 5px;
    scrollbar-width: none;
    overflow-x:hidden ;
    white-space: nowrap;
}
.novel_item{
    display: flex;
    flex-direction: column;
    width:calc(100%/3);
    margin-right: 20px;
    position: relative;
    height: auto;
    min-height: 300px;
    border-radius: 15px;
    min-width: 450px;
}
.novel_cover{
    display: flex;
    width: 100%;
    height: 60%;
    background-color: rgba(244,244,244,1);
    border-radius: 15px;
    overflow: hidden;
}
.novel_img{
    width: 30%;
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    border-radius: 15px;
    overflow: hidden;
}
.novel_img img{
    width: 100%;
    height: 100%;
    object-fit: cover;
}
.edit_msg{
    display: flex;
    flex-direction: column;
    flex-grow: 1;
    justify-content: flex-start;
    margin-top: 20px;
}
.novel_info{
    display: flex;
    flex-direction:column;
    justify-content: space-around;
    height: 100%;
    flex-grow: 1;
    padding: 5px;
}
.user_info{
    display: flex;
    width:100%;
    height: 40px;
    align-items: center;
}
.user_avatar{
    width: 40px;
    height: 40px;
    border-radius: 50%;
    overflow: hidden;
    margin-right: 10px;
}
.user_avatar img{
    width: 100%;
    height: 100%;
    object-fit: cover;
}
.edit_content{
    display: flex;
    margin-top:10px;
}
.left_btn{
    position: absolute;
    left: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    width:50px;
    height: 300px;
    background: linear-gradient(to right, rgba(255,255,255,1),rgba(255,255,255,0));
    opacity: 0;
}
.left_btn:hover{
    opacity: 1;
    cursor: pointer;
    transition:all 0.3s ease-in-out;
}
.left_btn svg,.right_btn svg{
    width:40px;
    height: 40px;
    object-fit: cover;
}
.right_btn{
    position: absolute;
    right: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    width:50px;
    height: 300px;
    background: linear-gradient(to right, rgba(255,255,255,0),rgba(255,255,255,1));
    opacity: 0;
}
.right_btn:hover{
    opacity: 1;
    cursor: pointer;
    transition:all 0.3s ease-in-out;
}
</style>
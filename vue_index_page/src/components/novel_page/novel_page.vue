<template>
  <div class="novel_page">
    <h3>已关注用户作品</h3>
    <div class="novel_list">
      <div class="novel_item" v-for="index in 4" :key="index">
        <div class="novel_cover">
          <img :src="cover_path">
        </div>
        <div class="novel_info">
          <div class="novel_state mt">
            <span>{{state}}</span>
          </div>
          <div class="novel_title  mt">
            <span>{{title}}</span>
          </div>
          <div class="novel_userinfo  mt">
            <div class="novel_useravatar">
              <img :src="user_avatar">
            </div>
            <div class="novel_username">
              <span>{{user_name}}</span>
            </div>
          </div>
          <div class="novel_tags  mt">
            <span style="margin-right: 5px" class="age_tag">{{age_tag}}</span>
            <span class="tags" v-for="(tags,index) in tags" :key="index">#{{tags}}</span>
          </div>
          <div class="novel_read_data  mt">
            <div class="word_count">
              <span>{{word_count}}字</span>
            </div>
            <div class="read_time">
              <span>{{read_time}}分钟</span>
            </div>
            <div class="like_count">
              <span>{{like_count}}人喜欢</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted } from 'vue';
export default {
  name: 'novel_page',
}
</script>

<script setup>
let cover_path=ref('https://127.0.0.1:4434/image/116883317_p0.png')
let state=ref('单篇完结作品');
let title=ref('小说作品');
let tags=ref(['标签1','标签2','标签3','标签4','标签5','标签6','标签7','标签8']);
let age_tag=ref('R-18');
let user_avatar=ref('https://127.0.0.1:4434/image/103168176_p0.png');
let user_name=ref('用户名');
let word_count=ref('1111');
let read_time=ref('12');
let like_count=ref('45');
</script>

<style scoped>
.mt{
  margin-top: 5px;
}
  .novel_page {
  display: flex;
  flex-direction: column;
  width: 80%;
  height: auto;
  margin:0 auto;
  margin-top: 20px;
  }
  .novel_list{
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
    margin-top: 20px;
    width: 100%;
    height: auto;
  }
 .novel_item{
    display: flex;
    width:45%;
    height: auto;
    min-width: 350px;
    min-height: 230px;
    margin-top: 20px;
 }
 .novel_cover{
  display: flex;
  width:30%;
  height: 100%;
  border-radius: 15px;
  overflow: hidden;
  justify-content: center;
  align-items: center;
 }
 .novel_cover img{
  width: 100%;
  height: 100%;
  object-fit: cover;
 }
 .novel_info{
  display: flex;
  flex-direction: column;
  width: 70%;
  height: 100%;
  padding: 5px;
  justify-content: space-around;
 }
 .novel_userinfo{
  display: flex;
  width: 100%;
  height: 35px;
  align-items: center;
 }
 .novel_useravatar{
  display: flex;
  width:35px;
  height: 35px;
  border-radius: 50%;
  overflow: hidden;
  margin-right: 10px;
 }
 .novel_useravatar img{
  width: 100%;
  height: 100%;
  object-fit: cover;
}
.novel_read_data{
  display: flex;
  justify-content: space-between;
}
.novel_title{
  font-size: 18px;
  font-weight: bold;
}
.age_tag{
  font-size: 18px;
  color: red;
  font-weight: bold;
}
.tags{
  cursor: pointer;
  font-size: 16px;
  color: rgba(0, 174, 255,1);
  margin-left:8px;
  margin-top: 5px;
}
</style>
<template>
  <div class="illustration_page">
    <h3>用户关注的作品</h3>
    <div class="follow_list" v-if="follow_illustrations_list">
      <div class="follow_work" v-for="(item, index) in follow_illustrations_list" :key="index">
        <div class="follow_work_item">
          <div class="age_tag" v-if="item.age_classification >= 18">
            <span>R-{{ item.age_classification }}</span>
          </div>
          <div class="page_count" v-if="item.content_file_list.split(/[,，]/).length > 1">
            <img :src="page_count_svg_path">
            <span>{{ item.content_file_list.split(/[,，]/).length }}</span>
          </div>
          <div class="like">
            <img :src="temp_svg" ref="like" @click="switch_love_status(index)">
          </div>
          <img :src="'https://www.sunyuanling.com/image/thumbnail/' + item.content_file_list.split(/[,，]/)[0]"
            @click="go_to_illustration_page(item.Illustration_id)">
        </div>
        <div class="work_name">
          <span>{{ item.name }}</span>
        </div>
        <div class="userinfo">
          <div class="user_avatar">
            <img :src="'https://www.sunyuanling.com/image/avatar_thumbnail/' + item.belong_to_user_avatar">
          </div>
          <div class="username">
            <span>{{ item.belong_to_user }}</span>
          </div>
        </div>
      </div>
      <div class="left_btn" @click="scrollTabs(-400)">
        <img :src="left_svg_path">
      </div>
      <div class="right_btn" @click="scrollTabs(400)">
        <img :src="right_svg_path">
      </div>
    </div>
    <recommendation></recommendation>
    <ranking></ranking>
  </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted } from 'vue';
import recommendation from './recommendation.vue';
import ranking from './ranking.vue';
import * as cookies from '../../../../model/cookies.js'
export default {
  name: 'illustration_page',
  components: { recommendation, ranking },
}
</script>

<script setup>
import { useStore } from 'vuex';
const store = useStore()
let work_id=ref('')
//喜欢状态
let love_svg_path = ref('https://www.sunyuanling.com/assets/love.svg')

let no_love_svg_path = ref('https://www.sunyuanling.com/assets/no_love.svg')
let left_svg_path = ref('https://www.sunyuanling.com/assets/left.svg')
let right_svg_path = ref('https://www.sunyuanling.com/assets/right.svg')
let page_count_svg_path = ref('https://www.sunyuanling.com/assets/page_count.svg')
let love_svg = ref(null)
let user_info = ref(JSON.parse(cookies.get_cookie('userinfo')))
let temp_svg = ref('https://www.sunyuanling.com/assets/love.svg')
let like = ref(null)
//切换喜欢状态
function switch_love_status(index) {
  if (like.value[index].src == love_svg_path.value) {
    like.value[index].src = no_love_svg_path.value
  }
  else {
    like.value[index].src = love_svg_path.value
  }
}

//获取用户关注用户的插画作品列表
let follow_illustrations_list = ref([])
async function get_follow_illustrations_list() {
  try {
    const res = await fetch('https://www.sunyuanling.com/api/GetUserInfo/GetUserFollowToIll/', {
      method: 'post',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        userid: user_info.value.userid,
      })
    })
    const data = await res.json()
    if (data.status == 'success') {
      console.log(data.data)
      follow_illustrations_list.value = data.data;
      for (let i = 0; i < follow_illustrations_list.value.length; i++) {
        follow_illustrations_list.value[i].belong_to_user_avatar = await get_author_avatar(follow_illustrations_list.value[i].belong_to_user_id)
      }
      console.log(follow_illustrations_list.value)
      return data.data;
    }
    else {
      console.log(data.message)
    }
  }
  catch (error) {
    console.log(error)
  }
}
//根据ID获取用户作者头像
async function get_author_avatar(userid) {
  try {
    const res = await fetch('https://www.sunyuanling.com/api/GetUserInfo/GetAllUserInfo/', {
      method: 'post',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        userid: userid,
        token: null,
      })
    })
    if (res.ok) {
      const data = await res.json()
      if (data.status == 'success') {
        return data.data[0].user_avatar;
      }
    }
    else {
      console.log(res.status)
    }
  }
  catch (error) {
    console.log(error)
  }
}
onMounted(() => {
  get_follow_illustrations_list()

})

//插画作品的带参跳转
function go_to_illustration_page(id) {
  store.commit('SET_CONTENT_PAGE', {
    key: 'ill_page',
    value: true
  })
  store.commit('SET_SINGLE_PAGE_STATUS',{key:'all',value:false})
  store.commit('SET_WORK_ID',id)
}

//模拟横向滚动效果
function scrollTabs(scrollAmount) {
  const tags = document.querySelector('.follow_list');
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
.illustration_page {
  width: 80%;
  height: auto;
  min-height: 400px;
  margin: 20px auto;
  display: flex;
  flex-direction: column;
  position: relative;
}

.follow_list {
  display: flex;
  width: 100%;
  height: 250px;
  margin-top: 10px;
  overflow-x: auto;
  scrollbar-width: none;
  white-space: nowrap;
}

.follow_work {
  display: flex;
  flex-direction: column;
  width: 150px;
  min-width: 150px;
  height: 100%;
  margin-right: 20px;
  margin-left: 10px;
  position: relative;
}

.left_btn {
  display: flex;
  position: absolute;
  left: 0px;
  height: 230px;
  width: 60px;
  opacity: 0;
  align-items: center;
}

.left_btn svg,
.right_btn svg {
  width: 40px;
  height: 40px;
  object-fit: cover;
}

.left_btn img,
.right_btn img {
  width: 40px;
  height: 40px;
  object-fit: cover;
}

.left_btn:hover {
  opacity: 1;
  cursor: pointer;
  transition: all 0.3s ease;
  /*从左到右白色到透明渐变*/
  background: linear-gradient(to right, rgba(255, 255, 255, 1), rgba(255, 255, 255, 0));
}

.right_btn {
  display: flex;
  position: absolute;
  right: 0px;
  height: 230px;
  width: 60px;
  opacity: 0;
  align-items: center;
}

.right_btn svg {
  position: absolute;
  right: 0px;
}

.right_btn:hover {
  opacity: 1;
  cursor: pointer;
  transition: all 0.3s ease;
  background: linear-gradient(to right, rgba(255, 255, 255, 0), rgba(255, 255, 255, 1));
}

.follow_work_item {
  display: flex;
  position: relative;
  overflow: hidden;
  width: 100%;
  height: 80%;
  border-radius: 10px;
  cursor: pointer;
}

.follow_work_item img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.age_tag {
  display: flex;
  position: absolute;
  left: 5px;
  top: 5px;
  font-size: 12px;
  color: white;
  background-color: red;
  border-radius: 5px;
  padding: 2px;
  font-weight: bold;
  z-index: 2;
}

.page_count {
  display: flex;
  position: absolute;
  right: 5px;
  top: 5px;
  min-height: 25px;
  min-width: 35px;
  font-size: 14px;
  font-weight: bold;
  color: white;
  background-color: rgba(129, 128, 128, 0.8);
  border-radius: 5px;
  padding: 2px;
  align-items: center;
  z-index: 2;
}

.page_count svg {
  width: 16px;
  height: 16px;
  margin-right: 2px;
  object-fit: cover;
  fill: rgba(244, 244, 244, 1)
}

.page_count img {
  width: 25px;
  height: 25px;
  margin-right: 2px;
  object-fit: cover;
}

.like {
  display: flex;
  position: absolute;
  right: 5px;
  bottom: 5px;
  z-index: 2;
}

.like svg {
  width: 30px;
  height: 30px;
  object-fit: cover;
}

.like img {
  width: 30px;
  height: 30px;
  object-fit: cover;
}

.userinfo {
  display: flex;
  width: 100%;
  flex-flow: 1;
  align-items: center;
}

.work_name {
  width: 100%;
  margin-top: 5px;
}

.user_avatar {
  width: 30px;
  height: 30px;
  border-radius: 50%;
  overflow: hidden;
  margin-right: 5px;
  margin-top: 5px;
}

.user_avatar img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}
</style>
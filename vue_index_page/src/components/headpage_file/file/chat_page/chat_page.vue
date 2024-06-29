<template>
  <div class="chat_page">
    <div class="title">
      <div class="back_index_page" @click="close_page_click()">
        <img class="icon" src="https://www.sunyuanling.com/assets/left.svg">
      </div>
      <div class="close_btn" @click="close_page_click">
        <img class="icon" src="https://www.sunyuanling.com/assets/close.svg">
      </div>
    </div>
    <div class="item">
      <div class="chat_list">
        <div class="list_title">
          <div class="title_item" ref="friend_title" @click="switch_list">
            <span>好友</span>
          </div>
          <div class="title_item" ref="group_title" @click="switch_list">
            <span>群聊</span>
          </div>
        </div>
        <div class="list_content">
          <span>{{little_title}}</span>
          <div class="list_content_item" v-for="(item,index) in user_friend_list" :key="index">
            <span v-if="!item.notes">{{item.friendname}}</span>
            <span v-if="item.notes">{{item.notes}}</span>
          </div>
        </div>
      </div>
      <div class="chat_content">
      </div>
    </div>
  </div>
</template>

<script>
import { ref, reactive, toRefs, watch, onMounted, onUnmounted, defineEmits } from 'vue';
import * as cookies from '../../../../../../model/cookies.js'
import { couldStartTrivia } from 'typescript';
export default {
  name: 'chat_page',
}
</script>

<script setup>
let close_page = defineEmits(['close_page']);
//向父组件传递关闭消息
function close_page_click() {
  close_page('close_page', false)
}
let userinfo = ref(JSON.parse(cookies.get_cookie('userinfo')))
console.log(userinfo.value)
let user_friend_list = ref([])
let little_title=ref('好友列表');
let friend_title=ref(null);
let group_title=ref(null);

//切换列表
function switch_list(e) {
  if (e.target.innerText == '好友') {
    friend_title.value.style.borderBottom = '2px solid #000000'
    group_title.value.style.borderBottom = 'none'
    little_title.value = '好友列表'
  }
  else {
    group_title.value.style.borderBottom = '2px solid #000000'
    friend_title.value.style.borderBottom = 'none'
    little_title.value = '群聊列表'
  }
}

//切换列表
watch(little_title, (newValue, oldValue) => {
  console.log(newValue)
})
//请求好友列表
async function get_user_friend_list() {
  try {
    const res = await fetch('https://www.sunyuanling.com/api/GetUserInfo/GetFriendList/', {
      method: 'post',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        userid: userinfo.value.userid
      })
    })
    if (res.ok) {
      const data = await res.json()
      if (data.status == 'success') {
        user_friend_list.value = data.data
        console.log(user_friend_list.value)
      }
      else {
        console.log(data.message)
      }
    }
    else {
      console.log(res.status)
    }
  }
  catch (e) {
    console.log(e)
  }
}
onMounted(() => {
  get_user_friend_list()
  //加载时初始化为好友列表
  friend_title.value.style.borderBottom = '2px solid #000000'
  group_title.value.style.borderBottom = 'none'
})

</script>

<style scoped>
.chat_page {
  display: flex;
  flex-direction: column;
  width: 100%;
  height: 100%;
  padding: 10px;
}

.title {
  display: flex;
  width: 95%;
  height: 50px;
  justify-content: space-between;
  margin: 5px 10px;
}

.back_index_page,
.close_btn {
  display: flex;
  width: 35px;
  height: 35px;
  align-items: center;
  justify-content: center;
}

.back_index_page:hover,
.close_btn:hover {
  border-radius: 50%;
  background-color: rgba(0, 0, 0, 0.1);
  cursor: pointer;
  transition: all 0.3s ease-in-out;
}
.item{
  display: flex;
  width: 90%;
  height: 80%;
  margin: 5px auto;
  background-color: rgba(233,233,233,1);
  border-radius: 10px;
  border:1px solid rgba(0,0,0,0.5);
  overflow: hidden;
  overflow-y:auto ;
  overflow-x:hidden;
  box-shadow: 6px -5px 10px 0px rgba(0, 0, 0, 0.5);
  padding: 5px;
}
.chat_list{
  display: flex;
  flex-direction: column;
  width: 20%;
  height: 100%;
  background-color:rgba(244,244,244,1);
  overflow-y:auto ;
  overflow-x:hidden;
  border-right:1px solid rgba(0,0,0,0.5);
}
.list_title{
  display: flex;
  width: 100%;
  height: auto;
  padding-top:10px ;
  padding-bottom:10px ;
}
.title_item{
  display: flex;
  flex:1;
  justify-content: center;
  align-items: center;
  font-size: 20px;
  font-weight: bold;
  border-bottom:1px solid rgba(0,0,0,0.5);
  cursor: pointer;

}

.icon {
  width: 25px;
  height: 25px;
  object-fit: cover;
}
</style>
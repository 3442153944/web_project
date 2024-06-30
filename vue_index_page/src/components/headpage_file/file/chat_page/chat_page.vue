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
          <span class="little_title">{{ little_title }}</span>
          <div class="friend_list" v-if="friend_list_show">
            <div class="list_content_item" v-for="(item, index) in user_friend_list" :key="index"
              @click="select_friend_or_group('friend', item)">
              <div class="user_avatar">
                <img class="avatar" v-lazy="item.avatarUrl">
              </div>
              <span v-if="!item.notes">{{ item.friendname }}</span>
              <span v-if="item.notes">{{ item.notes }}</span>
            </div>
          </div>
          <div class="group_list" v-if="group_list_show">
            群列表
          </div>
        </div>
      </div>
      <div class="chat_content">
        <div class="chat_content_head" v-if="chat_content_info.friendname!=''&&chat_content_info.friendname!=null&&chat_content_info.friendname!=undefined">
          <div class="friend_avatar"
            style="margin-left: 10px;margin-right: 10px;width:60px;height:60px;border-radius: 50%;">
            <img class="avatar" :src="chatpage_friend_avatar"
              style="width: 50px;height: 50px;object-fit: cover;border-radius: 50%;">
          </div>
          <span>{{ chat_content_info.friendname }}</span>
        </div>
        <div class="message_list" ref="message_list"
         v-if="chat_content_info.friendname!=''&&chat_content_info.friendname!=null&&chat_content_info.friendname!=undefined">
          <div class="message_item" v-for="(item, index) in msg_list" :key="index"
            style="position: relative; display: flex; margin-bottom: 10px;">
            <div v-if="item.sender_id == userinfo.userid"
              style="margin-right: 10px; align-self: flex-end; display: flex; justify-content: flex-end; width: 100%;">
              <div class="receive_content"
                style="background-color: #e5e5ea; padding: 10px; border-radius: 10px; max-width: 70%; word-wrap: break-word;">
                <span style="word-break: break-all;">{{ item.content }}</span>
              </div>
              <div class="receive_avatar" style="margin-left: 10px;">
                <img class="avatar" :src="'https://www.sunyuanling.com/image/'+userinfo.user_avatar"
                  style="width: 50px; height: 50px; object-fit: cover; border-radius: 50%;">
              </div>
            </div>
            <div v-else style="margin-left: 10px; align-items: flex-end; display: flex; width: 100%;">
              <div class="send_avatar" style="margin-right: 10px;">
                <img class="avatar" :src="chatpage_friend_avatar"
                  style="width: 50px; height: 50px; object-fit: cover; border-radius: 50%;">
              </div>
              <div class="send_content"
                style="background-color: #007bff; color: white; padding: 10px; border-radius: 10px; max-width: 70%; word-wrap: break-word;">
                <span style="word-break: break-all;">{{ item.content }}</span>
              </div>
            </div>
          </div>

        </div>
        <div class="send_box">
          <div class="send_msg_box" ref="msg"> <textarea id="msg" placeholder="请输入消息" v-model="msg_content"></textarea>
          </div>
          <div class="send_btn" @click="send_msg()">发送</div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { ref, watch, onMounted, defineEmits } from 'vue';
import * as cookies from '../../../../../../model/cookies.js';

export default {
  name: 'chat_page',
}
</script>

<script setup>
let close_page = defineEmits(['close_page']);
// 向父组件传递关闭消息
function close_page_click() {
  close_page('close_page', false)
}

let userinfo = ref(JSON.parse(cookies.get_cookie('userinfo')));
let user_friend_list = ref([]);
let little_title = ref('好友列表');
let friend_title = ref(null);
let group_title = ref(null);
let chat_content_info = ref([])
let friend_list_show = ref(true);
let group_list_show = ref(false);
let chatpage_friend_avatar = ref();
let msg = ref(null);
let ws;
let msg_list = ref([{}]);
let message_list=ref(null);
let msg_content = ref(null);
// 切换列表
function switch_list(e) {
  if (e.target.innerText == '好友') {
    friend_title.value.style.borderBottom = '2px solid #000000';
    group_title.value.style.borderBottom = 'none';
    little_title.value = '好友列表';
    friend_list_show.value = true;
    group_list_show.value = false;
  } else {
    group_title.value.style.borderBottom = '2px solid #000000';
    friend_title.value.style.borderBottom = 'none';
    little_title.value = '群聊列表';
    group_list_show.value = true;
    friend_list_show.value = false;
  }
}

// 切换列表
watch(little_title, (newValue, oldValue) => {
  console.log(newValue);
});

// 请求好友列表
async function get_user_friend_list(id) {
  // Helper function to fetch and process friend list
  async function fetchFriendList(userId) {
    try {
      const res = await fetch('https://www.sunyuanling.com/api/GetUserInfo/GetFriendList/', {
        method: 'post',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          userid: userId
        })
      });

      if (res.ok) {
        const data = await res.json();
        if (data.status === 'success') {
          let friends = [];
          console.log(data.data);
          for (let i = 0; i < data.data.length; i++) {
            let item = data.data[i];
            console.log(`Fetching avatar for friend id: ${item.friendid}`);
            let avatarUrl = await get_user_info_by_id(item.type, item.friendid);
            console.log(`Fetched avatar URL: ${avatarUrl}`);
            friends.push({ ...item, avatarUrl: avatarUrl });
          }
          user_friend_list.value = friends;
        } else {
          console.log(data.message);
        }
      } else {
        console.log(res.status);
      }
    } catch (e) {
      console.log(e);
    }
  }

  // Determine which user ID to use and call fetchFriendList
  if (id == null || !id) {
    await fetchFriendList(userinfo.value.userid);
  } else {
    await fetchFriendList(id);
  }
}


// 通过ID请求用户信息
async function get_user_info_by_id(type, userid) {
  if (type === 'friend') {
    try {
      const res = await fetch('https://www.sunyuanling.com/api/GetUserInfo/GetAllUserInfo/', {
        method: 'post',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          userid: userid
        })
      });
      if (res.ok) {
        const data = await res.json();
        if (data.status === 'success') {
          chatpage_friend_avatar.value = 'https://www.sunyuanling.com/image/' + data.data[0].user_avatar;
          return 'https://www.sunyuanling.com/image/' + data.data[0].user_avatar;
        } else {
          console.log(data.message);
        }
      }
    } catch (e) {
      console.log(e);
    }
  } else if (type === 'group') {
    console.log('group');
  }
  return 'https://www.sunyuanling.com/assets/default_avatar.svg';
}

//选择好用或者群聊
async function select_friend_or_group(type, item) {
  console.log(type);
  if (type === 'friend') {
    chat_content_info.value = item;
    chat_content_info.value.type = 'friend';
    await get_user_info_by_id('friend', chat_content_info.value.friendid)
    create_websocket('one_to_one', userinfo.value.userid, chat_content_info.value.friendid)
    get_history_msg('friend', userinfo.value.userid, chat_content_info.value.friendid)
    //滚动到最新消息
    setTimeout(() => {
        message_list.value.scrollTop = message_list.value.scrollHeight;
      }, 100);
  } else if (type === 'group') {
    console.log(item);
    chat_content_info.value = item;
    chat_content_info.value.type = 'group';
    //滚动到最新消息
    setTimeout(() => {
      message_list.value.scrollTop = message_list.value.scrollHeight;
    }, 100);
  }
}
//创建websocket链接
function create_websocket(type, send_msg_user_id, to_user_id = null, content = '', to_group_id = null) {
  const wsUrl = `wss://127.0.0.1:2234/ws/chat/?userid=${send_msg_user_id}`;
  ws = new WebSocket(wsUrl);

  ws.onopen = () => {
    console.log('WebSocket 连接成功');
    // 如果需要，发送初始消息

  };

  ws.onmessage = (e) => {
    console.log('收到消息:', e.data);
    // 在这里处理收到的消息
    handle_incoming_message(e.data);
  };

  ws.onclose = () => {
    console.log('WebSocket 连接关闭');
  };

  ws.onerror = (error) => {
    console.log('WebSocket 连接错误:', error);
  };
}
async function handle_incoming_message(message) {
  let data = JSON.parse(message);
  // 在前端显示消息的逻辑
  if (chat_content_info.value.type == 'friend') { 
    await get_history_msg('friend', userinfo.value.userid, chat_content_info.value.friendid) 
  }
  else if (chat_content_info.value.type == 'group') { 
    await get_history_msg('group', userinfo.value.userid, chat_content_info.value.groupid)
   }
}
//获取历史消息
async function get_history_msg(type, userid, to_user_id = null, group_id = null) {
  if (type == 'friend') {
    try {
      const res = await fetch('https://www.sunyuanling.com/api/GetUserInfo/GetUserHistoryMsg/', {
        method: 'post',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          msg_type: 'friend',
          userid: userid,
          friend_id: to_user_id,
          group_id: group_id
        })
      })
      if (res.ok) {
        const data = await res.json();
        if (data.status == 'success') {
          msg_list.value = data.data;
        }
      }
      else {
        console.log(res.status);
      }
    }
    catch (e) {
      console.log(e);
    }
  }
  else if (type == 'group') {
    try {
      const res = await fetch('https://www.sunyuanling.com/api/GetUserInfo/GetUserHistoryMsg/', {
        method: 'post',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          msg_type: 'group',
          userid: userid,
          group_id: group_id,
          friend_id: to_user_id
        })
      })
      if (res.ok) {
        const data = await res.json();
        if (data.status == 'success') {
          console.log(data.data)
          msg_list.value = data.data;
        }
      }
      else {
        console.log(res.status);
      }
    }
    catch (e) {
      console.log(e);
    }
  }
}
//消息发送
async function send_msg() {
  try {
    let content = msg_content.value;  // 获取消息内容
    if (chat_content_info.value.type == 'friend') {
      // 构造一对一消息的JSON对象
      let msg_item = JSON.stringify({
        type: 'one_to_one',
        send_msg_user_id: userinfo.value.userid,
        to_user_id: chat_content_info.value.friendid,
        content: content,
        to_group_id: null,
      });
      ws.send(msg_item);  // 发送消息

      // 在消息列表中添加新消息
      msg_list.value.push({
        ID: 1,
        content: content,
        group_id: null,
        receive_id: chat_content_info.value.friendid,
        receiver_read_status: '已读',
        sender_id: userinfo.value.userid,
        time: new Date().toLocaleString(),
        type: 'one_to_one'
      });

      // 清空输入框
      msg_content.value = '';

      // 自动滑动到最底部
      setTimeout(() => {
        message_list.value.scrollTop = message_list.value.scrollHeight;
      }, 10);
    } else if (chat_content_info.value.type == 'group') {
      // 构造群组消息的JSON对象
      let msg_item = JSON.stringify({
        type: 'many_to_many',
        send_msg_user_id: userinfo.value.userid,
        to_user_id: null,
        content: content,
        to_group_id: chat_content_info.value.group_id
      });
      ws.send(msg_item);  // 发送消息

      // 在消息列表中添加新消息
      msg_list.value.push({
        ID: 1,
        content: content,
        group_id: chat_content_info.value.group_id,
        receive_id: null,
        receiver_read_status: '已读',
        sender_id: userinfo.value.userid,
        time: new Date().toLocaleString(),
        type: 'many_to_many'
      });

      // 清空输入框
      msg_content.value = '';

      // 自动滑动到最底部
      setTimeout(() => {
        message_list.value.scrollTop = message_list.value.scrollHeight;
      }, 10);
    }
  } catch (e) {
    console.log(e);
  }
}

onMounted(() => {
  get_user_friend_list();
  // 加载时初始化为好友列表
  friend_title.value.style.borderBottom = '2px solid #000000';
  group_title.value.style.borderBottom = 'none';
});
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

.item {
  display: flex;
  width: 90%;
  height: 80%;
  margin: 5px auto;
  background-color: rgba(233, 233, 233, 1);
  border-radius: 10px;
  border: 1px solid rgba(0, 0, 0, 0.5);
  overflow: hidden;
  overflow-y: auto;
  overflow-x: hidden;
  box-shadow: 6px -5px 10px 0px rgba(0, 0, 0, 0.5);
  padding: 5px;
}

.chat_list {
  display: flex;
  flex-direction: column;
  width: 20%;
  height: 100%;
  background-color: rgba(244, 244, 244, 1);
  overflow-y: auto;
  overflow-x: hidden;
  border-right: 1px solid rgba(0, 0, 0, 0.5);
  padding: 5px;
}

.list_title {
  display: flex;
  width: 100%;
  height: auto;
  padding-top: 10px;
  padding-bottom: 10px;
  align-items: center;
}

.title_item {
  display: flex;
  flex: 1;
  justify-content: center;
  align-items: center;
  font-size: 20px;
  font-weight: bold;
  border-bottom: 1px solid rgba(0, 0, 0, 0.5);
  cursor: pointer;
}

.little_title {
  display: flex;
  width: auto;
  flex: 1;
  padding: 5px;
  margin: 5px;
  height: auto;
  padding-top: 10px;
  padding-bottom: 10px;
  border-bottom: 1px solid black;
  background-color: rgba(133, 133, 133, 0.6);
  align-items: center;
}

.list_content_item {
  display: flex;
  width: auto;
  flex: 1;
  padding: 5px;
  margin: 5px;
  height: auto;
  border-bottom: 1px solid black;
  overflow: hidden;
  align-items: center;
}

.list_content_item:hover {
  background-color: rgba(133, 133, 133, 0.5);
  cursor: pointer;
  transition: all 0.3s ease-in-out;
}

.list_content {
  display: flex;
  flex-direction: column;
  width: 100%;
  height: auto;
  overflow: auto;
}

.user_avatar,
.friend_avatar {
  display: flex;
  width: 35px;
  height: 35px;
  border-radius: 50%;
  overflow: hidden;
  align-items: center;
  justify-content: center;
  margin-right: 10px;
}

.avatar {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.chat_content_head {
  display: flex;
  width: 100%;
  height: 80px;
  padding: 5px 0px;
  align-items: center;
  background-color: rgba(133, 133, 133, 0.5);
}

.chat_content {
  display: flex;
  width: 100%;
  height: auto;
  flex: 1;
  flex-direction: column;
  position: relative;
}

.message_list {
  display: flex;
  flex-direction: column;
  width: 98%;
  height: 70%;
  overflow: auto;
  padding: 5px;
  background-color: rgba(244, 244, 244, 1);
  margin: 5px;
}

.send_box {
  display: flex;
  width: 100%;
  height: 80px;
  padding: 5px;
  border-top: 1px solid black;
  background-color: #f5f5f5;
  align-items: center;
  /*保持在容器底部*/
  position: absolute;
  bottom: -5px;
  margin: 10px 0px auto;
  z-index: 10;
}

.icon {
  width: 25px;
  height: 25px;
  object-fit: cover;
}

.send_msg_box {
  display: flex;
  width: 80%;
  height: 100%;
}

.send_msg_box textarea {
  width: 100%;
  height: 80%;
  resize: none;
  border: none;
  outline: none;
  border-radius: 10px;
  padding: 10px;
  line-height: 1.4em;
  flex: 1;
}

.send_btn {
  width: 20%;
  height: 50%;
  min-height: 30px;
  min-width: 50px;
  max-width: 80px;
  max-height: 40px;
  background-color: rgba(0, 150, 250, 1);
  border-radius: 15px;
  align-items: center;
  justify-content: center;
  text-align: center;
  display: flex;
  margin: 5px auto;
}

.send_btn:hover {
  background-color: rgba(0, 150, 250, 0.8);
  cursor: pointer;
  transition: all 0.3s ease-in-out;
}
</style>
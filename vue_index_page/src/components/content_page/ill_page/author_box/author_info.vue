<template>
  <div class="author_info" v-if="props.author_id && author_info">
    <div class="content">
      <div class="author_info">
        <div class="author_avatar">
          <img :src="'https://www.sunyuanling.com/image/avatar_thumbnail/' + author_info.user_avatar">
        </div>
        <div class="author_name">
          <span>{{ author_info.username }}</span>
        </div>
      </div>
      <div class="author_follow">
        <div class="follow_btn" @click="follow_author">
          <span>{{ follow_status }}</span>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, defineProps, onMounted } from 'vue';
import * as cookies from "H:/web_project/model/cookies";

const token = cookies.get_cookie("token");
const props = defineProps({
  author_id: {
    type: String,
    default: '10086'
  }
});
const author_info = ref(null);
const follow_info = ref([]);
const follow_status = ref('关注');

// 通用请求函数
async function fetchData(url, data) {
  try {
    const res = await fetch(url, {
      method: 'post',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(data)
    });
    if (res.ok) {
      return await res.json();
    } else {
      console.error(`HTTP error: ${res.status}`);
      return { status: 'error', message: 'Request failed' };
    }
  } catch (e) {
    console.error(`Fetch error: ${e}`);
    return { status: 'error', message: 'Fetch error' };
  }
}

// 获取作者信息
async function get_author_info() {
  const data = await fetchData('https://www.sunyuanling.com/api/GetUserInfo/GetAllUserInfo/', {
    userid: props.author_id
  });
  if (data.status === 'success') {
    author_info.value = data.data[0];
  } else {
    console.error(data.message);
  }
}

// 获取关注信息
async function get_follow_info() {
  const data = await fetchData('https://www.sunyuanling.com/api/GetUserInfo/GetUserFollow/', {
    token: token
  });
  if (data.status === 'success') {
    follow_info.value = data.data;
    is_follow();
  } else {
    console.error(data.message);
  }
}

// 判断是否关注
function is_follow() {
  const isFollowing = follow_info.value.some(item => item.follow_user_id === props.author_id);
  follow_status.value = isFollowing ? '已关注' : '关注';
}

// 关注或取消关注
async function follow_author() {
  const data = await fetchData('https://www.sunyuanling.com/api/GetUserInfo/UserAddFollow/', {
    token: token,
    target_id: author_info.value.userid,
    target_username: author_info.value.username
  });
  if (data.status === 'success') {
    follow_status.value = follow_status.value === '已关注' ? '关注' : '已关注';
    alert(data.message);
  } else {
    alert(data.message);
  }
}

onMounted(async () => {
  await get_author_info();
  await get_follow_info();
});
</script>

<style scoped>
.author_info {
  display: flex;
  width: 100%;
  height: auto;
  flex-direction: column;
}

.content {
  display: flex;
  width: 100%;
  height: auto;
  flex-direction: column;
}

.author_info {
  width: 100%;
  height: 50px;
  padding: 5px 0px;
  display: flex;
  flex-direction: row;
  gap: 10px;
}

.author_avatar {
  width: 50px;
  height: 50px;
  border-radius: 50%;
  object-fit: cover;
  overflow: hidden;
}

.author_avatar img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  border-radius: 50%;
}

.author_name {
  width: auto;
  height: 50px;
  display: flex;
  align-items: center;
  font-size: 1em;
}
</style>
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
      <div class="author_follow" :class="follow_status === '已关注' ? 'off_follow' : 'on_follow'" @click="follow_author">
        <div class="follow_btn">
          <span>{{ follow_status }}</span>
        </div>
      </div>
      <div class="others_work">
        <div class="others_work_title">其他作品</div>
          <scroll_box :msg_list="author_other_work_list_path" @chose_item="get_choose_item"></scroll_box>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, defineProps, onMounted ,defineEmits} from 'vue';
import * as cookies from "@/assets/js/cookies.js";
import scroll_box from './model/scroll_box.vue';

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
let author_other_work_list=ref()
let author_other_work_list_path=ref([])
let work_id=ref()
let emit=defineEmits(['chose_item'])

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
//获取作者作品列表
async function get_author_work(){
  try{
    const data=await fetchData('https://www.sunyuanling.com/api/GetUserInfo/GetUserWorkList/',{
      userid:props.author_id,
    });
    if(data.status=='success')
    {
      author_other_work_list.value=data.data.ill;
      for(let i=0;i<author_other_work_list.value.length;i++)
    {
      author_other_work_list_path.value.push({'item_path':'https://www.sunyuanling.com/image/thumbnail/'+
      author_other_work_list.value[i].content_file_list.split(/[,，]/)[0],
      'Illustration_id':author_other_work_list.value[i].Illustration_id})
    }
    }
  }
  catch(e)
  {
    console.error(e);
  }
}
//获取作着其他作品的路径
function get_choose_item(item)
{
  work_id.value=item.work_id;
  emit('chose_item',{'work_id':work_id.value})
}
onMounted(async () => {
  await get_author_info();
  await get_follow_info();
  await get_author_work();
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
.author_follow{
  width:70%;
  height: auto;
  padding: 5px 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 15px;
  color: rgba(255,255,255,1);
  margin-top: 10px;
  font-size: 16px;
  font-weight: bold;
  cursor: pointer;
}
.author_follow:hover{
  transition: all 0.3 ease-in-out;
  opacity: 0.8;
}
.on_follow{
  background-color: rgba(0,150,250,0.8);
}
.off_follow{
  background-color: rgba(133,133,133,1);
}
.others_work{
  width: 100%;
  margin-right: 5px;
  padding: 5px;
  height: auto;
}
</style>
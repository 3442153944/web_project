<template>
  <div class="user_novel_page">
    <div class="content">
      <div class="novel_title">
        <span>
          <h3>作品列表</h3>
        </span>
      </div>
      <div class="novel_list">
        <div class="novel_item" v-for="(item,index) in novel_list" :key="index">
          <div class="novel_cover">
            <img class="novel_img" :src="'https://127.0.0.1:4434/image/'+item.work_cover">
          </div>
          <div class="novel_info">
            <div class="novel_tag">
              <div class="tag_item" v-for="(tag,index) in item.work_tags.split(/[,，]/)" :key="index">
                <span>{{tag}}</span>
              </div>
            </div>
            <div class="novel_title">
              <h3>{{item.work_name}}</h3>
            </div>
            <div class="novel_read_info"></div>
            <div class="start_read_btn">
              <div class="btn_text">
                <span>开始阅读</span>
              </div>
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
//导入cookies库所有方法
import * as cookies from '../../../../../model/cookies.js'
export default {
  name: 'user_novel_page',
}
</script>

<script setup>
let novel_list = ref([]);

//请求小说列表数据
async function get_novel_list() {
  try {
    const res = await fetch('api/get_work_info', {
      method: "post",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        user_id: cookies.get_cookie('user_id'),
        user_name: cookies.get_cookie('user_name'),
      })
    })
    const data = await res.json()
    if (data.status == 'success') {
      novel_list.value.push(...data.data);
    }
    else {
      console.log(data.message)
    }
  }
  catch (err) {
    console.log(err)
  }

}
 onMounted(() => {
  console.log(cookies.get_cookie('user_id'))
  console.log(cookies.get_cookie('user_name'))
  get_novel_list();
  console.log(novel_list.value)
})
</script>

<style scoped>
.user_novel_page {
  display: flex;
  flex-direction: column;
  width: 100%;
  height: 100%;
}

.content {
  display: flex;
  width: 100%;
  height: auto;
  flex-direction: column;
  margin: 15px auto;
}

.novel_list {
  display: flex;
  flex-wrap: wrap;
  width: 100%;
  height: 100%;
  overflow: auto;
  margin: 5px auto;
}

.novel_item {
  display: flex;
  min-width: 450px;
  min-height: 280px;
  max-width: 500px;
  max-height: 300px;
  margin: 10px;
  height: auto;
  width: auto;
  border-radius: 15px;
  overflow: hidden;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.novel_cover {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 50%;
  min-width: 50%;
  height: 100%;
  border-radius: 0px 15px 15px 0px;
  overflow: hidden;
}

.novel_img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.novel_info {
  display: flex;
  flex-direction: column;
  justify-content: space-around;
  margin-left: 10px;
}
.novel_tag{
  display: flex;
  width: 100%;
  height: auto;
  padding:5px;
  margin:5px auto;
  flex-wrap: wrap;
}
.tag_item{
  display: flex;
  justify-content: center;
  align-items: center;
  padding:5px;
  margin:0px 5px;
  white-space: break-spaces;
}
.start_read_btn{
  display: flex;
  width:80%;
  height: auto;
  padding:5px;
  margin:5px auto;
  justify-content: center;
  align-items: center;
}
.btn_text{
  display: flex;
  justify-content: center;
  align-items: center;
  width:100%;
  height: 100%;
  background-color: rgba(133,133,133,0.7);
  opacity: 0.8;
  border-radius: 15px;
  padding: 5px;
  font-weight: bold;
  color: white;
}
.btn_text:hover{
  opacity: 1;
  cursor: pointer;
  transition:all 0.3s ease-in-out;
}
</style>
<template>
  <div class="set_select">
    <div class="content">
      <div class="title">
        <span></span>
        <h3>设置精选</h3>
        <div class="close_btn" @click="close_set_select">
          <img class="icon" :src="close_btn_path">
        </div>
      </div>
      <div class="little_title">
        <span><b>项目</b></span>
        <span>{{ item_count }}/{{ all_item }}</span>
      </div>
      <div class="item_list">
        <div class="item" v-for="(item, index) in work_info_list" :key="index">
          <div class="work_cover">
            <img class="work_img" :src="item.cover_path">
          </div>
          <div class="work_info">
            <div class="work_type">
              <span>{{ item.type }}</span>
            </div>
            <div class="work_name">
              <span>{{ item.name }}</span>
            </div>
            <span>作品ID：{{ item.id }}</span>
          </div>
          <div class="delete_work_btn" @click="delete_work(index)">
            <img class="icon" :src="close_btn_path">
          </div>
        </div>
      </div>
      <div class="add_btn"></div>
      <div class="btn_box">
        <div class="save_btn" @click="edit_select_work_list()"><span>确定</span></div>
        <div class="cancel_btn" @click="close_set_select">取消</div>
      </div>
    </div>
  </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted, defineEmits } from 'vue';
import { set_cookie, expireCookie, get_cookie, set_storage, get_storage } from '../../../../../model/cookies.js'
import user_index from '../user_index.vue';
export default {
  name: 'set_select',
}
</script>

<script setup>
let server_ip = "https://127.0.0.1:4434/"
let close_btn_path = server_ip + "assets/close.svg";
let emit = defineEmits(['close_set_select']);
set_storage('username', 'admin')
set_cookie('user_id', 'f575b4d3-0683-11ef-adf4-00ffc6b98bdb')
function close_set_select() {
  emit('close_set_select', false);
}
let all_item = ref(3);
let item_count = ref(1);

let work_info_list = ref([{
  "cover_path": "https://127.0.0.1:4434/image/65014220_p0.jpg",
  "type": "作品类型",
  "name": "作品名称",
  "work_id": ""
},
{
  "cover_path": "https://127.0.0.1:4434/image/82181448_p0(1).jpg",
  "type": "作品类型",
  "name": "作品名称",
  "workid": ""
},
{
  "cover_path": "https://127.0.0.1:4434/image/87328997_p0.jpg",
  "type": "作品类型",
  "name": "作品名称",
  "work_id": ""
}])
item_count.value = work_info_list.value.length;

//删除列表中指定作品
function delete_work(index) {
  work_info_list.value.splice(index, 1);
  item_count.value = work_info_list.value.length;
}
// 请求精选作品列表
async function get_select_work_list() {
  try {
    const res = await fetch('api/getSelectWorkList', {
      method: 'post',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        username: get_storage('username'),
        user_id: get_cookie('user_id')
      }),
    });
    const data = await res.json();
    if (data.status == 'success') {
      const temp_work_info_list = data.data;
      let ill_list = [];
      let work_id = [];
      if (temp_work_info_list.ill_id) {
        ill_list = temp_work_info_list.ill_id;
      }
      if (temp_work_info_list.work_id) {
        work_id = temp_work_info_list.work_id;
      }

      await set_workinfo_list(ill_list, work_id);
    } else if (data.status == 'error') {
      console.log(data.message);
    }
  } catch (err) {
    console.log(err);
  }
}

// 通过ID请求作品信息
async function get_work_info(type, id) {
  try {
    const res = await fetch('api/useIdGetWorkInfo', {
      method: 'post',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        [type]: id,
        type: type === 'ill_id' ? 'ill' : 'work'
      })
    });
    return await res.json();
  } catch (err) {
    console.log(err);
    return null;
  }
}

// 组装work_info_list
function set_work_info_list(type, data_value) {
  let temp = [];
  let data = data_value[0].data;
  for (let i = 0; i < data.length; i++) {
    let temp_obj = {};
    if (type === 'ill') {
      temp_obj.cover_path = 'https://127.0.0.1:4434/image/' + data[i].content_file_list.split(',')[0];
      temp_obj.type = '插画';
      temp_obj.name = data[i].name;
      temp_obj.id = data[i].Illustration_id;
    } else if (type === 'work') {

      temp_obj.cover_path = 'https://127.0.0.1:4434/image/' + data[i].work_cover;
      temp_obj.type = '小说';
      temp_obj.name = data[i].work_name;
      temp_obj.id = data[i].work_id;
    }
    temp.push(temp_obj);
  }
  return temp;
}

// 设置work_info_list
async function set_workinfo_list(ill_list, work_list) {
  let work_info = [];

  for (let i = 0; i < ill_list.length; i++) {
    let info = await get_work_info('ill_id', ill_list[i]);
    if (info) {
      work_info.push(...set_work_info_list('ill', [info]));
    }
  }

  for (let i = 0; i < work_list.length; i++) {
    let info = await get_work_info('work_id', work_list[i]);
    if (info) {
      work_info.push(...set_work_info_list('work', [info]));
    }
  }
  work_info_list.value = work_info;
  item_count.value = work_info.length;
}
onMounted(() => {
  get_select_work_list();
})

//编辑精选作品列表
async function edit_select_work_list() {
  try {
    const res = await fetch('api/EditSelectWorkList', {
      method: 'post',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        username: get_storage('username'),
        user_id: get_cookie('user_id'),
        select_work_list:set_update_work_info_list(),
      })
    })
    const data = await res.json();
    if (data.status == 'success') {
      console.log('精选作品列表修改成功');
    }
    else if (data.status == 'error') {
      console.log(data.message);
    }
  }
  catch (err) {
    console.log(err);
  }
  close_set_select();
}
//设置更新的信息
function set_update_work_info_list() {
  let temp = work_info_list.value;
  let obj = {}
  let ill_id_list = []
  let work_id_list = []
  if (temp.length > 0) {
    for (let i = 0; i < temp.length; i++) {
      if (temp[i].type == '插画') {
        ill_id_list.push(temp[i].id)
      }
      else if (temp[i].type == '小说') {
        work_id_list.push(temp[i].id)
      }
    }
  }
  obj.ill_id = ill_id_list;
  obj.work_id=work_id_list;
  return obj;
}
</script>

<style scoped>
.set_select {
  display: flex;
  position: fixed;
  top: 0px;
  left: 0px;
  width: 100vw;
  height: 100vh;
  background-color: rgba(0, 0, 0, 0.3);
  z-index: 10;
}

.content {
  display: flex;
  flex-direction: column;
  width: 450px;
  height: auto;
  padding: 5px;
  border-radius: 25px;
  margin: auto;
  background-color: #fff;
}

.title {
  display: flex;
  width: 100%;
  height: auto;
  justify-content: space-between;
}

.icon {
  width: 25px;
  height: 25px;
  object-fit: cover;
}

.close_btn {
  display: flex;
  width: 35px;
  height: 35px;
  justify-content: center;
  align-items: center;
  margin-top: auto;
  margin-bottom: auto;
  margin-right: 10px;
}

.close_btn:hover {
  cursor: pointer;
  background-color: rgba(133, 133, 133, 0.6);
  border-radius: 50%;
  transition: all 0.3 ease-in-out;
}

.little_title {
  display: flex;
  width: 90%;
  height: auto;
  margin: 10px auto;
  justify-content: space-between;
}

.item_list {
  display: flex;
  width: 90%;
  height: auto;
  margin: 10px auto;
  flex-direction: column;
}

.item {
  display: flex;
  width: 100%;
  height: auto;
  margin: 10px auto;
  min-height: 100px;
  max-height: 200px;
  justify-content: space-between;
}

.work_cover {
  display: flex;
  width: 20%;
  height: 100%;
}

.work_img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.work_info {
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  width: 60%;
  height: 100%;
  margin-left: 10px;
}

.delete_work_btn {
  display: flex;
  width: 35px;
  height: 35px;
  justify-content: center;
  align-items: center;
  margin-top: auto;
  margin-bottom: auto;
  margin-right: 10px;
}

.delete_work_btn:hover {
  cursor: pointer;
  background-color: rgba(133, 133, 133, 0.6);
  border-radius: 50%;
  transition: all 0.3 ease-in-out;
}

.btn_box {
  display: flex;
  width: 90%;
  height: auto;
  margin-top: 10px;
  margin-bottom: 10px;
  justify-content: flex-end;
  margin: 10px auto;
}

.save_btn {
  display: flex;
  padding: 5px;
  padding: 8px 15px;
  border-radius: 15px;
  background-color: rgba(0, 150, 250, 1);
  opacity: 1;
  color: #fff;
  font-weight: bold;
  margin-right: 15px;
}

.save_btn:hover {
  cursor: pointer;
  opacity: 0.8;
  transition: all 0.3 ease-in-out;
}

.cancel_btn {
  display: flex;
  padding: 5px;
  padding: 8px 15px;
  border-radius: 15px;
  background-color: rgba(133, 133, 133, 1);
  opacity: 1;
  color: #fff;
  font-weight: bold;
  margin-right: 0px;
}

.cancel_btn:hover {
  cursor: pointer;
  opacity: 0.8;
  transition: all 0.3 ease-in-out;
}
</style>
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
<<<<<<< HEAD
            <div class="work_name">
              <span>{{ item.name }}</span>
=======
        </div>
        <div class="little_title">
            <span><b>项目</b></span>
            <span>{{item_count}}/{{all_item}}</span>
        </div>
        <div class="item_list">
            <div class="item" v-for="(item,index) in work_info_list" :key="index">
              <div class="work_cover">
                <img class="work_img" :src="item.cover_path">
              </div>
              <div class="work_info">
                <div class="work_type">
                  <span>{{item.type}}</span>
                </div>
                <div class="work_name">
                  <span>{{item.name}}</span>
                </div>
              </div>
              <div class="delete_work_btn" @click="delete_work(index)">
                <img class="icon" :src="close_btn_path">
              </div>
>>>>>>> 840b1f06e0a13ff6152db1705f7118ebaab45605
            </div>
          </div>
          <div class="delete_work_btn">
            <img class="icon" :src="close_btn_path">
          </div>
        </div>
      </div>
      <div class="add_btn"></div>
      <div class="btn_box">
        <div class="save_btn"><span>确定</span></div>
        <div class="cancel_btn" @click="close_set_select">取消</div>
      </div>
    </div>
  </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted, defineEmits } from 'vue';
export default {
  name: 'set_select',
}
</script>

<script setup>
let server_ip = "https://127.0.0.1:4434/"
let close_btn_path = server_ip + "assets/close.svg";
let emit = defineEmits(['close_set_select']);

function close_set_select() {
  emit('close_set_select', false);
}
let all_item = ref(3);
let item_count = ref(1);

let work_info_list = ref([{
  "cover_path": "https://127.0.0.1:4434/image/65014220_p0.jpg",
  "type": "作品类型",
  "name": "作品名称"
},
{
  "cover_path": "https://127.0.0.1:4434/image/82181448_p0(1).jpg",
  "type": "作品类型",
  "name": "作品名称"
},
{
  "cover_path": "https://127.0.0.1:4434/image/87328997_p0.jpg",
  "type": "作品类型",
  "name": "作品名称"
}])
item_count.value=work_info_list.value.length;

//删除列表中指定作品
function delete_work(index){
  work_info_list.value.splice(index,1);
  item_count.value=work_info_list.value.length;
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
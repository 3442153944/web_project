<template>
  <div class="show_userinfo">
    <div class="info_box">
        <div class="title_box">
          <span><b>个人信息</b></span>
          <div class="close_btn" @click="close_userinfo()"><img :src="close_btn_path" class="icon"></div>
        </div>
        <div class="user_avatar_box">
          <img :src="user_avatar">
        </div>
        <div class="user_name">
          <span>{{username}}</span>
        </div>
        <div class="address"> 
          <img src="https://127.0.0.1:4434/assets/location.svg" class="icon">
          <span>{{address}}</span>
        </div>
        <div class="info_content">
          <span class="title">性别</span>
          <span>{{sex}}</span>
        </div>
        <div class="info_content">
          <span class="title">年龄</span>
          <span>{{age}}&nbsp;岁</span>
        </div>
        <div class="info_content">
          <span class="title">生日</span>
          <span>{{birthday}}</span>
        </div>
    </div>
  </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { server } from 'typescript';
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted,defineEmits } from 'vue';
export default {
  name: 'show_userinfo',
}
</script>

<script setup>
let server_ip=ref('https://127.0.0.1:4434/');
let close_btn_path=ref(server_ip.value+'assets/close.svg');
let emit=defineEmits(['close_show_userinfo']);
//向父组件发送关闭消息
function close_userinfo(){
  emit('close_show_userinfo',false);
}
//获取用户的所有信息
let user_info = ref({})
let user_name = ref('admin')
let user_id=ref('f575b4d3-0683-11ef-adf4-00ffc6b98bdb');
async function get_user_info() {
    try {
        const res = await fetch('api/get_all_userinfo', {
            method: 'post',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                user_name: user_name.value
            })
        })
        const data = await res.json()
        if (data.status != 'success') {
            console.log(data.message)
        }
        else {
            user_info.value = data.data;

            console.log(user_info.value)
        }
    }
    catch (err) {
        console.log(err)
    }
}
onMounted(() => {
    get_user_info()
})
let user_avatar=ref(server_ip.value+'image/')
let username=ref();
let address=ref();
let sex=ref();
let age=ref();
let birthday=ref();
function set_userdata(){
  username.value=user_info.value.username;
  user_avatar.value=server_ip.value+'image/'+user_info.value.user_avatar;
  address.value=user_info.value.user_address;
  sex.value=user_info.value.sex;
  let date=new Date();
  let year=date.getFullYear();
  console.log(year)
  console.log(user_info.value.birthday.slice(0,4))
   age.value=year-user_info.value.birthday.slice(0,4);
   birthday.value=user_info.value.birthday.slice(5,11);
}
onMounted(()=>{
  setTimeout(()=>{
    set_userdata()
  },100)
})

//点击空白区域关闭窗口
document.addEventListener('click',function(e){
  var main_page=document.querySelector('.show_userinfo');
  var sub_page=document.querySelector('.info_box');
  //点击位置如果在info_box中，不做处理，如何在不在info_box中并且不在main_page中，关闭窗口
  if(e.target==sub_page){
    return;
  }
  if(e.target==main_page){
    close_userinfo();
  }
})
</script>

<style scoped>
  .show_userinfo{
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100%;
    background-color: rgba(0,0,0,0.5);
    position: fixed;
    top: 0;
    left: 0;
    z-index: 10;
    width: 100%;
  }
  .info_box{
    display: flex;
    flex-direction: column;
    width:450px;
    height: auto;
    background-color: rgba(255,255,255,1);
    border-radius: 15px;
    overflow: hidden;
    box-shadow: 0px 0px 10px rgba(0,0,0,0.3);
  }
  .title_box{
    display: flex;
    align-items: center;
    width:100%;
    position: relative;
    justify-content: center;
    margin:10px auto;
  }
  .title_box img{
    display: flex;
    justify-content: center;
    align-items: center;
    cursor: pointer;
  }
  .close_btn{
    display: flex;
    justify-content: center;
    align-items: center;
    position: absolute;
    right: 5px;
    width:35px;
    height: 35px;
    cursor: pointer;
    border-radius: 50%;
    overflow: hidden;
  }
  .close_btn:hover{
    background-color: rgba(133,133,133,0.5);
    transition:all 0.3s ease-in-out;
  }
  .icon{
    width:25px;
    height:25px;
    object-fit: cover;
  }
  .user_avatar_box{
    display: flex;
    width:100%;
    height: 30%;
    justify-content: center;
    align-items: center;
    margin:10px auto;
  }

  .user_avatar_box img{
    width:80px;
    height: 80px;
    border-radius: 50%;
    object-fit: cover;
    overflow: hidden;
  }
  .user_name{
    width:100%;
    height: auto;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 18px;
  }
  .address{
    display: flex;
    justify-content: center;
    align-items: center;
    width:90%;
    margin: 10px auto;
    border-bottom: 1px solid rgba(77, 74, 74,0.5);
  }
.info_content{
  display: flex;
  width:80%;
  margin: 10px auto;
  justify-content: space-between;
  align-items: center;
}
.title{
  font-size: 18px;
  font-weight: bold;
}
</style>
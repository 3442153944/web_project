<template>
  <div class="back_img_box">
    <div class="img_box">
        <img :src="back_img_path">
        <div class="edit_box">
            <div class="edit_btn" @click="show_edit_box">
                <img :src="edit_path" class="icon">
            </div>
            <div class="del_btn" @click="delete_user_back_img">
                <img :src="delete_path" class="icon">
            </div>
        </div>
        
    </div>
    <div class="user_info">
        <div class="user_avatar">
            <img :src="user_avatar">
        </div>
        <div class="info_box">
            <div class="username">
                <div class="name">
                    <span>{{username}}</span>
                </div>
                <div class="edit_person_info" @click="show_edit_box_self_info">
                    <span >编辑个人资料</span>
                </div>
            </div>
            <div class="follow_num">
                <span>{{follow_num}}&nbsp;已关注</span>
            </div>
            <div class="address">
                <img :src="location_path">
                <span>&nbsp;{{address}}</span>
            </div>
            <div class="show_person_info" @click="show_userinfo_box">
                <span style="color:rgb(133,133,133)">查看个人信息</span>
            </div>
           
        </div>
        
    </div>
    <div class="float_user_info_box" style="display:none;">
        <div class="user_info">
            <div class="user_avatar">
                <img :src="user_avatar">
            </div>
            <div class="info_box_float">
                <div class="username">
                    <div class="name">
                        <span>{{username}}</span>
                    </div>
                    <div class="edit_person_info" @click="show_edit_box_self_info">
                        <span >编辑个人资料</span>
                    </div>
                </div>
                <div class="follow_num">
                    <span>{{follow_num}}&nbsp;已关注</span>
                </div>
            </div>
        </div>
    </div>
    <edit_box v-if="is_edit_box_show" style="position:fixed;top:0px;left:0px;width:100vw;height:100vh;" id="is_edit_box_show" 
    @close_box="close_box_msg"></edit_box>
    <edit_self_info v-if="is_edit_self_info_show" style="position:fixed;top:0px;left:0px;width:100vw;height:100vh;" 
    @close_edit_self_info="close_edit_self_info_msg"></edit_self_info>
    <show_userinfo style="position:fixed;top:0px;left:0px;width:100vw;height:100vh;" v-if="is_show_userinfo_show" 
    @close_show_userinfo="close_show_userinfo_msg"></show_userinfo>
  </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted ,defineEmits} from 'vue';
import edit_box from './edit_box.vue';
import edit_self_info from './edit_self_info.vue'
import show_userinfo from './show_userinfo.vue'
export default {
  name: 'back_img_box',
  components:{edit_box,edit_self_info,show_userinfo}
}
</script>

<script setup>
let server_ip = ref('https://127.0.0.1:4434/');
let back_img_path = ref(server_ip.value + 'image/97165605_p0.jpg');
let edit_path=ref(server_ip.value+'assets/edit.svg');
let delete_path=ref(server_ip.value+'assets/delete.svg');
let user_avatar=ref(server_ip.value+'image/94552901_p0 (1).jpg');
let username=ref('用户名');
let userid=ref('123456');
let follow_num=ref('114514');
let location_path=ref(server_ip.value+'assets/location.svg');
let address=ref('北京市海淀区');

//用户信息栏的浮动

function float_user_info_box() {
    let window_height = window.innerHeight;
    let user_info_box = document.querySelectorAll('.user_info')[0];
    let address_box = document.querySelector('.address');
    let float_user_info_box = document.querySelector('.float_user_info_box');

    const handleScrollResize = () => {
        let user_info_rect = user_info_box.getBoundingClientRect();
        let address_box_rect = address_box.getBoundingClientRect();
        
        let address_box_bottom_to_window_bottom = window_height - address_box_rect.bottom;
        
        let user_info_box_bottom_to_window_top = user_info_rect.bottom;

        if (address_box_bottom_to_window_bottom >= 1 || user_info_box_bottom_to_window_top <= 0) {
            float_user_info_box.style.display = 'none';
        } else {
            float_user_info_box.style.display = ''; 
        }
    };

    window.addEventListener('scroll', handleScrollResize);
    window.addEventListener('resize', () => {
        window_height = window.innerHeight;
        handleScrollResize();
    });

    handleScrollResize(); // Initial check on load
}
onMounted(() => {
    float_user_info_box();
})

//编辑框的显示与隐藏
let is_edit_box_show = ref(false);
function show_edit_box() {
    if (is_edit_box_show.value) {
        is_edit_box_show.value = false;
    } else {
        is_edit_box_show.value = true;
    }
}

//接收子组件消息
function close_box_msg(status){
    is_edit_box_show.value=status.value;
    console.log(status.value);
}

//删除用户背景
async function delete_user_back_img() {
    //弹窗提示用户是否删除
    if (!confirm("您确定要删除用户背景图片吗？")) {
        return;
    }
    //发送请求
    const res= await fetch('api/delete_back_image',{
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            user_name:username.value,
            user_id:userid.value,
        }),
    })
    const data= await res.json();
    if(data.status!='success')
    {
        alert(data.message)
    }
    else{
        alert("删除成功");
    }
}

//编辑个人信息盒子显示与隐藏
let is_edit_self_info_show = ref(false);
function show_edit_box_self_info(){
    is_edit_self_info_show.value=true;
}
//接收子组件消息
function close_edit_self_info_msg(status){
    is_edit_self_info_show.value=status.value;
    console.log(status.value);
}
//查看个人信息盒子
let is_show_userinfo_show=ref(false);
function show_userinfo_box(){
    is_show_userinfo_show.value=true;
}
//接收子组件消息
function close_show_userinfo_msg(status){
    is_show_userinfo_show.value=status.value;
    }
</script>

<style scoped>
  .back_img_box{
    display: flex;
    flex-direction: column;
    width:100%;
    height: auto;
  }
  .img_box{
    display: flex;
    position: relative;
    width:100vw;
    height: 70vh;
    overflow: hidden;
  }

  .img_box img{
    width:100%;
    height: 100%;
    object-fit: cover;
}
.edit_box{
    display: flex;
    position:absolute;
    right: 5px;
    margin-bottom: 10px;
    align-self: flex-end;
    margin-right: 10px;
}
.edit_btn{
    display: flex;
    justify-content: center;
    align-items: center;
    width:40px;
    height: 40px;
    border-radius: 50%;
    background-color: rgba(133,133,133,0.8);
    opacity: 1;
    margin-right: 10px;
}
.edit_btn:hover{
    opacity: 0.8;
    cursor: pointer;
    transition: all 0.3s ease-in-out;
}
.edit_btn img{
    width:80%;
    height: 80%;
    object-fit: cover;
}
.del_btn{
    display: flex;
    justify-content: center;
    align-items: center;
    width:40px;
    height: 40px;
    border-radius: 50%;
    background-color: rgba(133,133,133,0.8);
    opacity: 1;
    margin-right: 10px;
}
.del_btn:hover{
    opacity: 0.8;
    cursor: pointer;
    transition: all 0.3s ease-in-out;
}
.del_btn img{
    width: 80%;
    height: 80%;
    object-fit: cover;
}
.user_info{
    display: flex;
    width: 80%;
    height: 30vh;
    margin: 0 auto;
    z-index: 2;
}
.user_avatar{
    display: flex;
    justify-content: center;
    align-items: center;
    width: 120px;
    height: 120px;
    border-radius: 50%;
    margin-top: -30px;
    overflow: hidden;
    border:2px solid #fff;
}
.user_avatar img{
    width: 100%;
    height: 100%;
    object-fit: cover;
}
.info_box{
    display: flex;
    flex-direction: column;
    flex-grow: 1;
    flex:1;
    margin-left: 20px;
    justify-content: space-around;
}
.username{
    display: flex;
    justify-content: space-between;
    align-items: center;
}
.address{
    display: flex;
    align-items: center;
}
.address img{
    width:20px;
    height: 20px;
    object-fit: cover;
}
.show_person_info{
    display: flex;
    align-items: center;
    color: rgba(133,133,133,1);
    opacity: 1;
    width:auto;
    height: auto;
    max-width: 100px;
    padding-left:10px;
    padding-right: 10px;
}
.show_person_info:hover{
    opacity: 0.8;
    cursor: pointer;
    transition: all 0.3s ease-in-out;
}
.name{
    font-size: 18px;
    font-weight: bold;
}
.edit_person_info{
    display:flex;
    width: 180px;
    height: 40px;
    padding: 5px;
    border-radius: 25px;
    font-size: 18px;
    font-weight: bold;
    background-color:rgba(133,133,133,0.6);
    justify-content: center;
    align-items: center;
    opacity: 1;
}
.edit_person_info:hover{
    opacity: 0.8;
    cursor: pointer;
    transition: all 0.3s ease-in-out;

    }
.float_user_info_box{
    display: flex;
    position: fixed;
    bottom: -3px;
    left: -5px;
    width: 100%;
    margin: 0 auto;
    z-index: 6;
    background-color: #fff;
    height: 150px;
}
.info_box_float{
    display: flex;
    flex-direction: column;
    width: 80%;
    margin-left: 20px;
    flex-grow: 1;
    flex: 1;
    margin-top: 10px;
}
</style>
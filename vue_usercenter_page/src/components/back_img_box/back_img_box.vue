<template>
  <div class="back_img_box">
    <div class="img_box">
        <img :src="back_img_path">
        <div class="edit_box">
            <div class="edit_btn">
                <img :src="edit_path" class="icon">
            </div>
            <div class="del_btn">
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
                <div class="edit_person_info">
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
            <div class="show_person_info">
                <span style="color:rgb(133,133,133)">查看个人信息</span>
            </div>
           
        </div>
        
    </div>
    <div class="float_user_info_box">
        
    </div>
  </div>
</template>

<script>
import { ref, reactive, toRefs, watch, onMounted, onUnmounted } from 'vue';
export default {
  name: 'back_img_box',
}
</script>

<script setup>
let server_ip = ref('https://127.0.0.1:4434/');
let back_img_path = ref(server_ip.value + 'image/97165605_p0.jpg');
let edit_path=ref(server_ip.value+'assets/edit.svg');
let delete_path=ref(server_ip.value+'assets/delete.svg');
let user_avatar=ref(server_ip.value+'image/94552901_p0 (1).jpg');
let username=ref('用户名');
let follow_num=ref('114514');
let location_path=ref(server_ip.value+'assets/location.svg');
let address=ref('北京市海淀区');

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
</style>
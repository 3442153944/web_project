<template>
  <div class="edit_self_info">
    <div class="edit_box">
        <div class="title_box">
            <span>编辑个人信息</span>
            <div class="close_btn">
                <img :src="close_btn_path" class="icon">
            </div>
        </div>
        <div class="user_avatar">
            <img>
        </div>
    </div>
  </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted } from 'vue';
export default {
  name: 'edit_self_info',
}
</script>

<script setup>
let server_ip=ref('https://127.0.0.1:4434/');
let close_btn_path=ref(server_ip.value+'assets/close.svg');
let user_name=ref('admin')
let user_info=ref({})

async function get_user_info(){
    try{
        const res=await fetch('api/get_all_userinfo',{
            method:'post',
            headers:{
                'Content-Type':'application/json'
            },
            body:JSON.stringify({
                user_name:user_name.value
            })
        })
        const data=await res.json()
       if(data.status!='success')
       {
        console.log(data.message)
       }
       else{
        user_info.value=data.data;

        console.log(user_info.value)
       }
    }
    catch(err){
        console.log(err)
    }
}

onMounted(()=>{
    get_user_info()
})
</script>

<style scoped>
  .edit_self_info{
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100%;
    width: 100%;
    background-color: rgba(0,0,0,0.3);
  }
  .edit_box{
    display:flex;
    width: 350px;
    height: auto;
    justify-content: center;
    align-items: center;
    background-color: #fff;
    border-radius: 15px;
 }
 .title_box{
    display: flex;
    margin:10px auto;
    align-items: center;
    position: relative;
    width: 100%;
 }
 .close_btn{
    position: absolute;
    width: 35px;
    height: 35px;
    right: 5px;
    cursor: pointer;
    display: flex;
    justify-content: center;
    align-items: center;
    border-radius: 50%;
    overflow: hidden;
 }
 .close_btn:hover{
    background-color: rgba(133,133,133,0.5);
    transition: all 0.3s ease-in-out;
 }
 .close_btn img{
    width:80%;
    height: 80%;
    object-fit: cover;
 }
</style>
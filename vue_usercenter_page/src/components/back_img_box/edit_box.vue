<template>
  <div class="edit_box">
    <div class="edit">
        <div class="title_box">
            <div class="title">
                <span style="font-size:18px;font-weight:bold;align-self:center">封面设置</span>
            </div>
            <div class="close_btn" @click="close_box">
                <img :src="close_svg_path" class="icon">
            </div>
        </div>
        <div class="content_box">
            <img :src="back_img_path">
            <div class="upload_img_box">
                <div class="upload_img_btn">
                    <img :src="upload_img_svg_path">
                </div>
            </div>
        </div>
        <div class="img_info">
            <span class="tips_name"><b>适用格式</b></span>
            <span class="tips_content">JPEG/PNG/GIF/BMP/WEBP</span>
        </div>
        <div class="img_info">
            <span class="tips_name"><b>最大容量</b></span>
            <span class="tips_content">8MB</span>
        </div>
        <div class="img_info">
            <span class="tips_name"><b>最大分辨率</b></span>
            <span class="tips_content">4096*4096</span>
        </div>
        <div class="img_info">
            <span class="tips_name"><B>建议长宽比</B></span>
            <span class="tips_content">2:1</span>
        </div>
        <div class="tips_box">
            <div class="tips_icon"></div>
            <div class="tips_content"></div>
        </div>
        <div class="uplaod_tips"></div>
        <div class="agree_upload_btn"></div>
        <div class="cancel_btn"></div>
    </div>
  </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted ,defineEmits} from 'vue';
export default {
  name: 'edit_box',
}
</script>

<script setup>
let server_ip='https://127.0.0.1:4434/';
let close_svg_path=ref(server_ip+'assets/close.svg');
let edit_box_show=ref(false);
let emit=defineEmits(['close_box']);
let back_img_path=ref(server_ip+'image/97165605_p0.jpg');
let upload_img_svg_path=ref(server_ip+'assets/image.svg');

function close_box(){
    let edit_box=document.getElementById('is_edit_box_show');
    edit_box.style.display='none';
    emit('close_box',edit_box_show);
}
</script>

<style scoped>
  .edit_box{
    display: flex;
    width:100vw;
    height:100vh;
    position: fixed;
    top:0;
    left:0;
    background-color:rgba(0,0,0,0.3);
    z-index: 7;
  }
  .edit{
    width:350px;
    height: 600px;
    display: flex;
    flex-direction: column;
    margin: auto;
    padding:5px;
    border-radius: 15px;
    background-color: rgba(255,255,255,1);
    box-shadow: 0px 0px 10px rgba(0,0,0,0.3);
  }
  .title_box{
    display: flex;
    margin: 5px 0;
    justify-content: center;
    position: relative;
    padding: 5px;
  }
  .icon{
    width:25px;
    height: 25px;
    object-fit: cover;
  }
  .close_btn{
    position: absolute;
    right: 5px;
    width: 35px;
    height: 35px;
    border-radius: 50%;
    cursor: pointer;
    overflow: hidden;
    justify-content: center;
    align-items: center;
    display: flex;
   top:0px;
  }
  .close_btn:hover{
    background-color: rgba(133,133,133,0.5);
    transition: all 0.3s ease-in-out;
  }
  .close_btn img{
    margin: auto;
  }
  .content_box{
    display: flex;
    width: 100%;
    height: 30%;
    margin-top:10px;
    display: flex;
    justify-content: center;
    align-items: center;
    overflow: hidden;
    position: relative;
  }
  .content_box img{
    object-fit: cover;
    width:100%;
    height:100%;
  }
  .upload_img_box{
    display: flex;
    width: 100%;
    height: 100%;
    position: absolute;
    top:0;
    left:0;
    justify-content: center;
    align-items: center;
    cursor: pointer;
    opacity: 0;
  }
  .upload_img_box:hover{
    background-color: rgba(1,1,1,0.3);
    transition: all 0.3s ease-in-out;
    opacity: 1;
  }
.upload_img_btn{
    width: 80px;
    height: 80px;
    overflow: hidden;
    border-radius: 15px;
    margin:auto;
}
.upload_img_btn img{
    width: 100%;
    height: 100%;
    object-fit: cover;

}
.img_info{
  display: flex;
  margin:10px auto;
  justify-content: space-between;
  align-items: center;
  width: 90%;
  height: auto;
}
</style>
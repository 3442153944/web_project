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
        <div class="content_box" @click="upload_img">
            <img :src="back_img_path">
            <div class="upload_img_box">
                <div class="upload_img_btn">
                    <img :src="upload_img_svg_path">
                </div>
            </div>
            <input type="file" id="upload_img" style="display:none" accept="image/*">
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
            <div class="tips_icon">
              <img :src="info_path">
            </div>
            <div class="tips_content">
              <span>根据您上传的图片及设备显示不同，图片四周有可能会显示不全。</span>
            </div>
        </div>
        <div class="uplaod_tips">
          <span>请不要上传R-18或使用规则中禁止投稿的作品。如果您上传了相关图片，设置可能会被清除。</span>
        </div>
        <div class="agree_upload_btn" @click="sure_upload">
          <span>同意并上传</span>
        </div>
        <div class="cancel_btn" @click="close_box">
          <span>取消</span>
        </div>
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
let info_path=ref(server_ip+'assets/info.svg');

function close_box(){
    let edit_box=document.getElementById('is_edit_box_show');
    edit_box.style.display='none';
    emit('close_box',edit_box_show);
}

//上传文件操作

 function upload_img(){
  var upload_img_value=document.getElementById('upload_img');
    upload_img_value.click();
   
}
async function sure_upload(){
  var upload_img_value=document.getElementById('upload_img');
  try{
      let file=upload_img_value.files[0];
      let file_name=file.name;
      let user_name="admin"
      let user_id="f575b4d3-0683-11ef-adf4-00ffc6b98bdb"
      const formData=new FormData();
      formData.append('file',file);
      formData.append('file_name',file_name);
      formData.append('user_name',user_name);
      formData.append('user_id',user_id);
      //创建于服务器的连接
      const res=await fetch('api/edit_back_img',{
        method:'POST',
        headers:{
          
        },
        body:formData
      })
      let data=await res.json();
      console.log(data);
      if(data.status!='success')
      {
        alert(data.message);
      }
      else{
        alert('上传成功');
      }
    }
    catch(err){
      console.log(err);
    }
}
</script>

<style scoped>
/*倒序编辑样式开始，方便编辑*/
.agree_upload_btn{
  display: flex;
  justify-content: center;
  align-items: center;
  width:80%;
  height: 40px;
  margin: 10px auto;
  background-color: rgba(0,150,250,1);
  border-radius: 25px;
  font-size: 16px;
  color: white;
  cursor: pointer;
  font-weight: bold;
  opacity: 1;
}
.cancel_btn{
  display: flex;
  justify-content: center;
  align-items: center;
  width:80%;
  height: 40px;
  margin: 10px auto;
  background-color: rgba(133,133,133,0.8);
  border-radius: 25px;
  font-size: 16px;
  color: white;
  cursor: pointer;
  font-weight: bold;
  opacity: 1;
}
.agree_upload_btn:hover,.cancel_btn:hover{
  opacity: 0.8;
  transition: all 0.3s ease-in-out;
}
.uplaod_tips{
  display: flex;
  width: 80%;
  margin: 10px auto;
  align-items: center;
  font-size: 13px;
}
.tips_box{
  display: flex;
  position: relative;
  width: 80%;
  margin: 10px auto;
  align-items: center;
  background-color: rgba(133,133,133,0.3);
  height: 50px;
  border-radius: 10px;
  padding: 5px;
}
.tips_box img{
  width: 25px;
  height: 25px;
  object-fit: cover;
  margin-right: 10px;
}
/*倒序编辑样式结束*/
  .edit_box{
    display: flex;
    width:100vw;
    height:100vh;
    position: fixed;
    top:0;
    left:0;
    background-color:rgba(0,0,0,0.3);
    z-index: 7;
    overflow: auto;
    justify-content: center;
    align-items: center;
  }
  .edit{
    width:350px;
    height: 660px;
    display: flex;
    flex-direction: column;
    margin: auto;
    padding:5px;
    border-radius: 15px;
    background-color: rgba(255,255,255,1);
    box-shadow: 0px 0px 10px rgba(0,0,0,0.3);
    overflow: auto;
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
    height: 25%;
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
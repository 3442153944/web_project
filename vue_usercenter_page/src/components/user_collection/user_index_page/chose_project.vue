<template>
    <div class="chose_project">
      <div class="content_box">
          <div class="title_box">
              <span></span>
              <h3>选择项目</h3>
              <div class="close_btn" @click="chose_close_btn_click()">
                  <img class="icon" :src="close_btn_path">
              </div>
          </div>
          <div class="switch_tag">
              <div class="tag_item" @click="switch_page(0)"><span>插画·漫画</span></div>
              <div class="tag_item" @click="switch_page(1)"><span>小说</span></div>
              <div class="tag_item" @click="switch_page(2)"><span>约稿</span></div>
          </div>
          <div class="ill_page">
              <div class="item_img">
                  <img :src="ill_image_path">
              </div>
          </div>
          <div class="novel_page">
              <div class="series_box">
                  <h3>系列</h3>
                  <div class="series_list">
                      <div class="series_item">
                          <div class="series_title">
                              <span></span>
                              <span>作品</span>
                              <div class="select_btn"></div>
                          </div>
                      </div>
                  </div>
              </div>
              <div class="work">
                  <h3>作品</h3>
                  <div class="work_item">
                      <div class="work_cover"></div>
                      <div class="work_name"></div>
                      <div class="select_btn"></div>
                  </div>
              </div>
          </div>
          <div class="invited_draft">
              约稿作品
          </div>
          <div class="btn_box">
              <div class="save_btn"><span>保存</span></div>
              <div class="cancel_btn" @click="chose_close_btn_click()"><span>取消</span></div>
          </div>
      </div>
    </div>
  </template>
  
  <script>
  // eslint-disable-next-line no-unused-vars
  import { ref, reactive, toRefs, watch, onMounted, onUnmounted,defineEmits } from 'vue';
  export default {
    name: 'chose_project',
  }
  </script>
  
  <script setup>
  let emit=defineEmits(['chose_close_btn_click']);
  let server_ip='https://127.0.0.1:4434/'
  let close_btn_path=ref(server_ip+'assets/close.svg');
  let ill_image_path=ref(server_ip+'image/65014220_p0.jpg')
  let work_id=ref('1')
  let user_id=ref('f575b4d3-0683-11ef-adf4-00ffc6b98bdb');
  let user_name=ref('admin');
  let work_info=ref([])
  
  //获取小说作品的信息
  async function get_novel_info(){
      try{
          let res=await fetch('api/get_work_info',{
              method:'POST',
              headers:{
                  'Content-Type':'application/json'
              },
              body:JSON.stringify({
                  user_id:user_id.value,
                  user_name:user_name.value,
              })
          })
          const data=await res.json()
          if(data.status=="success")
          {
              work_info.value=data.data;
              console.log(data.data)
          }
          else{
              console.log('error')
          }
      }
      catch(err){
          console.log(err)
      }
  }
  
  onMounted(()=>{
      get_novel_info();
      console.log(work_info.value.work_name)
  })
  //传递关闭消息
  function chose_close_btn_click(){
      emit('chose_close_btn_click',false);
  }
  
  //切换子页面
  function switch_page(index){
      var page=document.querySelectorAll('.tag_item');
      let temp=document.querySelector('.ill_page');
      let temp2=document.querySelector('.novel_page');
      let temp3=document.querySelector('.invited_draft');
      switch(index){
          case 0:
              page[0].style.backgroundColor='rgba(133,133,133,0.5)';
              page[1].style.backgroundColor='';
              page[2].style.backgroundColor='';
             temp.style.display='';
             temp2.style.display='none';
             temp3.style.display='none';
              break;
          case 1:
              page[0].style.backgroundColor='';
              page[1].style.backgroundColor='rgba(133,133,133,0.5)';
              page[2].style.backgroundColor='';
              temp.style.display='none';
              temp2.style.display='';
              temp3.style.display='none';
              break;
          case 2:
              page[0].style.backgroundColor='';
              page[1].style.backgroundColor='';
              page[2].style.backgroundColor='rgba(133,133,133,0.5)';
              temp.style.display='none';
              temp2.style.display='none';
              temp3.style.display='';
              break;
      }
  }
  onMounted(() => {
      switch_page(0);
  });
  </script>
  
  <style scoped>
  /*开始倒序编辑*/
  .ill_page{
      width:90%;
      height: auto;
      margin:5px auto;
      display: flex;
      flex-direction: column;
  }
  .novel_page{
      width:90%;
      height: auto;
      margin:5px auto;
      display: flex;
      flex-direction: column;
  }
  .invited_draft{
      width:90%;
      height: auto;
      margin:5px auto;
      display: flex;
      flex-direction: column;
  }
  .btn_box{
      display: flex;
      width:90%;
      margin:5px auto;
      justify-content: flex-end;
      align-items: center;
      margin-top:15px;
      border-top:1px solid #9e9d9d;
  }
  .save_btn{
      display: flex;
      padding-left: 15px;
      padding-right: 15px;
      padding-top:5px;
      padding-bottom: 5px;
      border-radius: 15px;
      justify-content: center;
      align-items: center;
      cursor: pointer;
      background-color: rgba(0,150,250,1);
      color: #fff;
      font-size: 16px;
      font-weight: bold;
      margin-top:10px;
  }
  .save_btn:hover,.cancel_btn:hover{
      opacity: 0.6;
      transition: all 0.3s ease-in-out;
  }
  .cancel_btn{
      display: flex;
      padding-left: 15px;
      padding-right: 15px;
      padding-top:5px;
      padding-bottom: 5px;
      border-radius: 15px;
      justify-content: center;
      align-items: center;
      margin-left: 10px;
      cursor: pointer;
      background-color: rgba(133,133,133,0.5);
      color: #fff;
      font-size: 16px;
      font-weight: bold;
      margin-top: 10px;
  }
  .item_img{
      width:150px;
      height: 200px;
      display: flex;
      justify-content: center;
      align-items: center;
      border-radius: 10px;
      overflow: hidden;
  }
  .item_img img{
      width:100%;
      height: 100%;
      object-fit: cover; 
  }
  /*结束*/
  .chose_project {
      display: flex;
      width: 100vw;
      height: 100vh;
      justify-content: center;
      align-items: center;
      position: fixed;
      top: 0;
      left: 0;
      background-color: rgba(0, 0, 0, 0.5);
      z-index: 10;
      overflow: auto;
  }
  .content_box {
      display: flex;
      width:550px;
      height: auto;
      flex-direction: column;
      border-radius: 15px;
      background-color: #fff;
      box-shadow: 0 0 10px rgba(255, 255, 255, 0.3);
      padding:10px;
  }
  .title_box {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin:10px auto;
      width:100%;
  }
  .close_btn {
      width:35px;
      height: 35px;
      display: flex;
      justify-content: center;
      align-items: center;
      margin-right: 10px;
  }
  .close_btn:hover{
      cursor: pointer;
      background-color: rgba(133,133,133,0.6);
      border-radius: 50%;
      overflow: hidden;
      transition: all 0.3s ease-in-out;
  }
  .close_btn img{
      width:25px;
      height: 25px;
      object-fit: cover;
  }
  .switch_tag{
      display: flex;
      width:90%;
      margin:5px auto;
      justify-content: center;
      align-items: center;
  }
  .tag_item{
      display: flex;
      padding-left:15px;
      padding-right: 15px;
      padding-top:5px;
      padding-bottom: 5px;
      border-radius: 15px;
      justify-content: center;
      align-items: center;
      border-radius: 15px;
      margin-left:5px;
      margin-right: 5px;
  }
  .tag_item:hover{
      cursor:pointer;
      background-color: rgba(133,133,133,0.1);
      transition: all 0.3s ease-in-out;
  }
  </style>
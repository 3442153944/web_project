<script setup>
import { ref,defineProps,onMounted } from 'vue'
import send_msg_box from './model/send_msg_box.vue';
import msg_box from './model/msg_box/msg_box.vue';
import { get_comment } from './js/get_comment';
let props=defineProps({
  work_type:{
      type:String,
      default:'ill'
    },
    work_id:{
      type:String,
      default:'1'
    },
    is_main_comment:{
      type:Boolean,
      default:true,
    },
    is_reply:{
      type:Boolean,
      default:false
    },
    send_userid:{
      type:String,
      default:'aaa'
    },
    main_comment_id:{
      type:String,
      default:'1'
    },
    replay_comment_id:{
      type:String,
      default:'1'
    }
})
//接收评论消息
function receive_msg(msg){
  console.log(msg)
}
//获取服务器评论消息
let comment_list=ref('')
onMounted(async ()=>{
  comment_list.value=await get_comment(1,'ill','sunyuanling')
  console.log(comment_list.value)
})
</script>

<template>
<div class="index">
  <div class="title">
    <span>评论</span>
  </div>
  <div class="content">
    <send_msg_box @send_msg="receive_msg"></send_msg_box>
    <msg_box :comments="comment_list"></msg_box>
  </div>
</div>
</template>

<style scoped>
.index{
  width: 100%;
  height: auto;
  display: flex;
  flex-direction: column;
  gap: 10px;
  border-top: 1px solid rgba(133,133,133,1);
}
</style>

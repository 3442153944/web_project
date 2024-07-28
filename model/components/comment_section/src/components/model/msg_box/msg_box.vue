<template>
    <div class="comments-section">
      <div v-for="item in comments" :key="item.comment_id" class="msg_box">
        <div class="content" :class="item.is_main ? '' : 'is_reply'">
          <div class="user_info">
            <div class="avatar">
              <img :src="'https://www.sunyuanling.com/image/avatar_thumbnail/'+item.user_avatar" alt="avatar">
            </div>
          </div>
          <div class="msg_content">
            <div class="username">
              <span>{{ item.username }}</span>
            </div>
            <div class="msg_text">
              <span>{{ item.msg_content }}</span>
            </div>
            <div class="msg_time">
              <span>{{ item.time }}</span>
              <span class="reply_btn" @click="toggleReplyBox(item.comment_id)">回复</span>
            </div>
            <div class="reply_box" v-if="replyBoxVisible[item.comment_id]">
              <send_msg_box :user_avatar_path="item.user_avatar" @send_msg="handleSendMsg(item.comment_id)"></send_msg_box>
            </div>
            <!-- 渲染子评论 -->
            <div v-if="item.replies.length > 0">
              <div v-for="reply in item.replies" :key="reply.comment_id" class="msg_box is_reply">
                <div class="content">
                  <div class="user_info">
                    <div class="avatar">
                      <img :src="'https://www.sunyuanling.com/image/avatar_thumbnail/'+reply.user_avatar" alt="avatar">
                    </div>
                  </div>
                  <div class="msg_content">
                    <div class="username">
                      <span>{{ reply.username }}</span>
                    </div>
                    <div class="msg_text">
                      <span>{{ reply.msg_content }}</span>
                    </div>
                    <div class="msg_time">
                      <span>{{ reply.time }}</span>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </template>
  
  <script setup>
  import { ref ,defineProps,defineEmits} from 'vue';
  import send_msg_box from '../send_msg_box.vue';
  
  const props = defineProps({
    comments: {
      type: Array,
      default: () => []
    }
  });
  
  const replyBoxVisible = ref({}); // 用于跟踪哪个评论的回复框是可见的
  
  function toggleReplyBox(commentId) {
    replyBoxVisible.value[commentId] = !replyBoxVisible.value[commentId];
  }
  
  function handleSendMsg(commentId, msg) {
    // 处理发送消息的逻辑，并可能更新评论列表
  }
  </script>
  
  <style scoped>
  /* 添加你的样式 */
  .is_reply {
    margin-left: 50px;
  }
  
  .comments-section {
    display: flex;
    flex-direction: column;
    gap: 10px;
  }
  
  .msg_box {
    display: flex;
    flex-direction: row;
    gap: 10px;
    width: 100%;
    height: 100%;
    align-items: center;
    overflow: hidden;
  }
  
  .content {
    display: flex;
    flex-direction: row;
    gap: 10px;
    width: 100%;
    height: 100%;
  }
  
  .user_info {
    display: flex;
    width: 50px;
    height: 50px;
    align-items: center;
    justify-content: center;
  }
  
  .avatar {
    width: 50px;
    height: 50px;
  }
  
  .avatar img {
    width: 100%;
    height: 100%;
    border-radius: 50%;
    object-fit: cover;
  }
  
  .msg_content {
    display: flex;
    flex-direction: column;
    gap: 5px;
    width: 100%;
    height: 100%;
    align-items: flex-start;
  }
  
  .username {
    font-size: 16px;
    font-weight: bold;
  }
  
  .msg_text {
    font-size: 14px;
  }
  
  .msg_time {
    font-size: 12px;
    display: flex;
    flex-direction: row;
    align-items: center;
    gap: 15px;
  }
  
  .reply_box {
    display: flex;
    width: 100%;
    height: 100%;
    min-width: 150px;
  }
  
  .reply_btn {
    display: flex;
    width: auto;
    height: auto;
    padding: 5px;
    cursor: pointer;
    color: rgba(0,150,250,1);
  }
  
  .reply_btn:hover {
    opacity: 0.6;
    transition: all 0.3s;
  }
  </style>
  
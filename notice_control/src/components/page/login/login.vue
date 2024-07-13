<template>
  <div class="login">
    <div class="login_box">
      <div class="userid">
        <input id="userid" v-model="userid" type="text" placeholder="请输入用户ID" />
      </div>
      <div class="password">
        <input id="password" v-model="password" type="password" placeholder="请输入密码" />
      </div>
      <div class="login_btn">
        <span @click="login">登录</span>
      </div>
      <div v-if="loading" class="loading">正在登录...</div>
      <div v-if="error" class="error">{{ error }}</div>
    </div>
  </div>
</template>


<script>
import { ref, reactive, toRefs, watch, onMounted, onUnmounted,defineEmits } from 'vue';
import * as cookies from '../../../../../model/cookies.js'
export default {
  name: 'login',
}
</script>

<script setup>
const userid = ref('');
const password = ref('');
const token = ref('');
const loading = ref(false);
const error = ref('');
const emit = defineEmits(['login']);

function close() {
  emit('login', false);
}

async function login() {
  loading.value = true;
  error.value = '';
  try {
    const res = await fetch('https://www.sunyuanling.com/api/notice_control/ControlNoticeLogin/', {
      method: 'post',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        userid: userid.value,
        password: password.value,
        token: null,
      }),
    });

    const data = await res.json();
    if (res.ok && data.status === 'success') {
      alert('登录成功');
      // 设置新token
      cookies.set_cookie('token', data.token);
      close();
    } else {
      error.value = data.message || '登录失败，请重试';
      console.log(data.message);
    }
  } catch (e) {
    error.value = '网络错误，请稍后重试';
  } finally {
    loading.value = false;
  }
}

</script>


<style scoped>
.login {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  width: 100vw;
  position:fixed;
  z-index: 100;
  background-color: #f5f5f5;
}

.login_box {
  background: #fff;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  width: 300px;
}

.userid,
.password {
  margin-bottom: 15px;
}

input {
  width: 100%;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 4px;
}

.login_btn {
  text-align: center;
}

.login_btn span {
  background-color: #007bff;
  color: #fff;
  padding: 10px 20px;
  border-radius: 4px;
  cursor: pointer;
}

.login_btn span:hover {
  background-color: #0056b3;
}

.loading,
.error {
  margin-top: 15px;
  text-align: center;
}

.loading {
  color: #007bff;
}

.error {
  color: #ff0000;
}
  
</style>
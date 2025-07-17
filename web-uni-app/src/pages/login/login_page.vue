<template>
  <view class="login-container">
    <!-- 顶部Logo (可选) -->
    <image 
      class="logo" 
      src="/static/favicon.png" 
      mode="aspectFit"
    />

    <!-- 登录表单 -->
    <view class="form-box">
      <text class="title">用户登录</text>
      
      <input 
        class="input"
        type="text" 
        placeholder="请输入手机号/邮箱" 
        v-model="loginKey"
        @focus="resetError"
      />
      
      <input 
        class="input"
        type="password" 
        placeholder="请输入密码" 
        v-model="password"
        @focus="resetError"
      />

      <!-- 错误提示 -->
      <text v-if="error" class="error-msg">{{ error }}</text>

      <!-- 登录按钮 -->
      <button 
        class="login-btn"
        :disabled="isLoading"
        @click="handleLogin"
      >
        {{ isLoading ? '登录中...' : '登录' }}
      </button>

      <!-- 辅助功能 (忘记密码/注册) -->
      <view class="actions">
        <text @click="gotoForgotPassword">忘记密码</text>
        <text @click="gotoRegister">注册账号</text>
      </view>
    </view>

    <!-- 第三方登录 (可选) -->
    <view class="third-party">
      <text>其他登录方式</text>
      <view class="icons">
        <image src="/static/微信.svg" @click="wechatLogin" />
        <image src="/static/QQ.svg" @click="qqLogin" />
      </view>
    </view>
  </view>
</template>

<script setup>
import { ref } from 'vue'
import { onLoad, onShow } from '@dcloudio/uni-app'
import BaseApi from '../../BaseApi'
import { useStore } from '@/store'

const store=useStore()

const loginKey = ref('')
const password = ref('')
const error = ref('')
const isLoading = ref(false)

const resetError = () => error.value = ''

const handleLogin = async () => {
  if (!loginKey.value.trim()) {
    error.value = '请输入账号'
    return
  }
  if (!password.value.trim()) {
    error.value = '请输入密码'
    return
  }

  isLoading.value = true
  try {
    const res = await BaseApi.post('login/', {
      login_key: loginKey.value,
      password: password.value
    })
    console.log(res)
    if (res.code === 200) {
      uni.setStorageSync('token', res.token)
      uni.showToast({ title: '登录成功', icon: '../../static/正确.svg' })
      const user_info=await BaseApi.getUserInfo();
      if(user_info){
        console.log(user_info)
        store.$state.user_info=user_info;
      }
      console.log('store内容：',store.$state.user_info)
      setTimeout(() => {
        uni.switchTab({ url: '/pages/index/index' })
      }, 1500)
    } else {
      error.value = res.msg || '登录失败'
    }
  } catch (e) {
    error.value = '网络异常，请重试'
    console.error('登录失败:', e)
  } finally {
    isLoading.value = false
  }
}

// 辅助功能跳转
const gotoForgotPassword = () => uni.navigateTo({ url: '/pages/forgot/forgot' })
const gotoRegister = () => uni.navigateTo({ url: '/pages/register/register' })

// 第三方登录
const wechatLogin = () => console.log('微信登录')
const qqLogin = () => console.log('QQ登录')
</script>

<style lang="scss" scoped>
.login-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  min-height: 100vh;
  padding: 40rpx;
  background: #f8f8f8;

  .logo {
    width: 200rpx;
    height: 200rpx;
    margin: 60rpx 0;
  }

  .form-box {
    width: 100%;
    background: #fff;
    border-radius: 16rpx;
    padding: 40rpx;
    box-shadow: 0 4rpx 12rpx rgba(0, 0, 0, 0.05);

    .title {
      display: block;
      font-size: 36rpx;
      font-weight: bold;
      text-align: center;
      margin-bottom: 40rpx;
      color: #333;
    }

    .input {
      width: 100%;
      height: 90rpx;
      padding: 0 20rpx;
      margin-bottom: 30rpx;
      border: 1rpx solid #eee;
      border-radius: 8rpx;
      font-size: 28rpx;
      background: #f9f9f9;

      &:focus {
        border-color: #007aff;
      }
    }

    .error-msg {
      display: block;
      color: #ff4d4f;
      font-size: 24rpx;
      margin: -10rpx 0 20rpx;
      text-align: center;
    }

    .login-btn {
      width: 100%;
      height: 90rpx;
      line-height: 90rpx;
      background: #007aff;
      color: #fff;
      font-size: 32rpx;
      border-radius: 8rpx;
      margin-top: 20rpx;

      &[disabled] {
        background: #bae0ff;
      }
    }

    .actions {
      display: flex;
      justify-content: space-between;
      margin-top: 30rpx;
      font-size: 26rpx;
      color: #666;

      text {
        &:active {
          color: #007aff;
        }
      }
    }
  }

  .third-party {
    margin-top: 80rpx;
    text-align: center;
    font-size: 26rpx;
    color: #999;

    .icons {
      display: flex;
      justify-content: center;
      margin-top: 20rpx;

      image {
        width: 80rpx;
        height: 80rpx;
        margin: 0 30rpx;
      }
    }
  }
}

/* 响应式适配 */
@media (min-width: 768px) {
  .form-box {
    max-width: 500rpx;
  }
}
</style>
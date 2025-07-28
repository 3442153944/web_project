<!-- components/FloatNavBar.vue -->
<template>
  <view class="float-navbar" :class="{ 'navbar-scrolled': isScrolled }">
    <!-- 返回按钮 -->
    <view
      class="nav-btn"
      @click="onBack"
      @touchstart="setActive('back')"
      @touchend="clearActive"
      :class="{ active: activeBtn === 'back' }"
    >
      <image :src="backIcon" mode="aspectFit" class="icon" />
    </view>

    <!-- 分享按钮 -->
    <view
      class="nav-btn"
      @click="showActionSheet"
      @touchstart="setActive('share')"
      @touchend="clearActive"
      :class="{ active: activeBtn === 'share' }"
    >
      <image :src="shareIcon" mode="aspectFit" class="icon" />
    </view>
  </view>

  <!-- 原生实现动作面板 -->
  <view v-if="showAction" class="action-sheet-mask" @click="hideActionSheet">
    <view class="action-sheet" @click.stop>
      <view class="action-item" v-for="(item, index) in actionList" :key="index" :style="{ color: item.color }" @click="handleAction(index)">
        {{ item.text }}
      </view>
      <view class="cancel-btn" @click="hideActionSheet">取消</view>
    </view>
  </view>
</template>

<script setup>
import { ref } from 'vue'
import backIcon from '@/assets/返回.svg'
import shareIcon from '@/assets/分享.svg'

const emit = defineEmits(['back'])

const activeBtn = ref(null)
const isScrolled = ref(false)
const showAction = ref(false)

const setActive = btn => (activeBtn.value = btn)
const clearActive = () => (activeBtn.value = null)

const onBack = () => {
    uni.navigateBack()
}
const showActionSheet = () => (showAction.value = true)
const hideActionSheet = () => (showAction.value = false)

const actionList = [
  { text: '微信分享', color: '#07c160' },
  { text: '朋友圈分享', color: '#07c160' },
  { text: '复制链接', color: '#333' }
]

const handleAction = (index) => {
  hideActionSheet()
  const actions = [
    () => console.log('微信分享'),
    () => console.log('朋友圈分享'),
    () => uni.setClipboardData({ data: 'https://example.com' })
  ]
  actions[index]?.()
}
</script>

<style lang="scss" scoped>
.float-navbar {
  position: fixed;
  top: 0;
  left: 0;
  width: calc(100% - 32px);
  padding: 12px 16px;
  display: flex;
  justify-content: space-between;
  background: transparent;
  z-index: 999;
  transition: all 0.3s ease;

  &.navbar-scrolled {
    background: rgba(255, 255, 255, 0.9);
    backdrop-filter: blur(4px);
  }

  .nav-btn {
    width: 44px;
    height: 44px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;

    .icon {
      width: 24px;
      height: 24px;
      opacity: 0.8;
      transition: all 0.2s ease;
    }

    @media (hover: hover) {
      &:hover {
        background: rgba(0, 0, 0, 0.05);
        .icon {
          opacity: 1;
          transform: scale(1.1);
        }
      }
    }

    &.active {
      background: rgba(0, 0, 0, 0.1);
      .icon {
        opacity: 1;
        transform: scale(0.95);
      }
    }
  }
}

.action-sheet-mask {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.4);
  z-index: 9999;
  display: flex;
  justify-content: center;
  align-items: flex-end;
}

.action-sheet {
  width: 100%;
  background: #fff;
  border-top-left-radius: 12px;
  border-top-right-radius: 12px;
  padding-bottom: env(safe-area-inset-bottom); // iOS 兼容
  overflow: hidden;
}

.action-item {
  padding: 16px;
  text-align: center;
  border-bottom: 1px solid #f0f0f0;
  font-size: 16px;
}

.cancel-btn {
  padding: 16px;
  text-align: center;
  color: #666;
  font-weight: bold;
  font-size: 16px;
}
</style>

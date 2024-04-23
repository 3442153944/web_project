<template>
    <div class="container">
      <button @click="animateSlider">Slide Up</button>
      <div class="slider" :style="{ opacity: sliderOpacity, transform: `translateY(${sliderPosition}px)` }"></div>
    </div>
  </template>
  
  <script setup>
  import { ref } from 'vue';
  
  const sliderPosition = ref(0);
  const sliderOpacity = ref(1);
  
  const animateSlider = () => {
    // 设置滑块初始位置
    sliderPosition.value = 0;
    
    // 设置滑块初始不透明度
    sliderOpacity.value = 1;
  
    // 开始滑动动画
    const animationInterval = setInterval(() => {
      sliderPosition.value += 5; // 向上滑动
      sliderOpacity.value -= 0.1; // 逐渐变淡
  
      // 如果滑块超出了可见区域或透明度变为0，则停止动画
      if (sliderPosition.value >= 100 || sliderOpacity.value <= 0) {
        clearInterval(animationInterval);
      }
    }, 50); // 设置动画速度
    sliderPosition.value = 0;
  };
  </script>
  
  <style scoped>
  .container {
    display: flex;
    flex-direction: column;
    align-items: center;
  }
  
  .slider {
    width: 100px;
    height: 20px;
    background-color: blue;
    margin-top: 20px;
    transition: transform 0.5s ease, opacity 0.5s ease; /* 添加过渡效果 */
  }
  </style>
  
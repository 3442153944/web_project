<script setup lang="ts">
import rootpage from './components/rootpage.vue';
import { ref, onMounted } from 'vue';
let cursor_top = ref(0);
let cursor_left = ref(0);
let cursor_apactiy = ref(0);
let cursor_add = ref(0);
onMounted(() => {
    //获取鼠标坐标
    document.onmousemove = (e) => {
        cursor_top.value = e.clientY;
        cursor_left.value = e.clientX + 20;
        cursor_apactiy.value = 1;
        cursor_add.value = 0;
    }
    //鼠标点击事件
    document.onmousedown = (e) => {
        cursor_apactiy.value = 1;
        cursor_add.value = 0;
        const intervalId = setInterval(() => {
            cursor_apactiy.value -= 0.05;
            cursor_add.value -= 2;
            if (cursor_apactiy.value <= 0) {
                clearInterval(intervalId);
            }
        }, 50);
    }
})
</script>

<template>
    <div class="cursor_action"
    :style="{ top: cursor_top + 'px', left: cursor_left + 'px', opacity: cursor_apactiy, transform: `translateY(${cursor_add}px)` }">
        <img src="https://127.0.0.1:4434/assets/cat.svg">
        <span>喵喵喵~</span>
    </div>
<rootpage></rootpage>
</template>

<style scoped>
.cursor_action {
    position: fixed;
    color: #f889fc;
    opacity: 0;
    width: 90px;
    z-index: 100;
    pointer-events: none;
}

.cursor_action img {
    width: 20px;
    height: 20px;
    object-fit: cover;
}
</style>

<template>
    <div class="slider-container">
        <button class="nav-btn left-btn" @click="scroll(-1)">
            <img :src="left_btn" alt="向左滑动">
        </button>

        <div class="slider-wrapper" ref="sliderWrapper">
            <div class="slider-track" :style="trackStyle" ref="sliderTrack" @transitionend="onTransitionEnd">
                <div v-for="(item, index) in list" :key="index" class="slide-item" @click="handleItemClick(item)">

                    <!-- 文本内容 -->
                    <div v-if="type === 'text'" class="text-content" :style="{
                        backgroundColor: getRandomColor(),
                        color: 'white',
                        borderRadius: '50%',
                        padding: '10px 20px'
                    }">
                        {{ item }}
                    </div>

                    <!-- 图片内容 -->
                    <div v-else-if="type === 'image'" class="media-content">
                        <img :src="item.url" :alt="item.alt || ''">
                        <div v-if="item.author" class="meta-info">
                            <span class="author">作者: {{ item.author }}</span>
                        </div>
                    </div>

                    <!-- 视频内容 -->
                    <div v-else-if="type === 'video'" class="media-content">
                        <video controls>
                            <source :src="item.url" :type="item.mimeType || 'video/mp4'">
                        </video>
                        <div v-if="item.author" class="meta-info">
                            <span class="author">作者: {{ item.author }}</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <button class="nav-btn right-btn" @click="scroll(1)">
            <img :src="right_btn" alt="向右滑动">
        </button>
    </div>
</template>

<script setup>
import { ref, computed, onMounted, onBeforeUnmount } from 'vue'

const props = defineProps({
    type: {
        type: String,
        required: true,
        validator: value => ['text', 'image', 'video'].includes(value)
    },
    list: {
        type: Array,
        required: true
    },
    left_btn: {
        type: String,
        default: 'https://www.sunyuanling.com/assets/left.svg'
    },
    right_btn: {
        type: String,
        default: 'https://www.sunyuanling.com/assets/right.svg'
    },
    duration: {
        type: Number,
        default: 1000
    }
})

const emit = defineEmits(['item-click'])
const colorArr = ref([
    'rgb(126, 183, 200)', 'rgb(126, 186, 200)', 'rgb(157, 200, 126)', 'rgb(200, 126, 170)', 'rgb(200, 126, 146)',
    'rgb(126, 129, 200)', 'rgb(167, 126, 200)', 'rgb(200, 170, 126)', 'rgb(126, 200, 167)', 'rgb(126, 200, 129)'
])

const sliderWrapper = ref(null)
const sliderTrack = ref(null)
const currentIndex = ref(0)
const isTransitioning = ref(false)
const itemWidth = ref(0)
const wrapperWidth = ref(0)

const trackStyle = computed(() => ({
    transform: `translateX(-${currentIndex.value * itemWidth.value}px)`,
    transition: isTransitioning.value ? `transform ${props.duration}ms cubic-bezier(0.25, 0.1, 0.25, 1)` : 'none'
}))

// 获取随机颜色
const getRandomColor = () => {
    const randomIndex = Math.floor(Math.random() * colorArr.value.length)
    return colorArr.value[randomIndex]
}

onMounted(() => {
    updateDimensions()
    window.addEventListener('resize', updateDimensions)
})

onBeforeUnmount(() => {
    window.removeEventListener('resize', updateDimensions)
})

function updateDimensions() {
    if (sliderWrapper.value) {
        wrapperWidth.value = sliderWrapper.value.offsetWidth
        itemWidth.value = wrapperWidth.value
        sliderTrack.value.style.width = `${itemWidth.value * props.list.length}px`
    }
}

function scroll(direction) {
    if (isTransitioning.value) return

    const newIndex = currentIndex.value + direction

    // 边界检查
    if (newIndex < 0 || newIndex >= props.list.length) {
        return
    }

    isTransitioning.value = true
    currentIndex.value = newIndex
}

function onTransitionEnd() {
    isTransitioning.value = false
}

function handleItemClick(item) {
    emit('item-click', item)
}
</script>

<style scoped lang="scss">
.slider-container {
    position: relative;
    display: flex;
    align-items: center;
    width: 100%;
    max-width: 1200px;
    margin: 0 auto;
}

.slider-wrapper {
    flex: 1;
    overflow: hidden;
    position: relative;
}

.slider-track {
    display: flex;
    height: 100%;
    will-change: transform;
}

.slide-item {
    flex: 0 0 auto;
    width: 100%;
    padding: 10px;
    box-sizing: border-box;
    cursor: pointer;
    transition: transform 0.2s;

    &:hover {
        transform: scale(1.02);
    }
}

.text-content {
    display: flex;
    align-items: center;
    justify-content: center;
    min-height: 120px;
    font-size: 1.2rem;
    text-align: center;
    word-break: break-word;
    transition: all 0.3s ease;

    &:hover {
        transform: scale(1.05);
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    }
}

.media-content {
    position: relative;
    height: 0;
    padding-bottom: 56.25%;
    /* 16:9 比例 */
    overflow: hidden;
    border-radius: 8px;
    background: #000;

    img,
    video {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        object-fit: contain;
    }
}

.meta-info {
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    padding: 10px;
    background: rgba(0, 0, 0, 0.6);
    color: white;
    font-size: 0.9rem;
}

.nav-btn {
    background: none;
    border: none;
    cursor: pointer;
    padding: 10px;
    transition: transform 0.2s;
    z-index: 10;

    &:hover {
        transform: scale(1.2);
    }

    &:disabled {
        opacity: 0.5;
        cursor: not-allowed;
    }

    img {
        width: 40px;
        height: 40px;
    }
}

.left-btn {
    margin-right: 15px;
}

.right-btn {
    margin-left: 15px;
}
</style>
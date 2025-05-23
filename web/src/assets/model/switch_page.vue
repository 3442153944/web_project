<template>
    <div class="menu-container">
        <div class="menu">
            <div 
                v-for="(item, index) in menuItems" 
                :key="index"
                :class="['menu-item', { 'is-active': now_page === index }]"
                @click="switchPage(index)"
            >
                <span class="menu-text">{{ item.label }}</span>
                <div class="indicator"></div>
            </div>
        </div>
    </div>
</template>

<script setup>
import { computed } from 'vue'
import { useRouter } from 'vue-router'
import { useStore } from './store'

const router = useRouter()
const store = useStore()

const menuItems = [
    { label: '插画', path: '/' },
    { label: '漫画', path: '/comic' },
    { label: '小说', path: '/novel' }
]

const now_page = computed(() => store.$state.now_page)

const switchPage = (index) => {
    store.$state.now_page = index
    router.push(menuItems[index].path)
}
</script>

<style scoped lang="scss">
.menu-container {
    width: 100%;
    background-color: #f8f9fa;
    padding: 0.5rem 0;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.menu {
    display: flex;
    justify-content: center;
    gap: 1px;
    max-width: 800px;
    margin: 0 auto;
    background-color: #e9ecef;
    border-radius: 50px;
    padding: 2px;
    position: relative;
}

.menu-item {
    flex: 1;
    text-align: center;
    padding: 12px 20px;
    cursor: pointer;
    position: relative;
    transition: all 0.3s ease;
    z-index: 1;
    border-radius: 50px;
    
    &:hover {
        background-color: rgba(0, 150, 250, 0.1);
        
        .menu-text {
            color: #fff;
        }
    }
}

.menu-text {
    position: relative;
    font-weight: 500;
    color: #495057;
    transition: color 0.3s ease;
    z-index: 2;
}

.is-active {
    .menu-text {
        color: white;
        font-weight: 600;
    }
    
    .indicator {
        opacity: 1;
        transform: scaleX(1);
    }
}

.indicator {
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    top: 0;
    background-color: #007bff;
    border-radius: 50px;
    z-index: -1;
    opacity: 0;
    transform: scaleX(0.8);
    transform-origin: center;
    transition: all 0.4s cubic-bezier(0.68, -0.55, 0.265, 1.55);
    box-shadow: 0 4px 12px rgba(0, 150, 250, 0.2);
}

/* 响应式调整 */
@media (max-width: 600px) {
    .menu {
        border-radius: 30px;
    }
    
    .menu-item {
        padding: 10px 15px;
        font-size: 14px;
    }
}

@media (max-width: 400px) {
    .menu-item {
        padding: 8px 12px;
        font-size: 13px;
    }
}
</style>
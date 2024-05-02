<template>
    <div class="work_title_list">
        <div class="show_list_btn" @click="show_list_btn">
            <span>目录</span>
        </div>
        <transition name="fade">
            <div class="title_list" v-show="show_list">
                <div class="title_item" v-for="(item, index) in title_list" :key="index">
                    <span>{{ item }}</span>
                </div>
            </div>
        </transition>
    </div>
</template>

<script>
import { ref, reactive, toRefs, watch, onMounted, onUnmounted } from 'vue';
export default {
    name: 'work_title_list',
}
</script>

<script setup>
let show_list = ref('true');
let title_list = ref([
    '第一章',
    '第二章',
    '第三章',
    '第四章',
    '第五章',
    '第六章',
    '第七章',
    '第八章',
    '第九章',
    '第十章',
    '第十一章',
    '第十二章',
    '第十三章',
    '第十四章',
    '第十五章',
    '第十六章',
    '第十七章',
    '第十八章',
    '第十九章',
    '第二十章',
    '第二十一章',
    '第二十二章',
    '第二十三章',
    '第二十四章',
    '第二十五章',
    '第二十六章',
    '第二十七章',
    '第二十八章',
    '第二十九章',
    '第三十章',
    '第三十一章',
    '第三十二章',
    '第三十三章',
    '第三十四章',
    '第三十五章',
    '第三十六章',
    '第三十七章',
    '第三十八章',
]);

function show_list_btn() {
    show_list.value = !show_list.value;
}
</script>

<style scoped>
/*动画效果*/
.fade-enter-active,
.fade-leave-active {
    transition: opacity 0.2s;
}

.fade-enter,
.fade-leave-to {
    opacity: 0;
}

.work_title_list {
    display: flex;
    flex-direction: column;
    width: auto;
    height: auto;
    z-index: 1;
    background-color: rgba(211, 211, 211, 1);
    padding: 5px;
    border-radius: 10px;
    position: fixed;
}

.show_list_btn {
    display: flex;
    width: 60px;
    height: 20px;
    justify-content: center;
    align-items: center;
    background-color: rgba(243, 243, 243, 1);
    padding: 5px;
    border-radius: 10px;
    z-index: 2;
}

.show_list_btn:hover {
    cursor: pointer;
    transition: 0.2s;
    opacity: 0.6;
}

.title_list {
    display: flex;
    width: 40vw;
    height: auto;
    overflow: auto;
    padding: 5px;
    margin-top: 5px;
    border: 1px solid red;
    background-color: rgba(211, 211, 211, 0.8);
    flex-wrap: wrap;
    max-height: 70vh;
}

.title_item {
    display: flex;
    width: 45%;
    height: 30px;
    border: 1px solid red;
    border-bottom: 1px solid rgba(255, 255, 255, 1);
    background-color: rgb(233, 233, 233);
    justify-content: center;
    align-items: center;
    text-align: center;
    margin-left: 10px;
    margin-top: 5px;
}

.title_item:hover {
    cursor: pointer;
    transition: 0.2s;
    opacity: 0.8;
}

.title_item span {
    display: flex;
    width: 100%;
    height: 100%;
    justify-content: center;
    align-items: center;
}
</style>
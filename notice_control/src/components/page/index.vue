<template>
    <div class="index">
        <notice_head></notice_head>
        <div class="content">
            <div class="content-left">
                <div class="item-box" @click="currentComponent = 'add_notice'">
                    <span>新增公告</span>
                </div>
                <div class="item-box" @click="currentComponent = 'delete_notice'">
                    <span>删除公告</span>
                </div>
                <div class="item-box" @click="currentComponent = 'modify_notice'">
                    <span>修改公告</span>
                </div>
                <div class="item-box" @click="currentComponent = 'show_all_notice'">
                    <span>公告列表</span>
                </div>
            </div>
            <div class="content-right">
                <component :is="currentComponent"></component>
            </div>
        </div>
    </div>
</template>
<script>
import { ref } from 'vue';
import notice_head from './head.vue';
import add_notice from './add_notice.vue';
import delete_notice from './delete_notice.vue';
import modify_notice from './modify_notice.vue';
import show_all_notice from './show_all_notice.vue';
export default {
    components: {
        notice_head,
        add_notice,
        delete_notice,
        modify_notice,
        show_all_notice,
    }
}
</script>
<script setup>
let currentComponent = ref('show_all_notice');
</script>

<style scoped>
.index {
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column;
    align-items: center;
}

.content {
    display: flex;
    width: 100%;
}

.content-left {
    display: flex;
    flex-direction: column;
    width: 20%;
    background-color: #f8f9fa;
    padding: 10px;
    box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
}

.item-box {
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 15px;
    margin: 5px 0;
    background-color: #ffffff;
    border: 1px solid #e0e0e0;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s, transform 0.3s;
}

.item-box:hover {
    background-color: #e0e0e0;
    transform: scale(1.02);
}

.content-right {
    display: flex;
    flex-grow: 1;
    padding: 20px;
}
</style>
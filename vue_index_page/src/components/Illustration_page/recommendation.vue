<template>
    <div class="recommendation">
        <h3>推荐作品</h3>
        <div class="work_box_list">
            <div class="work_box" v-for="index in 17" :key="index">
                <div class="work_item" >
                    <div class="age_tag"><span>{{ work_item_age }}</span></div>
                    <div class="page_count">
                        <svg t="1715784414381" class="icon" viewBox="0 0 1024 1024" version="1.1"
                            xmlns="http://www.w3.org/2000/svg" p-id="9622" width="200" height="200">
                            <path
                                d="M819.2 128H409.6c-56.32 0-102.4 46.08-102.4 102.4v409.6c0 56.32 46.08 102.4 102.4 102.4h409.6c56.32 0 102.4-46.08 102.4-102.4V230.4c0-56.32-46.08-102.4-102.4-102.4z m51.2 512c0 28.16-23.04 51.2-51.2 51.2H409.6c-28.16 0-51.2-23.04-51.2-51.2V230.4c0-28.16 23.04-51.2 51.2-51.2h409.6c28.16 0 51.2 23.04 51.2 51.2v409.6z m-204.8 204.8c0 28.16-23.04 51.2-51.2 51.2H204.8c-28.16 0-51.2-23.04-51.2-51.2V435.2c0-28.16 23.04-51.2 51.2-51.2h51.2v-51.2H204.8c-56.32 0-102.4 46.08-102.4 102.4v409.6c0 56.32 46.08 102.4 102.4 102.4h409.6c56.32 0 102.4-46.08 102.4-102.4v-51.2h-51.2v51.2z"
                                fill="#fff" p-id="9623"></path>
                        </svg>
                        <span>{{ work_item_page_count }}</span>
                    </div>
                    <img :src="work_item_path">
                </div>
                <div class="work_title">
                    <span>{{ work_item_title }}</span>
                </div>
                <div class="user_info">
                    <div class="user_avatar">
                        <img :src="work_item_user_avatar">
                    </div>
                    <div class="username">
                        <span>{{ work_item_user_name }}</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import { ref, onMounted, onUnmounted, watch } from 'vue';
export default {
    name: "recommendation",
};
</script>

<script setup>
let work_item_path = ref('https://www.sunyuanling.com/image/thumbnail/105716156_p0.jpg');
let work_item_age = ref('R-18');
let work_item_page_count = ref('12');
let work_item_title = ref('作品标题');
let work_item_user_avatar = ref('https://www.sunyuanling.com/image/87328997_p0.jpg');
let work_item_user_name = ref('用户名');
</script>

<style scoped>
.recommendation {
    width: 100%;
    height: auto;
    margin-top: 30px;
    padding: 5px;
    margin-left: auto;
    margin-right: auto;
}

.work_box_list {
    display: flex;
    width: 100%;
    height: auto;
    flex-wrap: wrap;
}

.work_box {
    display: flex;
    flex-direction: column;
    width: 150px;
    height: 230px;
    margin: 20px 15px;
    min-height: 230px;
}

.work_item {
    display: flex;
    width: 100%;
    height: 80%;
    position: relative;
    overflow: hidden;
    border-radius: 15px;
    min-height: 183px;
}

.work_item img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.age_tag {
    position: absolute;
    left: 5px;
    top: 5px;
    width: 40px;
    height: 20px;
    background-color: red;
    color: white;
    border-radius: 5px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 12px;
    font-weight: bold;
}

.page_count {
    display: flex;
    position: absolute;
    right: 5px;
    top: 5px;
    width: 40px;
    height: 20px;
    background-color: rgba(211, 211, 211, 0.8);
    color: white;
    border-radius: 5px;
    justify-content: center;
    align-items: center;
    font-size: 12px;
}

.page_count svg {
    width: 20px;
    height: 20px;
    object-fit: cover;
    margin-right: 3px;
}

.work_title {
    display: flex;
    margin-top: 5px;
    ;
}

.user_info {
    display: flex;
    margin-top: 5px;
    flex-grow: 1;
    width: 100%;
}

.user_avatar {
    display: flex;
    width: 30px;
    height: 30px;
    border-radius: 50%;
    overflow: hidden;
    margin-right: 5px;
}

.user_avatar img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.username {
    display: flex;
    justify-content: center;
    align-items: center;
}
</style>
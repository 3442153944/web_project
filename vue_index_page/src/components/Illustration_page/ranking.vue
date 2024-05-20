<template>
    <div class="ranking">
        <span><b>每日排行榜</b></span>
        <h3>{{ daytime }}的排行榜</h3>
        <div class="work_list">
            <div class="work_item" v-for="index in 10" :key="index">
                <div class="item">
                    <div class="rank"><span>{{ rank }}</span></div>
                    <div class="page_count"><span>{{ page_count }}</span></div>
                    <img :src="item_path">
                </div>
                <div class="work_title"></div>
                <div class="user_info">
                    <div class="user_avatar">
                        <img :src="user_avatar">
                    </div>
                    <div class="username">
                        <span>{{ username }}</span>
                    </div>
                </div>
            </div>
            <div class="left_btn" @click="scrollTabs(-400)"> <svg t="1715776937217" class="icon" viewBox="0 0 1024 1024" version="1.1"
                    xmlns="http://www.w3.org/2000/svg" p-id="4252" width="200" height="200">
                    <path
                        d="M510.86222222 1020.58666667c281.71377778 0 510.86222222-229.14844445 510.86222223-510.86222222S792.576-1.13777778 510.86222222-1.13777778 0 228.01066667 0 509.72444445s229.14844445 510.86222222 510.86222222 510.86222222z m0-950.72711112c242.57422222 0 439.86488889 197.29066667 439.86488889 439.8648889S753.43644445 949.58933333 510.86222222 949.58933333c-242.57422222 0-439.86488889-197.29066667-439.86488889-439.86488888S268.288 69.85955555 510.86222222 69.85955555zM307.65511111 532.48c-13.88088889-13.88088889-13.88088889-36.29511111 0-50.176l260.89244444-260.89244445c13.88088889-13.88088889 36.29511111-13.88088889 50.176 0 13.88088889 13.88088889 13.88088889 36.29511111 0 50.176L382.976 507.33511111l235.86133333 235.86133334c13.88088889 13.88088889 13.88088889 36.29511111 0 50.176-6.94044445 6.94044445-16.04266667 10.35377778-25.03111111 10.35377777-9.10222222 0-18.20444445-3.41333333-25.03111111-10.35377777L307.65511111 532.48z"
                        fill="#333303" p-id="4253"></path>
                </svg></div>
            <div class="right_btn" @click="scrollTabs(400)"><svg t="1715776983773" class="icon" viewBox="0 0 1024 1024" version="1.1"
                    xmlns="http://www.w3.org/2000/svg" p-id="6057" width="200" height="200">
                    <path
                        d="M896 512a384 384 0 1 0-384 384 384 384 0 0 0 384-384z m64 0A448 448 0 1 1 512 64a448 448 0 0 1 448 448z"
                        p-id="6058"></path>
                    <path
                        d="M425.28 310.72a32 32 0 0 1 45.44-45.44l224 224a32 32 0 0 1 0 45.44l-224 224a32 32 0 0 1-45.44-45.44L626.88 512z"
                        p-id="6059"></path>
                </svg></div>
        </div>
    </div>
</template>

<script>
import { ref, onMounted, onUnmounted, watch } from 'vue';

export default {
    name: 'ranking',

};
</script>
<script setup>
let daytime = ref();

onMounted(() => {
    const date = new Date();
    const year = date.getFullYear();
    const month = date.getMonth() + 1;
    const day = date.getDate();
    const datetime = year + '年' + month + '月' + day + '日';
    daytime.value = datetime;
})

let item_path = ref('https://127.0.0.1:4434/image/65014220_p0.jpg');
let rank = ref(1);
let page_count = ref(12);
let work_title = ref('作品标题');
let user_avatar = ref('https://127.0.0.1:4434/image/87328997_p0.jpg');
let username = ref('用户名');

function scrollTabs(scrollAmount){
    const tags=document.querySelector('.work_list'); 
    const animationDuration = 0.2 * 1000; // 0.5秒转为毫秒
    const fps = 24; // 帧率
    const frameDuration = animationDuration / fps; // 每帧持续时间
    const framesCount = Math.ceil(animationDuration / frameDuration); // 总帧数
    let count = 0;

    function animateScroll() {
        if (count < framesCount) {
            tags.scrollLeft += scrollAmount / framesCount;
            count++;
            requestAnimationFrame(animateScroll);
        }
    }
    animateScroll();
}

</script>

<style scoped>
.ranking {
    display: flex;
    margin-top: 30px;
    height: auto;
    width: 100%;
    margin-top: 30px;
    flex-direction: column;
}

.work_list {
    display: flex;
    overflow-x: auto;
    scrollbar-width: none;
    width: 100%;
    height: auto;
    white-space: normal;
}

.left_btn {
    display: flex;
    position: absolute;
    left: 0px;
    width: 50px;
    height: 260px;
    background: linear-gradient(to right, rgba(255, 255, 255, 1), rgba(255, 255, 255, 0));
    z-index: 2;
    opacity: 0;
    align-items: center;
}

.left_btn svg {
    width: 30px;
    height: 30px;
    object-fit: cover;
}

.left_btn:hover {
    opacity: 1;
    cursor: pointer;
    transition: all 0.3s ease;
}

.right_btn {
    display: flex;
    right: 0px;
    position: absolute;
    width: 50px;
    height: 260px;
    background: linear-gradient(to right, rgba(255, 255, 255, 0), rgba(255, 255, 255, 1));
    z-index: 2;
    opacity: 0;
    align-items: center;
    justify-content: flex-end;
}

.right_btn svg {
    width: 30px;
    height: 30px;
    object-fit: cover;
}

.right_btn:hover {
    opacity: 1;
    cursor: pointer;
    transition: all 0.3s ease;
}

.work_item {
    width: 200px;
    height: 260px;
    display: flex;
    flex-direction: column;
    margin-right: 20px;
    min-width: 200px;
    position: relative;
}

.item {
    display: flex;
    position: relative;
    width: 100%;
    height: 80%;
    min-height: 260*0.8px;
    overflow: hidden;
    border-radius: 15px;
}

.item img {
    display: flex;
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.rank {
    position: absolute;
    width: 30px;
    height: 30px;
    top: 5px;
    left: 5px;
    display: flex;
    justify-content: center;
    align-items: center;
    border-radius: 50%;
    background-color: rgba(255, 131, 99, 1);
}

.page_count {
    position: absolute;
    width: 40px;
    height: 20px;
    top: 5px;
    right: 5px;
    display: flex;
    justify-content: center;
    align-items: center;
    border-radius: 10px;
    background-color: rgba(255, 131, 99, 1);
    font-size: 12px;
    color: white;
}

.work_title {
    display: flex;
    margin-top: 10px;
}

.user_info {
    display: flex;
    margin-top: 10px;
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

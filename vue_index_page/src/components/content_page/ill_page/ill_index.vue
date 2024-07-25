<template>
    <div class="ill_index" ref="ill_index">
        <go_back></go_back>
        <div class="content" v-if="work_info">
            <div class="item_box">
                <div class="item" v-for="(item, index) in work_info.content_file_list.split(/[,，]/)" :key="index">
                    <div class="img_box" v-if="index<max_img_len">
                        <img :src="'https://www.sunyuanling.com/image/content_thumbnail/' + item" class="item_img"
                            @click="show_work_info(item)">
                    </div>
                </div>
                <div class="show_more_btn" v-if="max_img_len == 1 && work_info.content_file_list.split(/[,，]/).length > 1"
                    ref="show_more_btn">
                    <div class="show_more_background"></div>
                    <span @click="show_all_img()">查看全部</span>
                </div>
            </div>
            <interaction></interaction>
        </div>
        <div class="author_info_box" v-if="work_info">
            <author_info :author_id="work_info.belong_to_user_id" @chose_item="get_choose_item"></author_info>
        </div>
    </div>
    <img_content_page :item_path="item_path" v-if="img_content_page_show" @close_img_content_page="close_content_page">
    </img_content_page>
</template>

<script setup>
import { ref, watch, onMounted, defineProps } from 'vue';
import { useStore } from 'vuex';
import go_back from '../go_back.vue';
import img_content_page from '../img_content_page/img_content_page.vue';
import author_info from './author_box/author_info.vue';
import interaction from './author_box/model/interaction_bar.vue'

const store = useStore();
const work_id = ref('');
const work_info = ref();
const img_content_page_show = ref(false);
const item_path = ref('');
let max_img_len = ref(1)
let show_more_btn = ref(null)

//查看更多按钮实现
function show_all_img() {
    max_img_len.value = work_info.value.content_file_list.split(/[,，]/).length + 1;
}

const props = defineProps({
    work_id: {
        type: String,
        default: '1'
    }
});

watch(() => props.work_id, (newValue) => {
    work_id.value = newValue;
});

watch(() => store.getters.work_id, (newValue) => {
    work_id.value = newValue;
});

onMounted(async () => {
    work_id.value = store.getters.work_id;
    await get_work_info();
});
watch(work_id,async()=>{
    await get_work_info();
})
// 使用ID请求作品信息
async function get_work_info() {
    try {
        const res = await fetch('https://www.sunyuanling.com/api/get_work_info/GetIllInfo/', {
            method: 'post',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                work_id: work_id.value
            })
        });
        if (res.ok) {
            const data = await res.json();
            if (data.status === 'success') {
                work_info.value = data.data[0];
            } else {
                console.log(data.message);
            }
        }
    } catch (e) {
        console.log(e);
    }
}

// 查看作品详情
function show_work_info(item) {
    img_content_page_show.value = true;
    item_path.value = item;
    store.commit('SET_ITEM_PATH', item)
}

watch(img_content_page_show, (newValue) => {
    if (newValue) {
        document.body.style.overflow = 'hidden';
    } else {
        document.body.style.overflow = '';
    }
});

function close_content_page() {
    img_content_page_show.value = false;
}
//获取子组件传递的作品ID并设置在本页面
function get_choose_item(item)
{
    work_id.value=item.work_id;
}
</script>

<style scoped>
.ill_index {
    display: flex;
    width: 85%;
    height: auto;
    margin: 10px auto;
    background-color: rgba(0, 0, 0, 0.05);
    border-radius: 10px;
}

.content {
    display: flex;
    flex-direction: column;
    width: 100%;
    height: 100%;
    position: relative;
    gap: 10px;
}

.item_box {
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column;
    position: relative;
    margin-top: 10px;
}

.item {
    display: flex;
    width: 95%;
    height: auto;
    justify-content: center;
    margin: 0px auto;
    border-radius: 10px;
    overflow: hidden;
    cursor: zoom-in;
    flex-direction: column;
}

.item_img {
    width: 100%;
    height: auto;
    object-fit: cover;
}

.author_info_box {
    display: flex;
    width: 40%;
    height: auto;
    padding-right: 10px;
}
.show_more_btn{
    display: flex;
    width: 100%;
    height: auto;
    align-items: center;
    justify-content: center;
    position: absolute;
    bottom: 0px;
    min-height: 80px;
    background-color: transparent;
}
.show_more_background{
    position: absolute;
    inset: 0px;
    background-color: rgba(255, 255, 255, 1);
    mask-image: linear-gradient(transparent, rgb(0, 0, 0) 100%, rgb(0, 0, 0) 0px);
}
.show_more_btn span{
    width: auto;
    height: auto;
    background-color: rgb(58, 58, 58);
    padding: 10px 20px;
    color: rgba(255,255,255,1);
    border-radius: 15px;
    font-size: 20px;
    font-weight: bold;
    z-index: 2;
    cursor: pointer;
}
</style>
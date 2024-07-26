<template>
    <div class="ill_index" ref="ill_index">
        <go_back></go_back>
        <div class="content" v-if="work_info">
            <div class="item_box">
                <div class="item" v-for="(item, index) in work_info.content_file_list.split(/[,，]/)" :key="index">
                    <div class="img_box" v-if="index < max_img_len">
                        <img :src="'https://www.sunyuanling.com/image/content_thumbnail/' + item" class="item_img"
                            @click="show_work_info(item)">
                    </div>
                </div>
                <div class="show_more_btn"
                    v-if="max_img_len == 1 && work_info.content_file_list.split(/[,，]/).length > 1" ref="show_more_btn">
                    <div class="show_more_background"></div>
                    <span @click="show_all_img()">查看全部</span>
                </div>
            </div>
            <div class="fixed_interaction" ref="fixed_interaction">
                <interaction></interaction>
            </div>
            <div class="float_interaction" ref="float_interaction">
                <interaction></interaction>
            </div>
            <work_info_box></work_info_box>
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
import work_info_box from './author_box/model/work_info_bar.vue'
import * as cookies from '@/assets/js/cookies'
import * as user_interaction from '@/assets/js/interaction'


const store = useStore();
const work_id = ref('');
const work_info = ref();
const img_content_page_show = ref(false);
const item_path = ref('');
let max_img_len = ref(1)
let show_more_btn = ref(null)
let fixed_interaction = ref(null)
let float_interaction = ref(null)
let token = cookies.get_cookie("token");

//浮动互动栏的实现
function float_interaction_bar() {
    if (!fixed_interaction.value || !float_interaction.value) return;
    // 获取当前窗体高度
    let window_height = window.innerHeight;
    // 获取固定互动栏底部高度距离窗体底部的高度
    let fixed_interaction_bottom = fixed_interaction.value.getBoundingClientRect().bottom;
    // 当固定互动栏距离窗体距离为正时，隐藏浮动互动栏
    if (fixed_interaction_bottom < window_height) {
        float_interaction.value.style.transform = 'translateY(100%)';
        //鼠标向上滑动时出现向下时隐藏
        window.addEventListener('scroll', () => {
            if (window.scrollY > 0) {
                float_interaction.value.style.transform = 'translateY(100%)';
            } else {
                float_interaction.value.style.transform = 'translateY(0)';
            }
        });
    } else {
        float_interaction.value.style.transform = 'translateY(0)';
    }
}

onMounted(() => {
    float_interaction_bar(); // 初始调用
    window.addEventListener('scroll', float_interaction_bar);
});
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
    await user_interaction.watch_work(parseInt(work_id.value,),token,'ill',work_info.value.name)
});
watch(work_id, async () => {
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
async function get_choose_item(item) {
    work_id.value = item.work_id;
    await user_interaction.watch_work(work_id.value,token,'ill',work_info.value.name);
}
//作品观看
async function watch_work(work_id,a_token,work_type,work_name) {
    try {
        const res = await fetch('https://www.sunyuanling.com/api/work_interaction/Watch/', {
            method: 'post',
            headers: {
                'content-type': 'application/json'
            },
            body: JSON.stringify({
                token: a_token,
                work_id: work_id,
                work_type: work_type,
                work_name: work_name,
            })
        })
        if (res.ok) {
            const data = await res.json()
            if (data.status == 'success') {
                console.log(data.message)
            }
            else {
                console.log(data.message)
            }
        }
        else {
            console.log(res.status)
        }
    }
    catch (e) {
        console.log(e)
    }
}
//作品点赞
async function like_work(work_id,operate_type,token,work_type)
{
    try{
        const res=await fetch('https://www.sunyuanling.com/api/work_interaction/Like/')
    }
    catch(e)
    {
        console.log(e)
    }
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

.show_more_btn {
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

.show_more_background {
    position: absolute;
    inset: 0px;
    background-color: rgba(255, 255, 255, 1);
    mask-image: linear-gradient(transparent, rgb(0, 0, 0) 100%, rgb(0, 0, 0) 0px);
}

.show_more_btn span {
    width: auto;
    height: auto;
    background-color: rgb(58, 58, 58);
    padding: 10px 20px;
    color: rgba(255, 255, 255, 1);
    border-radius: 15px;
    font-size: 20px;
    font-weight: bold;
    z-index: 2;
    cursor: pointer;
}

.float_interaction {
    position: fixed;
    bottom: 0px;
    width: 60%;
    background: linear-gradient(to top, rgba(255, 255, 255, 1), rgba(255, 255, 255, 0));
    height: 80px;
    display: flex;
    align-items: center;
    transition: all 0.3s ease-in-out;
}
</style>
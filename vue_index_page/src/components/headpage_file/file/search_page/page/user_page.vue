<template>
    <div class="user_page">
        <div class="content">
            <div class="item_box">
                <div class="item" v-for="(item, index) in data" :key="index">
                    <div class="user_avatar">
                        <img :src="'https://www.sunyuanling.com/image/avatar_thumbnail/' + item.user_avatar">
                    </div>
                    <div class="user_info">
                        <div class="user_name">
                            <span>{{ item.username }}</span>
                        </div>
                        <div class="user_work" v-if="show_work_list.length > 0">
                            <div class="user_work_for" v-for="(work, workIndex) in show_work_list" :key="workIndex">
                                <div class="item_img" v-if="work.Illustration_id">
                                    <img :src="'https://www.sunyuanling.com/image/thumbnail/' + work.content_file_list.split(/[,，]/)[0]">
                                </div>
                                <div class="item_img" v-else-if="work.id">
                                    <img :src="'https://www.sunyuanling.com/image/comic/thumbnail/' + work.content_file_list.split(/[,，]/)[0]">
                                </div>
                                <div class="item_img" v-else-if="work.work_id">
                                    <img :src="'https://www.sunyuanling.com/image/novel/thumbnail/' + work.work_cover">
                                </div>
                            </div>
                        </div>
                        <div class="brief_introduction">
                            <span>{{ item.user_self_introduction }}</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
import { ref, watch, onMounted, defineProps } from 'vue';

const props = defineProps({
    user_data: {
        type: Object,
        default: () => ({})
    }
});

const data = ref(props.user_data);
const work_list = ref({});
const show_work_list = ref([]);

watch(() => props.user_data, async (newValue) => {
    data.value = newValue;
    await get_work_list();
    set_work_list();
});

onMounted(async () => {
    data.value = props.user_data;
    await get_work_list();
    set_work_list();
});

async function get_work_info(userid) {
    try {
        const res = await fetch('https://www.sunyuanling.com/api/GetUserInfo/GetUserWorkList/', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ userid })
        });

        if (!res.ok) {
            console.log('网络错误');
            return null;
        }

        const result = await res.json();
        if (result.status === 'success') {
            return result.data;
        } else {
            console.warn(result.message);
            return null;
        }
    } catch (error) {
        console.error('请求错误:', error);
        return null;
    }
}

async function get_work_list() {
    const temp_work_list = {};
    for (const user of data.value) {
        const userWorks = await get_work_info(user.userid);
        if (userWorks) {
            temp_work_list[user.userid] = userWorks;
        }
    }
    work_list.value = temp_work_list;
    console.log(work_list.value);
}

function set_work_list() {
    show_work_list.value = [];
    const user_work_list = Object.values(work_list.value).flat();

    const ill_list = user_work_list.flatMap(user => user.ill || []);
    const comic_list = user_work_list.flatMap(user => user.comic || []);
    const novel_list = user_work_list.flatMap(user => user.novel || []);

    const addWorks = (list) => {
        for (const item of list) {
            if (show_work_list.value.length < 4) {
                show_work_list.value.push(item);
            } else {
                break;
            }
        }
    };

    addWorks(ill_list);
    addWorks(comic_list);
    addWorks(novel_list);

    console.log(show_work_list.value);
}
</script>

<style scoped>
.user_page {
    width: 80%;
    margin: 20px auto;
}

.content {
    display: flex;
    flex-direction: column;
    gap: 20px;
}

.item_box {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
}

.item {
    display: flex;
    gap: 10px;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
}

.user_avatar img {
    width: 50px;
    height: 50px;
    border-radius: 50%;
}

.user_info {
    display: flex;
    flex-direction: column;
    gap: 5px;
}

.user_name {
    font-weight: bold;
}

.user_work {
    display: flex;
    gap: 10px;
}

.user_work_for {
    display: flex;
    flex-direction: column;
    gap: 5px;
}

.item_img img {
    width: 100px;
    height: 100px;
    object-fit: cover;
}

.brief_introduction {
    margin-top: 10px;
}
</style>

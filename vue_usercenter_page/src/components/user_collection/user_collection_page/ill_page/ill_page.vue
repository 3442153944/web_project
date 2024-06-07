<template>
    <div class="ill_page">
        <div class="content">
            <div class="title">
                <div class="title_item">作品</div>
                <div class="title_item edit_collection">
                    <img :src="edit_svg" class="icon" />
                    <span>管理收藏</span>
                </div>
            </div>
            <div class="collection_item_list">
                <div class="item" v-for="(item, index) in user_collected_ill_work_list" :key="index">
                    <div class="item_img">
                        <img v-if="item && item[0] && item[0].content_file_list"
                            :src="'https://127.0.0.1:4434/image/' + item[0].content_file_list.split(/[,，]/)[0]"
                            alt="Image" />
                    </div>
                    <div class="work_info">
                        <div class="work_name">
                            <span v-if="item && item[0]">{{ item[0].name }}</span>
                        </div>
                        <div class="author_info">
                            <div class="author_avatar">
                                <img v-if="author_info_list[index] && author_info_list[index][0]"
                                    :src="'https://127.0.0.1:4434/image/' + author_info_list[index][0].user_avatar"
                                    alt="Avatar" />
                            </div>
                            <div class="author_name">
                                <span v-if="author_info_list[index] && author_info_list[index][0]">
                                    {{ author_info_list[index][0].username }}
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import * as cookies from '../../../../../../model/cookies.js';

let server_ip = 'https://127.0.0.1:4434/';
let edit_svg = server_ip + 'assets/edit.svg';
let user_info = ref([]);
let collected_ill_work_id = ref([]);
let user_collected_ill_work_list = ref([]);
let author_id_list = ref([]);
let author_info_list = ref([]);

// 设置插画信息以及相应的作者信息
async function set_user_collected_ill_work_list() {
    for (let i = 0; i < collected_ill_work_id.value.length; i++) {
        user_collected_ill_work_list.value.push(await get_ill_work_info(collected_ill_work_id.value[i]));
    }
    // 获取作者ID列表
    for (let i = 0; i < user_collected_ill_work_list.value.length; i++) {
        author_id_list.value.push(user_collected_ill_work_list.value[i][0].belong_to_user_id);
    }
    // 获取作者信息
    for (let i = 0; i < author_id_list.value.length; i++) {
        author_info_list.value.push(await use_id_get_user_info(author_id_list.value[i]));
    }
    console.log(author_info_list.value);
}

// 获取用户的所有信息
async function use_id_get_user_info(id) {
    try {
        const res = await fetch('api/UserIdGetAllUserInfo', {
            method: 'post',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                user_id: id,
            }),
        });
        const data = await res.json();
        if (data.status == 'success') {
            return data.data;
        } else {
            console.log(data.message);
        }
    } catch (err) {
        console.log(err);
    }
}

// 获取用户信息并设置收藏的插画列表
async function get_user_info() {
    try {
        const res = await fetch('api/UserIdGetAllUserInfo', {
            method: 'post',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                user_id: cookies.get_cookie('user_id'),
            }),
        });
        const data = await res.json();
        if (data.status == 'success') {
            user_info.value = data.data;
            collected_ill_work_id.value = user_info.value[0].collected_ill_work_id.split(/[,，]/);
            await set_user_collected_ill_work_list();
            console.log(user_collected_ill_work_list.value);
        }
    } catch (err) {
        console.log(err);
    }
}

// 使用ID获取插画信息
async function get_ill_work_info(ill_id) {
    try {
        const res = await fetch('api/useIdGetWorkInfo', {
            method: 'post',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                type: 'ill',
                ill_id: ill_id,
            }),
        });
        const data = await res.json();
        if (data.status == 'success') {
            console.log(data.data);
            return data.data;
        } else {
            console.log(data.message);
        }
    } catch (err) {
        console.log(err);
    }
}

onMounted(() => {
    get_user_info();
});
</script>

<style scoped>
.ill_page {
    display: flex;
    width: 100%;
    height: auto;
    flex-direction: column;
    margin-top: 20px;
}

.content {
    display: flex;
    width: 100%;
    height: 100%;
    flex-direction: column;
}

.title {
    width: 100%;
    height: auto;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.title_item {
    width: auto;
    height: auto;
    display: flex;
    padding: 5px 10px;
    justify-content: center;
    align-items: center;
    font-size: 18px;
    font-weight: bold;
}

.icon {
    width: 25px;
    height: 25px;
    object-fit: cover;
    margin-right: 5px;
}

.edit_collection {
    cursor: pointer;
    border-radius: 15px;
}

.edit_collection:hover {
    background-color: rgba(133, 133, 133, 0.2);
    transition: all 0.3s ease-in-out;
}

.collection_item_list {
    width: 100%;
    height: auto;
    display: flex;
    flex-wrap: wrap;
}

.item {
    width: 200px;
    height: 250px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    margin: 10px;
    border-radius: 15px;
    overflow: hidden;
}

.item_img {
    width: 100%;
    height: 80%;
    display: flex;
    align-items: center;
    border-radius: 15px 15px 15px 15px;
    overflow: hidden;
}

.item_img img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.work_info {
    display: flex;
    flex-direction: column;
    width: 100%;
    margin-top: 5px;
    flex: 1;
}

.author_info {
    display: flex;
    width: 100%;
    flex: 1;
    flex-grow: 1;
    align-items: center;
    margin-top: 5px;
}

.author_avatar {
    width: 30px;
    height: 30px;
    border-radius: 50%;
    overflow: hidden;
    margin-right: 5px;
}

.author_avatar img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}
.author_name{
    display: flex;
    align-items: center;
}
</style>
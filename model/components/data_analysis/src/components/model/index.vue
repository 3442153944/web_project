<!-- eslint-disable vue/multi-word-component-names -->
<template>
    <div class="index">
        <div class="content">
            <div class="title">
                <div class="all_work_data">
                    <span @click="choose_type = 'all'; searchWorks()">全部的作品数据</span>
                </div>
                <div class="appiont_work">
                    <span @click="choose_type = 'appiont'; searchWorks()">搜索作品</span>
                </div>
            </div>
            <div class="content_item">
                <div class="choose_appiont_work" >
                    <div class="search_box">
                        <input v-model="search_type" type="text" placeholder="请输入作品名">
                        <span @click="searchWorks">搜索</span>
                    </div>
                    <span @click="choose_type = 'novel'; searchWorks()">小说</span>
                    <span @click="choose_type = 'comic'; searchWorks()">漫画</span>
                    <span @click="choose_type = 'ill'; searchWorks()">插画</span>
                </div>
            </div>
        </div>
        <work_list :work_list="filtered_work_list"></work_list>
    </div>
</template>

<script setup>
import { ref, computed, onMounted, defineProps } from 'vue'
import { get_all_work_data } from './js/get_user_workdata'
import { get_all_user_work } from './js/get_user_all_work'
import work_list from './work_list.vue'

const props = defineProps({
    token: {
        type: String,
        default: ''
    }
})

const choose_type = ref('all')
const all_work_data = ref()
const all_work_list = ref()
const search_type = ref('')
const selected_status = ref('') // 用于小说连载状态筛选

onMounted(async () => {
    all_work_data.value = await get_all_work_data(props.token, 7)
    all_work_list.value = await get_all_user_work(props.token)
    console.log(all_work_data.value)
    console.log(all_work_list.value)
})

const searchWorks = () => {
    // 只需更新 search_type，filtered_work_list 会自动更新
    search_type.value = search_type.value
}

const filterWorks = (workList, query) => {
    if (!query) return filterByType(choose_type.value, workList)

    const filtered = {
        ill: workList.ill.filter(item => item.name.toLowerCase().includes(query.toLowerCase()) || item.work_tags.toLowerCase().includes(query.toLowerCase())),
        comic: workList.comic.filter(item => item.work_name.toLowerCase().includes(query.toLowerCase()) || item.work_tags.toLowerCase().includes(query.toLowerCase())),
        novel: workList.novel.filter(item => item.work_name.toLowerCase().includes(query.toLowerCase()) || item.work_tags.toLowerCase().includes(query.toLowerCase()))
    }
    return filterByType(choose_type.value, filtered)
}

const filterByType = (type, workList) => {
    if (type === 'all') return workList
    return {
        ill: type === 'ill' ? workList.ill : [],
        comic: type === 'comic' ? workList.comic : [],
        novel: type === 'novel' ? workList.novel : []
    }
}

const filtered_work_list = computed(() => {
    let filtered = filterWorks(all_work_list.value, search_type.value)
    
    // 处理小说的连载状态筛选
    if (selected_status.value) {
        filtered.novel = filtered.novel.filter(novel => novel.work_status === selected_status.value)
    }

    return filtered
})
</script>


<style scoped>
/* 其他样式不变 */

.content {
    padding: 16px;
    background-color: #f9f9f9;
}

.title {
    display: flex;
    justify-content: space-between;
    margin-bottom: 16px;
}

.all_work_data,
.appiont_work {
    cursor: pointer;
    padding: 12px 16px;
    border-radius: 8px;
    font-size: 16px;
    transition: background-color 0.3s, color 0.3s;
}

.all_work_data {
    background-color: #007bff;
    color: white;
}

.appiont_work {
    background-color: #fff;
    color: #007bff;
    border: 1px solid #007bff;
}

.all_work_data:hover,
.appiont_work:hover {
    background-color: #0056b3;
    color: #fff;
}

.choose_appiont_work {
    margin-top: 16px;
}

.search_box {
    display: flex;
    align-items: center;
    gap: 8px;
    margin-bottom: 16px;
}

.search_box input {
    flex: 1;
    padding: 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 16px;
}

.search_box span {
    cursor: pointer;
    background-color: #007bff;
    color: #fff;
    padding: 12px 24px;
    border-radius: 4px;
    font-size: 16px;
    transition: background-color 0.3s;
}

.search_box span:hover {
    background-color: #0056b3;
}

.choose_appiont_work span {
    cursor: pointer;
    display: inline-block;
    padding: 8px 12px;
    margin: 0 4px;
    border-radius: 4px;
    font-size: 14px;
    transition: background-color 0.3s, color 0.3s;
}

.choose_appiont_work span:hover {
    background-color: #007bff;
    color: #fff;
}
</style>

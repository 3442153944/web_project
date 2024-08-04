<template>
    <div class="user_index_select" v-if="msg_list">
        <div class="title">
            <span><b>精选</b></span>
        </div>
        <div class="content">
            <scroll_box :msg_list="msg_list" @open_select_box="add_select_page_show=true"></scroll_box>
        </div>
        <add_select_page v-if="add_select_page_show" @close_page="add_select_page_show=false"></add_select_page>
    </div>
</template>

<script setup>
import { ref, defineProps, onMounted } from 'vue';
import scroll_box from './model/scroll_box.vue';
import { get_workinfo } from '../../../js/get_workinfo';
import add_select_page from './model/add_select_page.vue';
const props = defineProps({
    user_info: {
        type: Object,
        default: () => ({})
    },
    token: {
        type: String,
        default: ''
    }
});

// 构建滚动盒子所需的数据结构
let msg_list = ref(JSON.parse(props.user_info.select_work));
let add_select_page_show = ref(false);
function get_msg_list() {
    let result = [];
    for (let work_type in msg_list.value) {
        // 遍历 work_type 对应的 ID 列表
        for (let id of msg_list.value[work_type]) {
            result.push({ work_type: work_type, work_id: id });
        }
    }
    console.log(result);
    return result;
}

onMounted(async () => {
    get_msg_list();
    msg_list.value=await get_workinfo(props.token,get_msg_list());
    console.log(msg_list.value);
});
</script>



<style scoped></style>
<template>
    <div class="novel_index">
        <go_back></go_back>
        <novel_content_page :work_id="work_id" :token="token"></novel_content_page>
        <comment_section :work_id="work_id.toString()" :token="token" :work_type="'novel'" :user_avatar_path="user_avatar_path"></comment_section>
    </div>
</template>

<script setup>
import { ref, watch, onMounted } from 'vue';
import { useStore } from 'vuex';
import novel_content_page from './novel_components/novel_content_page.vue';
import * as cookies from '@/assets/js/cookies.js';
import go_back from '../go_back.vue';
import comment_section from './comment_section.vue';

const token = cookies.get_cookie('token');
const store = useStore();
let user_avatar_path=ref(JSON.parse(cookies.get_cookie('userinfo')).user_avatar)
const props = defineProps({
  work_id: {
    type: String,
    default: '10'
  }
});

const work_id = ref(props.work_id);

// 监听 props.work_id 的变化
watch(() => props.work_id, (newValue) => {
  work_id.value = newValue;
});

// 监听 store 的变化
watch(() => store.getters.work_id, (newValue) => {
  work_id.value = newValue;
});

// 组件挂载时设置 work_id
onMounted(() => {
  work_id.value = store.getters.work_id;
});

function close_page_click() {
  store.commit('SET_CONTENT_PAGE', { key: 'ill_page', value: false });
  store.commit('SET_SINGLE_PAGE_STATUS', { key: 'index_page', value: true });
}
</script>


<style scoped>
.novel_index {
    width: 80%;
    margin: 0 auto;
    display: flex;
    flex-direction: column;
    gap: 10px;
}
</style>
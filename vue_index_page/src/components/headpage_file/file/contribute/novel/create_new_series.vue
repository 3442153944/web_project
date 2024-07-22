<template>
    <div class="create_new_series">
        <div class="background">
            <div class="title">
                <div></div>
                <span>新建系列</span>
                <div class="close_btn" @click="close_page()">
                    <img class="icon" src="https://www.sunyuanling.com/assets/close.svg">
                </div>
            </div>
            <div class="content">
                <div class="work_title">
                    <label>标题</label>
                    <input type="text" v-model="work_info.title" maxlength="100">
                </div>
                <div class="work_introducation">
                    <label>作品介绍</label>
                    <auto_textarea style="border:1px solid rgba(77,77,77,0.8);" v-model="work_info.introducation"
                        :maxlength="300000" :rows="5" placeholder="请输入作品介绍..." :fontsize="14" :lineheight="1.6">
                    </auto_textarea>
                </div>
                <div class="tags_box">
                    <div class="add_tag_btn">
                        <label>作品标签</label>
                        <input type="text" v-model="work_info.tags">
                    </div>
                    <div class="tags_list">
                        <input type="text" v-model="work_info.tags" ref="tags_list_input">
                    </div>
                </div>
                <div class="age_classification">
                    <label>作品年龄分类</label>
                    <div class="age_classification_list">
                        <input type="radio" value="16" name="age_classification" v-model="work_info.age_classification">
                        <span>全年龄</span>
                        <input type="radio" value="18" name="age_classification" v-model="work_info.age_classification">
                        <span>R-18</span>
                        <input type="radio" value="18+" name="age_classification"
                            v-model="work_info.age_classification">
                        <span>R-18G</span>
                    </div>
                </div>
                <div class="work_status">
                    <switch_btn @change_status="get_work_status"></switch_btn>
                    <span>连载中</span>
                </div>
                <div class="choose_cover" style="gap:10px;display:flex;flex-direction:column;">
                    <span>封面</span>
                    <div class="cover_list">
                        <scroll_box :msg_type="'image'" :msg_list="set_template_cover_path()"
                            @chose_item="get_choose_cover_path" @choose_cover_file="get_choose_cover_file"
                            @clear_cover_file="clear_choose_cover_file"></scroll_box>
                    </div>
                </div>
                <preview_cover :title="work_info.title" :template_name="work_info.choose_cover_path"
                    :file="user_choose_cover_file" @temp_cover_path="user_choose_cover_path"
                    @clear_uploaded_file="clear_choose_cover_file"></preview_cover>
            </div>
        </div>
    </div>
</template>

<script setup>
import auto_textarea from '../../../../models/auto_textarea.vue';
import switch_btn from '../../../../models/switch_btn.vue';
import scroll_box from '../../../../models/scroll_box.vue';
import preview_cover from './preview_cover.vue'
import { ref, watch, defineEmits } from 'vue';

const emit = defineEmits(['close_create_new_series', 'new_series_info']);
const new_series_info = ref({});
const template_cover = ref(['template_1.jpg', 'template_2.jpg', 'template_3.jpg', 'template_4.jpg', 'template_5.jpg',
    'template_6.jpg', 'template_7.jpg'
]);

function set_template_cover_path() {
    const path = 'https://www.sunyuanling.com/image/novel/cover_material/';
    return template_cover.value.map(cover => path + cover);
}

function close_page() {
    emit('close_create_new_series', false);
}

function create_new_series() {
    emit('new_series_info', new_series_info.value);
}

// 作品系列信息
const work_info = ref({
    title: '',
    introducation: '',
    tags: '',
    age_classification: '',
    work_status: '',
    choose_cover_path: '',
});
let user_choose_cover_file = ref(null);

let user_choose_cover_path = (item) => {
    work_info.value.user_choose_cover_path = item
}

watch(work_info, (new_value) => {
    new_series_info.value = { ...new_value };
    create_new_series();
    console.log(new_value);
}, { deep: true });

const tags_list_input = ref(null);
watch(() => work_info.value.tags, (new_value) => {
    if (tags_list_input.value) {
        tags_list_input.value.value = new_value.split(',');
    }
});

function get_work_status(status) {
    work_info.value.work_status = status ? '连载中' : '已完结';
    console.log(work_info.value);
}

// 获取子组件传值
function get_choose_cover_file(file) {
    user_choose_cover_file.value = file;
}

// 通知本组件清空文件
function clear_choose_cover_file() {
    user_choose_cover_file.value = null;
}

function get_choose_cover_path(path) {
    if (path != 'custom_cover') {
        work_info.value.choose_cover_path = path;
        user_choose_cover_file.value = null; // 清空用户选择的文件
    } else {
        console.log('自定义封面')
    }
}

// 监视作品标题和封面路径，如果变化先清空用户选择的封面文件
watch(() => work_info.value.title, () => {
    user_choose_cover_file.value = null;
});

watch(() => work_info.value.choose_cover_path, () => {
    user_choose_cover_file.value = null;
});
</script>


<style scoped>
.create_new_series {
    width: 100vw;
    height: 100vh;
    position: fixed;
    top: 0px;
    left: 0px;
    display: flex;
    flex-direction: column;
    background-color: rgba(0, 0, 0, 0.5);
    z-index: 10;
    padding: 50px;
    box-sizing: border-box;
}

.background {
    width: auto;
    height: auto;
    display: flex;
    flex-direction: column;
    background-color: rgba(255, 255, 255, 1);
    min-height: 100px;
    min-width: 550px;
    margin: auto;
    padding: 5px 20px;
    border-radius: 15px;
    overflow: auto;
    max-width: 550px;
}

.background::-webkit-scrollbar {
    display: none;
}

.title {
    width: auto;
    height: 50px;
    display: flex;
    justify-content: space-between;
    font-size: 18px;
    align-items: center;
    border-bottom: 1px solid rgba(133, 133, 133, 1);
    margin-top: 5px;
    font-weight: bold;
}

.icon {
    width: 25px;
    height: 25px;
    object-fit: cover;
}

.close_btn {
    display: flex;
    width: 30px;
    height: 30px;
    justify-content: center;
    align-items: center;
    cursor: pointer;
}

.close_btn:hover {
    background-color: rgba(0, 0, 0, 0.3);
    border-radius: 50%;
    transition: all 0.2 ease-in-out;
}

.content {
    width: 100%;
    height: auto;
    display: flex;
    flex-direction: column;
    gap: 10px;
}

.work_status {
    width: auto;
    display: flex;
    height: auto;
    align-items: center;
    gap: 10px;
}

.work_title {
    width: 100%;
    height: auto;
    display: flex;
    flex-direction: column;
    gap: 5px;
}

.work_introducation {
    width: 100%;
    height: auto;
    display: flex;
    flex-direction: column;
    gap: 5px;
}

.tags_box {
    width: 100%;
    height: auto;
    display: flex;
    flex-direction: column;
    gap: 5px;
}

.add_tag_btn {
    display: flex;
    flex-direction: column;
}

.tags_list {
    width: 100%;
    display: flex;
    flex-direction: column;
    gap: 5px;
    justify-content: center;
    align-items: center;
}

.tags_list input {
    width: 100%;
}

.age_classification {
    display: flex;
    flex-direction: column;
    gap: 5px;

}
</style>
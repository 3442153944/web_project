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
                <div class="choose_cover">
                    <span>封面</span>
                    <div class="cover_list">
                       <scroll_box :msg_type="'image'" :msg_list="set_template_cover_path()" 
                       @chose_item="get_choose_cover_path"></scroll_box>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
import auto_textarea from '../../../../models/auto_textarea.vue';
import switch_btn from '../../../../models/switch_btn.vue';
import scroll_box from '../../../../models/scroll_box.vue';
import { ref, watch, defineEmits } from 'vue';

const emit = defineEmits(['close_create_new_series', 'new_series_info']);
const new_series_info = ref({});
const template_cover = ref(['template_1.jpg', 'template_2.jpg', 'template_3.jpg', 'template_4.jpg', 'template_5.jpg',
'template_6.jpg','template_7.jpg'
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

const work_info = ref({
    title: '',
    introducation: '',
    tags: '',
    age_classification: '',
    work_status: '',
});

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
let choose_cover_path=ref()
function get_choose_cover_path(path) {
    choose_cover_path.value=path;
    console.log(choose_cover_path.value)
}
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
    margin-bottom: 100px;
    max-width: 550px;
}
.background::-webkit-scrollbar{
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
.work_status{
    width: auto;
    display: flex;
    height: auto;
    align-items: center;
    gap: 10px;
}
.work_title{
    width: 100%;
    height: auto;
    display: flex;
    flex-direction: column;
}
</style>
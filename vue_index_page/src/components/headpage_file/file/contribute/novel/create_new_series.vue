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
                <div class="title">
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
                </div>
                <div class="choose_cover">
                    <span>封面</span>
                    <div class="cover_list">
                        <div class="cover_item" v-for="(item,index) in template_cover" :key="index">
                            <img class="cover_img" :src="'https://www.sunyuanling.com/image/novel/cover_material/'+item">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted, defineEmits } from 'vue';
export default {
    name: 'create_new_series',
}
</script>

<script setup>
import auto_textarea from '../../../../models/auto_textarea.vue';
import switch_btn from '../../../../models/switch_btn.vue';
let emit = defineEmits(['close_create_new_series'], ['new_series_info'])
let new_series_info = ref({})
let template_cover=ref(['template_1.jpg','template_2.jpg','template_3.jpg','template_4.jpg'])
function close_page() {
    emit('close_create_new_series', false)
}
function create_new_series() {
    emit('new_series_info', new_series_info.value)
}
watch(new_series_info, (new_value, old_value) => {
    create_new_series()
    console.log(new_value)
})
let work_info = ref({
    title: '',
    introducation: '',
    tags: '',
    age_classification: '',
    work_status: '',
})
let tags_list_input = ref(null)
watch(() => work_info.value.tags, (new_value) => {
    tags_list_input.value += new_value.split(',')
})
function get_work_status(status) {
    if (status == false) {
        work_info.value.work_status = '已完结';
    }
    else {
        work_info.value.work_status = '连载中';
    }
    console.log(work_info.value)
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
}

.background {
    width: auto;
    height: auto;
    display: flex;
    flex-direction: column;
    background-color: rgba(255, 255, 255, 1);
    min-height: 100px;
    min-width: 350px;
    margin: auto;
    padding: 5px 20px;
    border-radius: 15px;
}

.title {
    width: 100%;
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
</style>
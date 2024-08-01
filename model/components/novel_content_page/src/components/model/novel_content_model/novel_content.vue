<template>
    <div class="novel_content">
        <div class="title">{{ work_title }}</div>
        <div class="content" v-html="work_content"></div>
        <div class="right_side">
            <div class="previous_chapter">上一章</div>
            <div class="next_chapter">下一章</div>
            <div class="open_setting" @click="toggleSettings">打开设置</div>
            <div class="directory">
                <span @click="directory_show=!directory_show">目录</span>
            </div>
            <div class="set_light_mode">
                <div class="light_mode" @click="light_model=!light_model">{{light_model?'夜间模式':'日间模式'}}</div>
            </div>
            <directory_page :work_info="work_info" v-if="directory_show" @get_chapter="get_content"></directory_page>
            <transition name="fade">
                <div class="font_setting" v-if="showSettings">
                    <div class="title">设置</div>
                   
                    <div class="item">
                        字体
                        <select v-model="fontFamily" @change="updateStyles">
                            <option value="微软雅黑">微软雅黑</option>
                            <option value="黑体">黑体</option>
                            <option value="宋体">宋体</option>
                            <option value="楷体">楷体</option>
                            <!-- 其他字体 -->
                        </select>
                    </div>
                    <div class="item">
                        字号
                        <select v-model="fontSize" @change="updateStyles">
                            <option value="14px">14px</option>
                            <option value="16px">16px</option>
                            <option value="18px">18px</option>
                            <option value="20px">20px</option>
                            <option value="22px">22px</option>
                            <option value="24px">24px</option>
                            <option value="26px">26px</option>
                            <!-- 其他字号 -->
                        </select>
                    </div>
                    <div class="item">
                        背景
                        <input type="color" v-model="backgroundColor" @input="updateStyles">
                    </div>
                    <div class="item">
                        阅读页面宽度
                        <input type="range" v-model="pageWidth" min="500" max="1200" step="100" @input="updateStyles">
                    </div>
                    <div class="item">
                        字体颜色
                        <input type="color" v-model="fontColor" @input="updateStyles">
                    </div>
                </div>
            </transition>
        </div>
        
    </div>
</template>

<script setup>
import { ref, watch ,defineProps} from 'vue';
import directory_page from './model/directory_page.vue'
import { get_novel_content } from '../js/get_workinfo';
const props = defineProps({
    content: {
        type: String,
        default: ''
    },
    title: {
        type: String,
        default: ''
    },
    work_info: {
        type: Array,
        default: () => {
            return []
        }
    }
});

const showSettings = ref(false);
const fontFamily = ref('Arial');
const fontSize = ref('16px');
const backgroundColor = ref('#ffffff');
const fontColor = ref('#000000');
const pageWidth = ref(800);
let light_model=ref(false)
let directory_show=ref(false)
let work_content=ref(props.content)
let work_title=ref(props.title)
async function get_content(item)
{
    work_content.value=await get_novel_content('sunyuanling',item.belong_to_series_id,item.title)
    work_title.value=item.title
}

// Toggle settings visibility
const toggleSettings = () => {
    showSettings.value = !showSettings.value;
};

// Update CSS variables
const updateStyles = () => {
    document.documentElement.style.setProperty('--fontFamily', fontFamily.value);
    document.documentElement.style.setProperty('--fontSize', fontSize.value);
    document.documentElement.style.setProperty('--backgroundColor', backgroundColor.value);
    document.documentElement.style.setProperty('--fontColor', fontColor.value);
    document.documentElement.style.setProperty('--pageWidth', `${pageWidth.value}px`);
};

// Watch for changes in the style values
watch([fontFamily, fontSize, backgroundColor, fontColor, pageWidth], updateStyles, { immediate: true });

//监听左右键
document.addEventListener('keydown', (event) => {
    if (event.key === 'ArrowLeft') {
       console.log('left')
    } else if (event.key === 'ArrowRight') {
        console.log('right')
    }
});
</script>

<style scoped>
.novel_content {
    position: relative;
    max-width: var(--pageWidth, 800px);
    margin: 0 auto;
    padding: 20px;
    background-color: var(--backgroundColor, #ffffff);
}

.title {
    font-size: 1.5em;
    font-weight: bold;
    margin-bottom: 10px;
}

.content {
    font-family: var(--fontFamily, Arial);
    font-size: var(--fontSize, 16px);
    color: var(--fontColor, #000000);
    text-indent: 2em;
    line-height: 2em;
    letter-spacing: 0.1em;
}

.open_setting {
    cursor: pointer;
    color: #007BFF;
    text-decoration: underline;
}

.font_setting {
    position: absolute;
    top: 50px;
    right: 100px;
    width: 300px;
    padding: 10px;
    border: 1px solid #ddd;
    background: #f9f9f9;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
}

.font_setting .title {
    font-weight: bold;
    margin-bottom: 10px;
}

.font_setting .item {
    margin-bottom: 10px;
}

.fade-enter-active,
.fade-leave-active {
    transition: opacity 0.3s;
}

.fade-enter,
.fade-leave-to {
    opacity: 0;
}
.icon{
    width: 25px;
    height: 25px;
    object-fit: cover;
}
.right_side{
    position: fixed;
    right: 30px;
    top:100px;
    display: flex;
    flex-direction: column;
    width: auto;
    height: auto;
    padding: 5px;
}
.directory{
    display: flex;
    position: relative;
}
</style>
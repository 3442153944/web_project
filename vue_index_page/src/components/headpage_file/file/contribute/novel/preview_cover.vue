<template>
    <div class="preview_cover">
        <span>封面预览</span>
        <div class="cover_box">
            <img :src="'https://www.sunyuanling.com/image/novel/temp_cover/' + cover_path">
        </div>
    </div>
</template>

<script setup>
import { ref, watch, defineEmits, defineProps, onMounted } from 'vue';
import * as cookies from 'https://www.sunyuanling.com/model/cookies.js'
let cover_path = ref()
let token = cookies.get_cookie('token')
const props = defineProps({
    title: {
        type: String,
        default: '示例标题'
    },
    template_name: {
        type: String,
        default: 'template_1'
    },
})
async function get_preview_cover() {
    try {
        const res = await fetch('https://www.sunyuanling.com/api/file/GetPreviewCover/', {
            method: 'post',
            headers:
                { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                token: token,
                template_name: props.template_name,
                title: props.title,
            })
        })
        if (res.ok) {
            const data = await res.json()
            if (data.status == 'success') {
                return data.cover_path;
            }
            else {
                console.log(data.message)
            }
        }
        else {
            console.log('网络错误' + res.status)
        }
    }
    catch (e) {
        console.log(e)
    }
}
</script>

<style scoped>
.preview_cover {
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column;
}

.cover_box {
    width: 30%;
    height: auto;
    display: flex;
    justify-content: center;
    align-items: center;
    margin: 10px auto;
    background-color: rgba(233, 233, 233, 1);
}
</style>
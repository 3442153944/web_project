<template>
    <div class="ill_recommend">
        <h2>插画推荐作品</h2>
        <div class="content">
            <div class="item" v-for="(item, index) in data" :key="index">
                <router-link :to="`/ill_content?id=${item.Illustration_id}`">
                    <div class="work_cover">
                        <img class="cover_img"
                            :src="'https://www.sunyuanling.com/server/static/image/thumbnail/' + item.content_file_list.split(/[,，]/)[0]">
                        <div class="page_count" v-if="item.content_file_list.split(/[,，]/).length > 1">
                            <img class="icon" src="https://www.sunyuanling.com/assets/page_count.svg">
                            {{ item.content_file_list.split(/[,，]/).length }}
                        </div>
                        <div class="age_tag" v-if="item.age_classification != 16">
                            R-{{ item.age_classification }}
                        </div>
                    </div>
                </router-link>
                <div class="work_info">
                    <span>{{ item.name }}</span>
                </div>
                <div class="author_info" @click="choose_user(item.author_info.userid)" v-if="item.author_info">
                    <div class="author_avatar">
                        <img class="author_avatar"
                            :src="'https://www.sunyuanling.com/server/static/image/avatar_thumbnail/' + item.author_info.user_avatar">
                    </div>
                    <div class="author_name">
                        {{ item.author_info.username }}
                    </div>
                </div>
            </div>
            <div class="check_point" ref="check_point"></div>
        </div>
    </div>
</template>

<script setup>
// 脚本部分保持不变
import { onMounted, onUnmounted, ref, defineProps } from 'vue'
import { useRouter } from 'vue-router'
import { BaseApi } from '@/base_api'

const props = defineProps({
    limit: {
        type: Number,
        default: 9
    },
    load_more: {
        type: Boolean,
        default: false
    }
})

const api = new BaseApi()
const data = ref(null)
const router = useRouter()
const limit = props.limit
let offset = 0
let total = 0
const check_point = ref(null)

const obs = new IntersectionObserver(entries => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            if (offset + limit < total && props.load_more) {
                offset += limit
                get_data()
            } else {
                obs.unobserve(entry.target)
            }
        }
    })
}, {
    root: null,
    rootMargin: '0px 0px 100px 0px',
    threshold: 0.1
})

const get_data = async () => {
    const res = await api.post('api/ReWork', {
        limit: limit,
        offset: offset,
        work_type: 'ill'
    })
    if (res.status == 200) {
        //console.log(res)
        data.value = res.result.data
        //获取作者信息
        for (let i=0;i<data.value.length;i++){
            let user_info=(await api.get_user_info(data.value[i].belong_to_user_id))
            if(user_info.status==200){
                data.value[i].author_info=user_info.result.data
            }
            else{
                data.value[i].author_info=null
                console.log('获取作者信息失败',user_info)
            }
        }
        total = res.result.total
    } else {
        console.log('获取失败', res)
    }
}
//用户中心跳转
const choose_user = (id) => {
    router.push({
        path: '/other_user_center',
        query: {
            id: id
        }
    })
}

onMounted(() => {
    get_data()
    obs.observe(check_point.value)
})

onUnmounted(() => {
    obs.disconnect()
})
</script>

<style scoped lang="scss">
.ill_recommend {
    width: 100%;
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;

    h2 {
        margin-bottom: 20px;
        font-size: 24px;
        color: #333;
    }
}

.content {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
    gap: 20px;
    justify-content: center;
}

.item {
    background-color: white;
    border-radius: 10px;
    padding: 15px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease;

    &:hover {
        transform: translateY(-5px);
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    }
}

.work_cover {
    position: relative;
    width: 100%;
    aspect-ratio: 1/1; /* 保持正方形比例 */
    border-radius: 8px;
    overflow: hidden;
    margin-bottom: 10px;
}

.cover_img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.3s ease;

    &:hover {
        transform: scale(1.05);
    }
}

.page_count {
    position: absolute;
    top: 8px;
    right: 8px;
    background-color: rgba(0, 0, 0, 0.7);
    color: white;
    padding: 4px 8px;
    border-radius: 4px;
    font-size: 12px;
    display: flex;
    align-items: center;
    gap: 4px;
}

.age_tag {
    position: absolute;
    top: 8px;
    left: 8px;
    background-color: #ff4757;
    color: white;
    font-size: 12px;
    font-weight: bold;
    padding: 4px 8px;
    border-radius: 4px;
}

.work_info {
    margin: 10px 0;
    font-weight: 500;
    font-size: 16px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.author_info {
    display: flex;
    align-items: center;
    gap: 10px;
    cursor: pointer;

    &:hover .author_name {
        color: #3498db;
    }
}

.author_avatar {
    width: 36px;
    height: 36px;
    border-radius: 50%;
    overflow: hidden;
    flex-shrink: 0;

    img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }
}

.author_name {
    font-size: 14px;
    color: #555;
    transition: color 0.3s ease;
}

.icon {
    width: 14px;
    height: 14px;
}

.check_point {
    display: block;
    width: 100%;
    height: 1px;
    opacity: 0;
    grid-column: 1 / -1;
}

/* 响应式调整 */
@media (max-width: 1024px) {
    .content {
        grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
    }
}

@media (max-width: 768px) {
    .content {
        grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
        gap: 15px;
    }
}

@media (max-width: 480px) {
    .content {
        grid-template-columns: 1fr;
    }
}
</style>
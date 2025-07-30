<template>
    <view class="user_box" v-if="is_loding">
        <view class="avatar">
            <image
                :src="BaseApi.avatar_url+(user_info.user_avatar??'default.jpg')"
                mode="aspectFit"
            />
        </view>
        <view class="info">
            <view class="work_name">
                <text>{{ work_name }}</text>
            </view>
            <view class="username">
                <text>{{ user_info.username }}</text>
            </view>
        </view>
    </view>
</template>

<script setup>
import { ref,onMounted,defineProps } from 'vue';
import BaseApi from '@/BaseApi';

const props =defineProps({
    work_name:String,
    userid:String
})

const user_info = ref(null);
const is_loding = ref(false);
onMounted(async () => {
    let data = await BaseApi.getUserInfoById(props.userid);
    user_info.value = JSON.parse(JSON.stringify(data));
    console.log('用户信息',user_info.value);
    is_loding.value = true;
})

</script>

<style lang="scss" scoped>
.user_box{
    display: flex;
    gap:10px;
    width: 100%;
    height: 70px;
    padding: 10px;
    align-items: center;
    justify-content: flex-start;
    border-top: 1px solid rgba(0,0,0,0.1);
}
.avatar{
    width:50px;
    height:50px;
    transition: all 0.2s ease-in-out;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 50%;
    image{
        width:calc(100% - 10px);
        height:calc(100% - 10px);
        border-radius: 50%;
    }
    &:active{
        image{
            transform: scale(0.9);
        }
    }
    &:focus{
        image{
            transform: scale(0.9);
        }
        outline: none;
        box-shadow: 0 0 0 2px #bdbdbd;
    }
}
.info{
    display: flex;
    flex-direction: column;
    gap:5px;
}

</style>
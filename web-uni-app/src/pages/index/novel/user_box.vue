<template>
    <view class="user_box" v-if="is_loding">
        <view class="user_avatar">
            <image :src="avatar_url+(user_info.user_avatar??'defalut.jpg')" mode=""></image>
        </view>
        <view class="user_name">
            {{ user_info.username }}
        </view>
</view>
</template>

<script setup>
import { ref,defineProps, onMounted, computed } from 'vue'
import BaseApi from '@/BaseApi';

const props = defineProps({
  user_id:String
})

const user_info=ref({})
const avatar_url=computed(()=>{
    return BaseApi.avatar_url
})
const is_loding=ref(false)

const get_user_info=async(user_id)=>{
    const res=await BaseApi.post("GetUserInfo/GetUserInfoById",{
        user_id:user_id
    })
    console.log("获取用户信息",res)
    if(res.code==200){
        return res.data
    }
    return null
}

onMounted(async()=>{
    user_info.value=await get_user_info(props.user_id)
    is_loding.value=true
})

</script>

<style lang="scss" scoped>
.user_box{ 
    display: flex;
    gap:5px;
    align-items: center;
    border-bottom: 1px solid #ccc;
    .user_avatar{
        width: 30px;
        height: 30px;
        image{
            width: 100%;
            height: 100%;
            border-radius: 50%;
        }
    }
}
</style>

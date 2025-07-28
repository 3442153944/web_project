<template>
    <view class="user_box">
        <view class="avatar">

        </view>
        <view class="info">
            <view class="work_name">
                <text></text>
            </view>
            <view class="username">
                <text></text>
            </view>
        </view>
    </view>
</template>

<script setup>
import { ref,onMounted,defineProps } from 'vue';

const props =defineProps({
    work_name:String,
})

</script>

<style lang="scss" scoped>

</style>
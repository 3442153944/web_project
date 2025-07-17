<template>
    <view>
        其他用户用户中心
    </view>
</template>

<script setup>
import { useStore } from '@/store';
import {ref,computed} from 'vue'

const store = useStore();
const user_id=computed(()=>{return store.$state.other_user_id})

</script>
<style lang="scss" scoped>

</style>
<script setup>
import { defineProps } from 'vue';

const props=defineProps({work_id:String})

</script>

<template>
  <view>
    插画内容页
    <view>插画id:{{props.work_id}}</view>
  </view>
</template>

<style scoped></style>
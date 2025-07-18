<template>
    <div class="content">
        <ill_index v-if="page_info.work_type=='ill'" :work_id="page_info.work_id" :key="'ill_'+page_info.work_id"></ill_index>
        <comic_index v-if="page_info.work_type=='comic'" :key="'comic_'+page_info.work_id"></comic_index>
        <novel_index v-if="page_info.work_type=='novel'" :key="'novel_'+page_info.work_id"></novel_index>
    </div>
</template>

<script setup>
import {computed, ref, watchEffect} from 'vue'
import baseApi from "@/BaseApi";
import {useStore} from "@/store";
import ill_index from "./ill/ill_index.vue"
import comic_index from "./comic/comic_index.vue"
import novel_index from "./novel/novel_index.vue"

const store = useStore()
const page_info=computed(()=>{return store.$state.jump_page_info})

</script>

<style lang="scss" scoped>

</style>
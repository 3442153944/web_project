<template>
    <div class="novel_index">
        <div class="close_page" @click="close_page_click()">
            退出当前页面
        </div>
        小说页面{{ work_id }}
    </div>
</template>

<script setup>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted ,defineProps,defineEmits} from 'vue';
import {useStore} from 'vuex';
const store = useStore()
let work_id=ref('')
let props=defineProps({
    work_id:{
        type:String,
        default:'1'
    }
})
watch(()=>props.work_id,(newValue)=>{
    work_id.value=newValue
})
function close_page_click(){
    store.commit('SET_CONTENT_PAGE',{key:'ill_page',value:false})
    store.commit('SET_SINGLE_PAGE_STATUS',{key:'index_page',value:true})
}
watch(()=>store.getters.work_id,(newValue)=>{
    work_id.value=newValue
})
onMounted(()=>{
    work_id.value=store.getters.work_id
})
</script>

<style scoped></style>
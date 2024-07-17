<template>
  <div class="index">
    <div class="close_btn" @click="close_upload_page()">
        <img class="icon" src="https://www.sunyuanling.com/assets/close.svg">
    </div>
    <ill_page v-if="type=='ill'"></ill_page>
    <comic_page v-else-if="type=='comic'"></comic_page>
    <novel_page v-else-if="type=='novel'"></novel_page>
  </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted,defineEmits } from 'vue';
import ill_page from './ill/ill_page.vue';
import comic_page from './comic/comic_page.vue';
import novel_page from './novel/novel_page.vue';
import{useStore } from 'vuex'
export default {
  // eslint-disable-next-line vue/multi-word-component-names
  name: 'index',
  components:{
    ill_page,comic_page,novel_page
  }
}
</script>

<script setup>
const store=useStore()
let type=ref();
function close_upload_page()
{
    store.commit('SET_SINGLE_PAGE_STATUS',{key:'upload_work',value:false})
}
watch(()=>store.getters.upload_work_type,(newValue)=>{
    type.value=newValue;
    console.log(newValue)
})
onMounted(()=>{
    type.value=store.getters.upload_work_type;
})
</script>

<style scoped>
  .icon{
    width: 25px;
    height: 25px;
    object-fit: cover;
  }
  .index{
    width: 100vw;
    min-height: 90vh;
    height: 100%;
    display: flex;
    z-index: 15;
    background-color: rgba(255, 255, 255, 1);
    position: fixed;
    top: 65px;
    left: 0px;
  }
</style>
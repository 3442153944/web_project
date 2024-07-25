<template>
  <div class="ill_index">
    <go_back></go_back>
    <div class="content" v-if="work_info">
        <div class="item_box" >
            <div class="item" v-for="(item,index) in work_info.content_file_list.split(/[,，]/)" :key="index">
                <img :src="'https://www.sunyuanling.com/image/'+item" class="item_img">
            </div>
        </div>
    </div>
  </div>
</template>

<script setup>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted ,defineProps,defineEmits} from 'vue';
import {useStore} from 'vuex';
import go_back from '../go_back.vue'
const store = useStore()
let work_id=ref('')
let work_info=ref()
let props=defineProps({
    work_id:{
        type:String,
        default:'1'
    }
})
watch(()=>props.work_id,(newValue)=>{
    work_id.value=newValue
})
// eslint-disable-next-line no-unused-vars
function close_page_click(){
    store.commit('SET_CONTENT_PAGE',{key:'ill_page',value:false})
    store.commit('SET_SINGLE_PAGE_STATUS',{key:'index_page',value:true})
}

watch(()=>store.getters.work_id,(newValue)=>{
    work_id.value=newValue
})
onMounted(async()=>{
    work_id.value=store.getters.work_id;
    await get_work_info();
    console.log(work_info.value);
})
//使用ID请求作品信息
async function get_work_info(){
    try{
        const res=await fetch('https://www.sunyuanling.com/api/get_work_info/GetIllInfo/',{
            method:'post',
            headers:{
                'Content-Type':'application/json',
            },
            body:JSON.stringify({
                work_id:work_id.value
            })
        })
        if(res.ok)
        {
            const data=await res.json()
            if(data.status=='success')
            {
                work_info.value=data.data[0]
            }
            else{
                console.log(data.message)
            }
        }
    }
    catch(e)
    {
        console.log(e)
    }
}
</script>

<style scoped>
  .ill_index{
    display: flex;
    flex-direction: column;
    width: 80%;
    height: auto;
    margin: 10px auto;
    background-color: rgba(0,0,0,0.05);
    border-radius: 10px;
  }
  .content{
    display: flex;
    flex-direction: column;
    width: 100%;
    height: 100%;
    padding: 10px;
    position: relative;
    gap: 10px;
  }
  .item_box{
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column;
    gap: 10px;
  }
  .item{
    display: flex;
    width: 100%;
    height: auto;
  }
  .item_img{
    width: 100%;
    height: 100%;
    object-fit: cover;
  }
</style>
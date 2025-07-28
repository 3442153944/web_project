<script setup>
import { defineProps,ref,onMounted } from 'vue';
import BaseApi from '@/BaseApi';

const props=defineProps({work_id:String})
const work_info=ref()
const img_url=ref(BaseApi.IMG_URL)
const get_work_info=async()=>{ 
  try{
    const res=await BaseApi.post('get_work_info/GetIllInfo/',{
      work_id:props.work_id
    })
    console.log('插画内容页',res)
    if(res.code==200){
      let data=res.data[0]
      data.content_file_list=data.content_file_list.split(/[,，]+/).map(f=>f.trim())
      work_info.value=data
    }
  }
  catch(e){
    console.log(e)
    return null;
  }
}
onMounted(()=>{ 
  get_work_info()
  
})

</script>

<template>
  <view>
    插画内容页
    <view>插画id:{{props.work_id}}</view>
    <view class="work_content">
      <view class="item" v-for="(item,index) in work_info.content_file_list" :key="index">
        <image
          :src="img_url+item"
          mode="aspectFill"
        />
      </view>
    </view>
  </view>
</template>

<style scoped></style>
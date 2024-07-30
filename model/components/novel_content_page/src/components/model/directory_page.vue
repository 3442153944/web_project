<template>
  <div class="directory_page">
    <div class="content">
      <div class="item_box">
        <div class="item" v-for="(item,index) in work_info" :key="index">
            <div class="item_content">{{item.title}}</div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref ,defineProps} from 'vue'
let props=defineProps({
  work_info:{
    type:Array,
    default:()=>{
      return[]
    }
  },
})
</script>

<style scoped>
  .directory_page{
    width: 100%;
    height: auto;
    display: flex;
    border-radius: 10px;
    box-shadow: 5px -3px 10px rgba(0, 0, 0, 0.5);
    padding: 5px;
    min-width: 100px;
    min-height: 30px;
  }
</style>
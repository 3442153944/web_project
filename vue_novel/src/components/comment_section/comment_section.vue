<template>
    
    <div class="comment_section">
        <h1 class="section_title">评论</h1>
        <div class=""></div>
    </div>
</template>
<script lang="ts">
import { ref } from 'vue'
export default {
    name: 'comment_section',
    data(){
        return {
           
        }
    },
}
</script>
<script setup lang="ts">

</script>
<style  scoped>
.comment_section{
    display: flex;
    margin-top:20px;
    padding:5px;
    width:80%;
    margin-left:auto;
    margin-right: auto;
    border:1px solid red;
    border-radius: 10px;
    background-color: rgba(233,233,233,1);
}
.section_title{
    display: flex;
    margin-top:5px;

}
</style>
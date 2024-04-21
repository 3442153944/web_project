<!-- eslint-disable vue/multi-word-component-names -->
<template>
    <div class="sidebar">
        <div class="title"><span>首页</span></div>
        <div class="sidebar_content">
            <div class="sidebar_content_item">
                <div class="sidebar_content_item_icon"></div>
                <div class="sidebar_content_item_text"><span>插画</span></div>
            </div>
        </div>
    </div>
</template>
<script>
import { ref } from 'vue'
export default {
    // eslint-disable-next-line vue/multi-word-component-names
    name: 'sidebar'
}
</script>
<script setup>

</script>

<style scoped>
.title{
    font-size: 18px;
    color:rgb(148, 148, 148);
    margin-top:10px;
    align-content: center;
    font-weight: bold;
    margin-bottom: 5px;
    border-bottom: 1px solid rgb(255, 255, 255);
}
 .sidebar{
    display: flex;
    position:fixed;
    flex-direction:column;
    width:210px;
    height: 100%;
    padding:5px;
    background-color: rgb(241, 241, 241);
}
.sidebar_content{
    display: flex;
    flex-direction: column;
    width:90%;
    height: auto;
    justify-content: center;
    padding:5px;
}
.sidebar_content_item{
    display: flex;
    width:100%;
    height: 40px;
    margin-top:5px;
    justify-content: center;
    align-items: center;
}
.sidebar_content_item:hover{
    background-color: rgb(148, 148, 148);
    border-radius: 5px;
    cursor: pointer;
    transition: 0.2s;
}
</style>
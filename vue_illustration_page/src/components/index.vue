<template>
<div class="index">
    <illustration_box></illustration_box>
    <user_box></user_box>
</div>
</template>
<script>
import {ref,onMounted,onUnmounted,watch} from 'vue';
import illustration_box from './illustration_box/illustration_box.vue'
import user_box from './user_box/user_box.vue'
export default{
    name:'index',
    components:{illustration_box,user_box},
}
</script>
<script setup>

</script>
<style scoped>
.index{
    display: flex;
    width:80%;
    height: auto;
    margin:20px auto;
}
</style>
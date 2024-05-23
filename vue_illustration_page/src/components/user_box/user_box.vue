<template>
    <div class="user_box">
        用户信息盒子
    </div>
</template>

<script>
import {ref,onMounted,onUnmounted,reactive,watch} from 'vue'
export default{
    name:'user_box',

}
</script>

<script setup>

</script>

<style scoped>
.user_box{
    display: flex;
    flex-grow: 1;
    width:100%;
    height: auto;
    flex-direction: column;
}
</style>
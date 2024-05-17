<template>
    <div class="recommendation">
        <h3>推荐的用户作品</h3>
    </div>
</template>
<script>
import {ref,onMounted,onUnmounted,watch} from 'vue'
export default{
    name:'recommendation',
}
</script>
<script setup>

</script>
<style scoped>
.recommendation{
    display: flex;
    flex-direction: column;
    margin-top:20px;
    width:80%;
    height: auto;
    position: relative;
    margin:40px auto;
}
</style>
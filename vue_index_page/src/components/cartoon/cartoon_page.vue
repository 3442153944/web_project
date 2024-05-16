<template>
  <div class="cartoon_page">
    <h3>已关注用户作品</h3>
    <div class="cartoon_list">
        <div class="cartoon_item">
            <div class="cartoon_img">
                <div class="age_tag"></div>
                <div class="page_count"></div>
                <img>
            </div>
            <div class="cartoon_title">

            </div>
            <div class="user_info">
                <div class="user_avatar"></div>
                <div class="username"></div>
            </div>
        </div>
    </div>
  </div>
</template>

<script>
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted } from 'vue';
export default {
  name: 'cartoon_page',
}
</script>

<script setup>
</script>

<style scoped>
  .cartoon_page{
    display: flex;
    flex-direction: column;
    width: 80%;
    height: auto;
    margin: 0 auto;
    margin-top: 20px;
  }
</style>
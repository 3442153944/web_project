<template>
    <go_back></go_back>
  <div class="br_his_index_page">
    <div class="content">
        <h1>浏览历史</h1>
    </div>
  </div>
</template>
<script setup>
import {ref} from 'vue'
import { useStore } from 'vuex';
import go_back from './go_back.vue'

const store = useStore()

</script>

<style scoped>
  
</style>
<template>
  <div class="add_select_page">
    <div class="content">
        <div class="title">
            <span></span>
            <span><b>新增精选作品</b></span>
            <div class="close_btn" @click="close_btn">
                <img class="icon" src="https://www.sunyuanling.com/assets/close.svg">
            </div>
        </div>
    </div>
  </div>
</template>

<script setup>
import { ref, defineProps, onMounted ,defineEmits} from 'vue';

const props = defineProps({
  user_info: {
    type: Object,
    default: () => ({})
  },
  token: {
    type: String,
    default: ''
  }
})
const emit=defineEmits(['close_page'])
function close_btn() {
  emit('close_page',false)
}
</script>

<style scoped>
  
</style>
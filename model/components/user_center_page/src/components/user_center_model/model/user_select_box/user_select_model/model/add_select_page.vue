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
.add_select_page{
    position: fixed;
    top: 0;
    left: 0;
    width: 100vw;
    height: 100vh;
    max-height: 100vh;
    background-color: rgba(0, 0, 0, 0.5);
    z-index: 10;
    display: flex;
    align-items: center;
    justify-content: center;
    overflow-y: auto;
}
.content{
    width: auto;
    height: auto;
    display: flex;
    flex-direction: column;
    min-width: 300px;
    min-height: 100px;
    background-color: white;
    border-radius: 15px;
    padding: 10px;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.5);
    overflow-y: auto;
}
.content::-webkit-scrollbar {
    width: 0px;
}
.title{
    width: 100%;
    height: auto;
    padding: 5px 0px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}
.icon{
    width: 25px;
    height: 25px;
    object-fit: cover;
}
.close_btn{
    width: 35px;
    height: 35px;
    display: flex;
    justify-content: center;
    align-items: center;
}
.close_btn:hover{
    cursor: pointer;
    transform: scale(1.1);
    transition: all 0.2s ease-in-out;
    background-color: rgba(133, 133, 133, 0.5);
    border-radius: 50%;
}
</style>
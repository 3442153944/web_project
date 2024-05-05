<template>
  <div class="word_content">
    <p v-html="word"></p>
  </div>
</template>

<script lang="ts">
// eslint-disable-next-line no-unused-vars
import { ref, reactive, toRefs, watch, onMounted, onUnmounted, Ref, watchEffect } from 'vue';
export default {
  name: 'word_content',
}
</script>

<script setup lang="ts">
let word = ref(`最近发生了不少事情，也让我对某些事情有了一点新的体验，同时也带来了不少的灵感。
`);


 function set_word(){
   
   word.value= localStorage.getItem('word_content');
}

onMounted(()=>{
 set_word();
})

function get_cookie(name) {
    let cookies = document.cookie.split('; ')
    for (let i = 0; i < cookies.length; i++) {
        let cookie = cookies[i].split('=');
        if (cookie[0] === name) {
            return cookie[1];
        }
    }
    return null; // Cookie not found
}

</script>

<style scoped>
  .word_content{
    display: flex;
    width:80%;
    height: auto;
    font-size: 18px;
    line-height: 1.8;
    font-weight: 500;
    justify-content: center;
    align-self: center;
    margin-top:20px;
  }
  .word_content span, p{
    text-indent: 2em;
  }
</style>
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

let work_name=ref('');
let work_id=ref('');
let title=ref('');
let temp=ref('');
//获取标题
 function get_title(){
   title.value= get_cookie('work_title');
   temp.value=title.value;
  work_name.value= get_cookie('work_name');
  work_id.value= get_cookie('work_id');
  console.log(work_name.value+'name');
  console.log(title.value+'title');
  get_content();
}
console.log(temp.value+'temp');
onMounted(()=>{
  get_title();
})
async function get_content(){
  let title=await get_cookie('work_title');
  const res=await fetch('/api/get_novel_content',{
    method:'POST',
    headers:{
      'Content-Type':'application/json'
    },
    body:JSON.stringify({
      work_title:get_cookie('work_title'),
      work_name:work_name.value,
      work_id:work_id.value
    })
  })
  const data=await res.json();
  let temp;
  temp=data.work_content;
  //temp=temp.replace(/<br>/g,"\n");
  console.log(temp);
  word.value=temp;
  console.log(data)
  //console.log(data.work_content);
}

watchEffect(()=>{
  let cookie=get_cookie('work_title');
  get_content();
})

onUnmounted(()=>{})

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
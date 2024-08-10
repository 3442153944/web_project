<!-- eslint-disable vue/multi-word-component-names -->
<script setup>
// eslint-disable-next-line no-unused-vars
import { ref,defineProps} from 'vue'
import index_page from './modle/index.vue'

defineProps({
 token: {
    type: String,
    default: 'sunyuanling'
  },
  work_type:{
    type:String,
    default:'ill'
  }
})

</script>

<template>
  <div class="recommend">
    推荐页
    <index_page :token="token" :work_type="work_type"></index_page>
  </div>
</template>

<style scoped>

</style>

<template>
  <div class="collect_page">
    收藏
  </div>
</template>

<script setup>
import { ref, defineProps ,onMounted} from 'vue'
import { get_user_collect_worklist } from '../../../js/get_workinfo'
const props = defineProps({
  user_info: {
    type: Object,
    default: () => {
      return {}
    }
  },
  token: {
    type: String,
    default: ''
  }
  }
)
let collect_worklist = ref([])
onMounted(async () => {
  collect_worklist.value=await get_user_collect_worklist(props.token)
  console.log(collect_worklist.value)
})
</script>

<style scoped></style>
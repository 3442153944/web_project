<template>
    <div class="user_index_select">
        <div class="title">
            <span><b>精选</b></span>
        </div>
    </div>
</template>

<script setup>
import { ref, defineProps } from 'vue'
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
})
</script>

<style scoped></style>
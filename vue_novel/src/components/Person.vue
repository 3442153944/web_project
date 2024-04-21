<!-- eslint-disable vue/multi-word-component-names -->
<template>
    <div class="person">
        <h1>{{ name }}</h1>
        <h1>{{ age }}</h1>
        <div @click="addage">addage</div>
    </div>
</template>

<script>
import { ref } from 'vue'
export default {

    // eslint-disable-next-line vue/multi-word-component-names
    name: 'Person',


}
</script>
<script setup>
let age = ref(18)
let name = ref('test')
function addage() {
    age.value++
}
</script>

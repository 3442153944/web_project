<!-- eslint-disable vue/no-unused-components -->
<template>
    
        <head_title></head_title>
        <novel_content></novel_content>
    
</template>
<script  lang="ts">
// @ts-ignore
import head_title from './components/head_title.vue'
import novel_content from './components/novel_content.vue'
export default{
    name:'App',
    components:{
        // eslint-disable-next-line vue/no-unused-components
        head_title,novel_content,
    }
}

</script>
<style>
body{
    padding:0;
    margin:0;

}
</style>
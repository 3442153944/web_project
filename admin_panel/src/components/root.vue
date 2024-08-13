<!-- eslint-disable vue/multi-word-component-names -->
<script setup>
import { ref, defineProps, computed } from 'vue'
import { useStore } from 'vuex'
import login_page from './model/login_page.vue';
import user_control_page from './model/user_control.vue'
import ill_control_page from './model/ill_control.vue'
import comic_control_page from './model/comic_control.vue'
import novel_control_page from './model/novel_control.vue'
import header_page from './model/header_page.vue';
import sidebar from './model/sidebar.vue'
import commection_control from './model/commection_control.vue';

let token = ref('')
const store = useStore()
let user_control_page_show = computed(() => store.getters.root_page.user_control_page)
let ill_control_page_show = computed(() => store.getters.root_page.ill_control_page)
let comic_control_page_show = computed(() => store.getters.root_page.comic_control_page)
let novel_control_page_show = computed(() => store.getters.root_page.novel_control_page)
let login_page_show = computed(() => store.getters.root_page.login_page)
let commection_control_page_show = computed(() => store.getters.root_page.commection_control_page)
let store_token_show = computed(() => store.getters.root_data.token)

</script>

<template>
  <div class="root">

    <div class="content">
      <div class="header">
        <header_page></header_page>
      </div>

      <div class="main_item">
        <div class="sidebar_item">
          <div class="sidebar">
            <sidebar></sidebar>
          </div>
        </div>
        <div class="page_item">
          <h1>后台管理</h1>
          <user_control_page v-if="user_control_page_show"></user_control_page>
          <ill_control_page v-if="ill_control_page_show"></ill_control_page>
          <comic_control_page v-if="comic_control_page_show"></comic_control_page>
          <novel_control_page v-if="novel_control_page_show"></novel_control_page>
          <commection_control v-if="commection_control_page_show"></commection_control>
        </div>

      </div>
    </div>
    <login_page v-if="login_page_show"></login_page>
  </div>
</template>

<style scoped>
.root {
  width: 100vw;
  height: 100vh;
  background-color: rgba(243, 243, 243, 1);
  position: relative;
  display: flex;
}

.content {
  width: 100%;
  height: 100%;
  display: flex;
}

.header {
  position: fixed;
  top: 5px;
  left: 0;
  width: 95%;
  margin: 0px auto;
}

.main_item {
  width: 100%;
  height: 100%;
  margin-top: 70px;
  max-height: calc(100% - 70px);
  display: flex;
  position: relative;
}

.sidebar_item {
  width: 20%;
  height: auto;
  margin-left: 5px;
}
.page_item{
  width: auto;
  flex-grow: 1;
  flex:1;
  margin-left: 10px;
}
</style>

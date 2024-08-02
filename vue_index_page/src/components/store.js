import { createStore } from 'vuex';
import * as cookies from 'H:/web_project/model/cookies.js';

const MAX_STACK_DEPTH = 500; // 设置栈的最大深度

const store = createStore({
  state: {
    pageStatus: {
      upload_work: false,
      upload_work_type: '',
      index_page: true,
      indexPage: 0,
      search_page: false,
      chat_page: false,
      content_index_page: false,
    },
    content_page: {
      ill_page: false,
      comic_page: false,
      novel_page: false,
      img_content_page: false,
      item_path:'',
    },
    token: cookies.get_cookie('token'),
    userinfo: {},
    work_id: '',
    work_type:'',
    pageStack: [],
    pushTimer: null, // 添加定时器
  },
  mutations: {
    SET_USERINFO(state, userinfo) { state.userinfo = userinfo; },
    SET_TOKEN(state, token) { state.token = token; },
    SET_PAGESTATUS(state, pageStatus) { state.pageStatus = { ...state.pageStatus, ...pageStatus }; },
    SET_UPLOAD_WORK(state, upload_work) { state.pageStatus.upload_work = upload_work; },
    SET_UPLOAD_WORK_TYPE(state, upload_work_type) { state.pageStatus.upload_work_type = upload_work_type; },
    SET_INDEX_PAGE(state, index_page) { state.pageStatus.index_page = index_page; },
    SET_KEY(state, { key, value }) { state.pageStatus[key] = value; },
    SET_INDEXPAGE(state, value) { state.pageStatus.indexPage = value; },
    SET_SEARCH_PAGE(state, search_page) { state.pageStatus.search_page = search_page; },
    SET_SINGLE_PAGE_STATUS(state, { key, value }) {
      if (key === 'all') {
        for (const k in state.pageStatus) {
          if (Object.prototype.hasOwnProperty.call(state.pageStatus, k) && typeof state.pageStatus[k] === 'boolean') {
            state.pageStatus[k] = false;
          }
        }
        return;
      }
      for (const k in state.pageStatus) {
        if (Object.prototype.hasOwnProperty.call(state.pageStatus, k) && typeof state.pageStatus[k] === 'boolean') {
          state.pageStatus[k] = false;
        }
      }
      state.pageStatus[key] = value;
      const allFalse = Object.keys(state.pageStatus).every(k => typeof state.pageStatus[k] !== 'boolean' || state.pageStatus[k] === false);
      if (allFalse) {
        state.pageStatus.index_page = true;
      }
    },
    SET_CONTENT_PAGE(state, { key, value }) {
      for (const k in state.content_page) {
        if (Object.prototype.hasOwnProperty.call(state.content_page, k) && typeof state.content_page[k] === 'boolean') {
          state.content_page[k] = false;
        }
      }
      state.content_page[key] = value;
    },
    SET_WORK_ID(state, work_id) { state.work_id = work_id; },
    // 将当前页面状态压入栈
    PUSH_PAGE_STATE(state) {
      if (state.pageStack.length >= MAX_STACK_DEPTH) {
        state.pageStack.shift(); // 删除最早的记录
      }
      state.pageStack.push({
        pageStatus: JSON.parse(JSON.stringify(state.pageStatus)),
        content_page: JSON.parse(JSON.stringify(state.content_page)),
      });
    },
    // 返回上一级时弹出栈并恢复状态
    POP_PAGE_STATE(state) {
      if (state.pageStack.length > 0) {
        const previousState = state.pageStack.pop();
        state.pageStatus = previousState.pageStatus;
        state.content_page = previousState.content_page;
      }
    },
    // 重置页面栈
    RESET_PAGE_STACK(state) {
      state.pageStack = [];
      state.pushTimer = null; // 清除定时器
    },
    SET_ITEM_PATH(state, path) {
      state.content_page.item_path = path;
    },
    //设置作品类型
    SET_WORK_TYPE(state, work_type) {
      state.work_type = work_type;
    },
  },
  actions: {
    goBack({ commit }) {
      commit('POP_PAGE_STATE'); // 恢复上一个状态
    }
  },
  getters: {
    userinfo: state => state.userinfo,
    token: state => state.token,
    upload_work: state => state.pageStatus.upload_work,
    upload_work_type: state => state.pageStatus.upload_work_type,
    index_page: state => state.pageStatus.index_page,
    indexPage: state => state.pageStatus.indexPage,
    search_page: state => state.pageStatus.search_page,
    chat_page: state => state.pageStatus.chat_page,
    ill_page: state => state.content_page.ill_page,
    comic_page: state => state.content_page.comic_page,
    novel_page: state => state.content_page.novel_page,
    work_id: state => state.work_id,
    img_content_page: state => state.content_page.img_content_page,
    content_index_page: state => state.pageStatus.content_index_page,
    pageStack: state => state.pageStack,
    item_path:state=>state.content_page.item_path,
    work_type:state=>state.work_type,
  },
});

export default store;
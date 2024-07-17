import { createStore } from 'vuex';
import * as cookies from 'H:/web_project/model/cookies.js';

const store = createStore({
  state: {
    pageStatus: {
      upload_work: false,
      upload_work_type: '',
      index_page: true,
      indexPage: 0,
      search_page: false,
      chat_page: false,
    },
    token: cookies.get_cookie('token'),
    userinfo: {},
  },
  mutations: {
    SET_USERINFO(state, userinfo) { state.userinfo = userinfo; },
    SET_TOKEN(state, token) { state.token = token; },
    SET_PAGESTATUS(state, pageStatus) { state.pageStatus = { ...state.pageStatus, ...pageStatus }; console.log(state.pageStatus); },
    SET_UPLOAD_WORK(state, upload_work) { state.pageStatus.upload_work = upload_work; },
    SET_UPLOAD_WORK_TYPE(state, upload_work_type) { state.pageStatus.upload_work_type = upload_work_type; },
    SET_INDEX_PAGE(state, index_page) { state.pageStatus.index_page = index_page; },
    SET_KEY(state, key, value) { state.pageStatus[key] = value; },
    SET_INDEXPAGE(state, value) { state.pageStatus.indexPage = value; },
    SET_SEARCH_PAGE(state, search_page) { state.pageStatus.search_page = search_page; },
    SET_SINGLE_PAGE_STATUS(state, { key, value }) {
      for (const k in state.pageStatus) {
        if (Object.prototype.hasOwnProperty.call(state.pageStatus, k) && typeof state.pageStatus[k] === 'boolean') {
          state.pageStatus[k] = false;
        }
      }
      state.pageStatus[key] = value;
      // 如果所有布尔值都为 false，则将 index_page 设置为 true
      const allFalse = Object.keys(state.pageStatus).every(k => typeof state.pageStatus[k] !== 'boolean' || state.pageStatus[k] === false);
      if (allFalse) {
        state.pageStatus.index_page = true;
      }
    },
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
  },
});

export default store;

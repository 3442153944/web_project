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
    content_page:{
      ill_page:false,
      comic_page:false,
      novel_page:false,
    },
    token: cookies.get_cookie('token'),
    userinfo: {},
    work_id:'',
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
      if(key=='all')
      {
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
      // 如果所有布尔值都为 false，则将 index_page 设置为 true
      const allFalse = Object.keys(state.pageStatus).every(k => typeof state.pageStatus[k] !== 'boolean' || state.pageStatus[k] === false);
      if (allFalse) {
        state.pageStatus.index_page = true;
      }
    },
    SET_CONTENT_PAGE(state,{key,value}){
      for (const k in state.content_page) {
        if (Object.prototype.hasOwnProperty.call(state.content_page, k) && typeof state.content_page[k] === 'boolean') {
          state.content_page[k] = false;
        }
      }
      state.content_page[key] = value;
    },
    SET_WORK_ID(state, work_id) { state.work_id = work_id;console.log(state) },
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
  },
});

export default store;
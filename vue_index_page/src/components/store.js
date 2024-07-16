import { createStore } from 'vuex';
import * as cookies from 'H:/web_project/model/cookies.js';

const store = createStore({
  state: {
    pageStatus: {
      upload_work: false,
      upload_work_type: '',
      index_page: true,
      indexPage:0,
    },
    token: cookies.get_cookie('token'),
    userinfo: {},
  },
  mutations: {
    SET_USERINFO(state, userinfo) {
      state.userinfo = userinfo;
    },
    SET_TOKEN(state, token) {
      state.token = token;
    },
    SET_PAGESTATUS(state, pageStatus) {
      state.pageStatus = { ...state.pageStatus, ...pageStatus };
      console.log(state.pageStatus);
    },
    SET_UPLOAD_WORK(state, upload_work) {
      state.pageStatus.upload_work = upload_work;
      console.log(state.pageStatus.upload_work);
    },
    SET_UPLOAD_WORK_TYPE(state, upload_work_type) {
      state.pageStatus.upload_work_type = upload_work_type;
      console.log(state.pageStatus.upload_work_type);
    },
    SET_INDEX_PAGE(state, index_page) {
      state.pageStatus.index_page = index_page;
      console.log(state.pageStatus.index_page);
    },
    SET_KEY(state,key,value){
      state.pageStatus[key]=value;
      console.log(state.pageStatus[key]);
    },
    SET_INDEXPAGE(state,value)
    {
      state.pageStatus.indexPage=value;
      console.log(state.pageStatus.indexPage);
    }
  },
  getters: {
    userinfo: state => state.userinfo,
    token: state => state.token,
    upload_work: state => state.pageStatus.upload_work,
    upload_work_type: state => state.pageStatus.upload_work_type,
    index_page: state => state.pageStatus.index_page,
    indexPage: state => state.pageStatus.indexPage,
  },
});

export default store;

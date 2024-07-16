import { createStore } from 'vuex';
import * as cookies from 'H:/web_project/model/cookies.js';

const store = createStore({
  state: {
    pageStatus: {
      indexPage: 0,
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
      state.pageStatus = pageStatus;
      console.log(state.pageStatus);
    },
  },
  actions: {
    async getUserInfo({ commit, state }) {
      try {
        const res = await fetch('https://www.sunyuanling.com/GetUserInfo/GetAllUserInfo/', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({
            token: state.token,
            userid: null,
          }),
          credentials: 'include', 
        });
        if (res.ok) {
          const data = await res.json();
          if (data.status === 'success') {
            commit('SET_USERINFO', data.data[0]);
          } else {
            console.log(data.message);
          }
        } else {
          console.log('请求失败');
        }
      } catch (e) {
        console.log(e);
      }
    },
  },
  getters: {
    userinfo: state => state.userinfo,
    token: state => state.token,
    indexPage: state => state.pageStatus.indexPage,
  },
});

export default store;

import { createStore } from 'vuex';

const store = createStore({
    state: {
        root_page: {
            user_control_page: true, 
            ill_control_page: false,
            comic_control_page: false,
            novel_control_page: false,
            login_page: false,
            commection_control_page: false,
        },
        root_data: {
            token: ''
        },
    },
    mutations: {
        change_page(state, { page_key, page_value }) {
            // 将所有页面的状态设置为 false
            Object.keys(state.root_page).forEach(key => {
                state.root_page[key] = false;
            });

            // 设置指定页面的状态
            state.root_page[page_key] = page_value;

            // 检查是否所有页面都为 false
            const allFalse = Object.values(state.root_page).every(value => value === false);

            // 如果所有页面都为 false，默认显示插画审核页面
            if (allFalse) {
                state.root_page.ill_control_page = true;
            }
        },
        set_root_data(state, { key, value }) {
            state.root_data[key] = value;
        }
    },
    actions: {},
    modules: {},
    getters: {
        root_page: state => state.root_page,
        root_data: state => state.root_data
    }
});

export default store;

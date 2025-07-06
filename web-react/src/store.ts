import { create } from "zustand/react";

// 单独定义默认空用户（放 constants.ts 或 store.ts 顶部）
const defaultUserInfo: UserInfo = {
    id: 0,
    username: "",
    user_self_introduction: "",
    user_self_website: "",
    user_address: "",
    birthday: null,
    occupation: "",
    userid: "",
    user_avatar: "",
    user_back_img: "",
    sex: "",
    email: "",
    phone: "",
    user_following: "",
    user_fans: "",
    collected_ill_work: undefined,
    collected_ill_work_id: "",
    collected_novel_works: undefined,
    collected_novel_works_id: "",
    like_novel_works: undefined,
    like_novel_works_id: "",
    watch_novel_list: undefined,
    watch_novel_list_id: "",
    select_work: "",
    token: "",
    token_createtime: "",
    token_effective: "0",
    token_expiry: "",
    vip: "0",
    vip_last_date: "",
    account_status: "0",
    account_permissions: "",
    user_register: "",
    per: "",
    last_login: null,
    ip_address: null,
    role: "",
};


interface UserInfo {
    id: number;
    username: string;
    user_self_introduction: string;
    user_self_website: string;
    user_address: string;
    birthday: string | null;
    occupation: string;
    userid: string;
    user_avatar: string;
    user_back_img: string;
    sex: "男" | "女" | string;
    email: string;
    phone: string;

    user_following: string;  // 如需数组可改为 string[]
    user_fans: string;

    collected_ill_work: unknown; // null，暂不清楚具体结构
    collected_ill_work_id: string; // "1,2,3"；如要拆分为数组建议：string[]

    collected_novel_works: unknown;
    collected_novel_works_id: number | string; // 接口返回有时是 1，有时是 "1,2,3"，后期建议统一

    like_novel_works: unknown;
    like_novel_works_id: number | string;

    watch_novel_list: unknown;
    watch_novel_list_id: string;

    select_work: string; // 实际是 JSON 字符串，可 parse 为对象：{ ill: number[], comic: number[], novel: number[] }

    token: string;
    token_createtime: string;
    token_effective: "0" | "1";
    token_expiry: string;

    vip: "0" | "1";
    vip_last_date: string;

    account_status: "0" | "1";
    account_permissions: string;
    user_register: string;

    per: string;
    last_login: string | null;
    ip_address: string | null;

    role: "user" | "admin" | "super_admin" | string;
}

interface StoreState {
    user_info: UserInfo;
    is_login: boolean;
    is_vip:boolean;

    setUserInfo: (key: string, value: unknown) => void;
    setUserInfoByObj: (obj: UserInfo) => void;
    clearUserInfo: () => void;

    setLogin: (flag: boolean) => void;
    getLogin: () => boolean;
    getUserInfo: () => UserInfo;

    setIsVip(b: boolean): void;
    getIsVip(): boolean;
}

const useStore = create<StoreState>((set, get) => ({
    user_info: {...defaultUserInfo},
    is_login: false,
    is_vip: false,

    setUserInfo: (key: string, value: unknown) =>
        set((state) => ({
            user_info: { ...state.user_info, [key]: value },
        })),

    setUserInfoByObj: (obj: UserInfo) =>
        set((state) => ({
            user_info: { ...state.user_info, ...obj },
        })),
    setIsVip: (flag: boolean) => set({ is_vip: flag}),

    clearUserInfo: () => set({ user_info: {...defaultUserInfo} }),

    setLogin: (flag: boolean) => set({ is_login: flag }),

    getLogin: () => get().is_login,

    getUserInfo: () => get().user_info,
    getIsVip: () => get().is_vip,
}));

export default useStore;

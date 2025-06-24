import { create } from "zustand/react";

interface UserInfo {
    [key: string]: unknown;
}

interface StoreState {
    user_info: UserInfo;
    is_login: boolean;

    setUserInfo: (key: string, value: unknown) => void;
    setUserInfoByObj: (obj: UserInfo) => void;
    clearUserInfo: () => void;

    setLogin: (flag: boolean) => void;
    getLogin: () => boolean;
    getUserInfo: () => UserInfo;
}

const useStore = create<StoreState>((set, get) => ({
    user_info: {},
    is_login: false,

    setUserInfo: (key: string, value: unknown) =>
        set((state) => ({
            user_info: { ...state.user_info, [key]: value },
        })),

    setUserInfoByObj: (obj: UserInfo) =>
        set((state) => ({
            user_info: { ...state.user_info, ...obj },
        })),

    clearUserInfo: () => set({ user_info: {} }),

    setLogin: (flag: boolean) => set({ is_login: flag }),

    getLogin: () => get().is_login,

    getUserInfo: () => get().user_info,
}));

export default useStore;

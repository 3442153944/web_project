import { create } from "zustand/react";
import {type UserInfo,defaultUserInfo} from "@/types/userTypes.ts";

interface StoreState {
    user_info: UserInfo;
    is_login: boolean;
    is_vip:boolean;

    setUserInfo: (key: string, value: unknown) => void;
    setUserInfoByObj: (obj: UserInfo) => void;
    clearUserInfo: () => void;

    setLogin: (flag: boolean) => void;
    getLogin: () => boolean;
    getUserInfo: () => UserInfo|null;

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

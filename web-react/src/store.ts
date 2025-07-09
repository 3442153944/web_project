import { create } from "zustand/react";
import { type UserInfo, defaultUserInfo } from "@/types/userTypes.ts";

interface StoreState {
    user_info: UserInfo;
    is_login: boolean;
    is_vip: boolean;

    searchInput: HTMLInputElement | null;
    searchKey: string;
    searchResultVisible: boolean;

    setUserInfo: (key: string, value: unknown) => void;
    setUserInfoByObj: (obj: UserInfo) => void;
    clearUserInfo: () => void;

    setLogin: (flag: boolean) => void;
    getLogin: () => boolean;
    getUserInfo: () => UserInfo | null;

    setIsVip: (b: boolean) => void;
    getIsVip: () => boolean;

    setSearchInput: (input: HTMLInputElement) => void;
    getSearchInput: () => HTMLInputElement | null;

    setSearchKey: (key: string) => void;
    getSearchKey: () => string;

    setSearchResultStatus: (visible: boolean) => void;
    getSearchResultStatus: () => boolean;
}

const useStore = create<StoreState>((set, get) => ({
    user_info: { ...defaultUserInfo },
    is_login: false,
    is_vip: false,

    searchInput: null,
    searchKey: "",
    searchResultVisible: false,

    setUserInfo: (key: string, value: unknown) =>
        set((state) => ({
            user_info: { ...state.user_info, [key]: value },
        })),

    setUserInfoByObj: (obj: UserInfo) =>
        set((state) => ({
            user_info: { ...state.user_info, ...obj },
        })),

    clearUserInfo: () => set({ user_info: { ...defaultUserInfo } }),

    setLogin: (flag: boolean) => set({ is_login: flag }),
    getLogin: () => get().is_login,

    getUserInfo: () => get().user_info,
    setIsVip: (flag: boolean) => set({ is_vip: flag }),
    getIsVip: () => get().is_vip,

    setSearchInput: (input: HTMLInputElement) => set({ searchInput: input }),
    getSearchInput: () => get().searchInput,

    setSearchKey: (key: string) => set({ searchKey: key }),
    getSearchKey: () => get().searchKey,

    setSearchResultStatus: (visible: boolean) => set({ searchResultVisible: visible }),
    getSearchResultStatus: () => get().searchResultVisible,
}));

export default useStore;

import { Navigate, Outlet } from 'react-router-dom';
import { useEffect, useState, useRef } from 'react';
import BaseApi from '@/BaseApi.ts';
import useStore from '@/store.ts';

type IsVipType = {
    code: number;
    msg: string;
    status: number;
};

const AuthGuard = () => {
    const api = BaseApi;
    const store = useStore();
    const [checkedLogin, setCheckedLogin] = useState(false);
    const [isLogin, setIsLogin] = useState(false);
    const isInitRef = useRef(false); // 用 ref 替代 state 防止 useEffect 循环

    useEffect(() => {
        (async () => {
            const loginStatus = await api.loginCheck();
            setIsLogin(loginStatus);
            setCheckedLogin(true);

            if (loginStatus && !store.is_login && !isInitRef.current) {
                store.setLogin(true);
                const userInfo = await api.getUserInfo();
                if (userInfo) {
                    store.setUserInfoByObj(userInfo);
                }
                isInitRef.current = true;
                console.log(userInfo);
            }

            // VIP 状态不需要反复执行
            const getVipStatus = async () => {
                const res: IsVipType = await api.post("api/GetVipStatus", {});
                if (res.code === 200) {
                    store.setIsVip(res.status === 1);
                }
            };
            await getVipStatus();
        })();
    }, []); // ✅ 确保只执行一次

    if (!checkedLogin) {
        return <></>;
    }

    if (!isLogin) {
        return <Navigate to="/login" replace />;
    }

    return <Outlet />;
};

export default AuthGuard;

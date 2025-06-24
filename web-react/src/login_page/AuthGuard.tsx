import { Navigate, Outlet } from 'react-router-dom';
import { useEffect, useState } from 'react';
import BaseApi from '@/BaseApi.ts';
import useStore from '@/store.ts';

interface UserInfo{
    [key: string]:unknown;
}

const AuthGuard = () => {
    const api = BaseApi;
    const store = useStore();
    const [isInit, setIsInit] = useState(false);
    const [checkedLogin, setCheckedLogin] = useState(false);
    const [isLogin, setIsLogin] = useState(false);

    useEffect(() => {
        (async () => {
            const loginStatus = await api.loginCheck();
            setIsLogin(loginStatus);
            setCheckedLogin(true);
            if (loginStatus && !store.is_login && !isInit) {
                store.setLogin(true);
                const userInfo = await api.getUserInfo();
                store.setUserInfoByObj(userInfo as UserInfo);
                setIsInit(true);
                console.log(userInfo);
            }
        })();
    }, [api, store, isInit]);

    if (!checkedLogin) {
        // 可以返回 loading UI，防止闪烁
        return null;
    }

    if (!isLogin) {
        return <Navigate to="/login" replace />;
    }

    return <Outlet />;
};

export default AuthGuard;

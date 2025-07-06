import { useEffect, useState } from "react";
import useStore from "@/store.ts";
import style from "./baseUserInfo.module.scss";
import BaseApi from "@/BaseApi.ts";
import vip from "@/assets/VIP.svg";
import notVIP from "@/assets/notVIP.svg"
import { motion, AnimatePresence } from "framer-motion";
import UserMenu from "@/home/head/model-sub/user-box-module/userMenu.tsx";

interface BaseUserInfoProps {
    show: boolean;
}
interface resType{
    code: number,
    data: {follow_count: number,
        fans_count: number,
        follow_list: [],
        fans_list:[],
    msg: string}
}


const BaseUserInfo = ({ show }: BaseUserInfoProps) => {
    const store = useStore();
    const [userInfo] = useState(store.getUserInfo());
    const api = BaseApi;
    const [followInfo, setFollowInfo]=useState({
        follow_count: 0,
        fans_count: 0,
        follow_list: [],
        fans_list: []
    })
    
    useEffect(() => {
        console.log("user_info:", userInfo);
        const getFollowInfo = async () => {
            const res:resType=await api.post("GetUserInfo/GetUserFollow/",{})
            if (res.code==200){
                setFollowInfo(res.data)
            }
            else{
                console.warn( res)
            }
        };
        (async () => {
            await getFollowInfo();
        })();
    }, [api, userInfo]);

    return (
        <AnimatePresence>
            {show && (
                <motion.div
                    key="baseUserInfo"
                    initial={{ opacity: 0, y: -20 }}
                    animate={{ opacity: 1, y: 0 }}
                    exit={{ opacity: 0, y: -20 }}
                    transition={{ duration: 0.3 }}
                    className={style.content}
                >
                    <div className={style.background}>
                        <img src={`${api.IMG_URL}${userInfo.user_back_img}`} alt="" />
                    </div>
                    <div className={style.info}>
                        <div className={style.avatarBox}>
                            {store.getIsVip()? <img src={vip} alt={"VIP"} className={"ico"} />:<>
                            <img src={notVIP} alt={"NOT_VIP"} className={"ico"}/>
                            </>}
                            <img className={style.avatarImg} src={`${api.avatar_url}${userInfo.user_avatar}`}  alt={"avatar"} />
                        </div>
                        <div className={style.userInfo}>
                            <span>{userInfo.username}</span>
                            <span>{userInfo.userid}</span>
                        </div>
                    </div>
                    <div className={style.follow}>
                        <div className={style.followCount}>
                            <span>关注：{followInfo.follow_count??0}</span>
                        </div>
                        <div className={style.fansCount}>
                            <span>粉丝：{followInfo.fans_count??0}</span>
                        </div>
                    </div>
                    <UserMenu></UserMenu>

                </motion.div>
            )}
        </AnimatePresence>
    );
};

export default BaseUserInfo;

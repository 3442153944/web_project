import useStore from "@/store.ts";
import {useState} from "react";
import style from "./userAvatar.module.scss"
import BaseApi from "@/BaseApi.ts";
import drop_down from "@/assets/drop_down.svg"

interface UserAvatarProps {
    show: boolean;
    sendShow: (show: boolean) => void;
}

const UserAvatar = ({ show, sendShow }: UserAvatarProps) => {
    const store = useStore();
    const [userInfo] = useState(store.getUserInfo());

    const toggleShow = () => {
        sendShow(!show);
    };

    return (
        <div className={style.content}>
            <div className={style.avatar} onClick={toggleShow}>
                <img src={BaseApi.avatar_url + userInfo.user_avatar} alt={"头像"} />
            </div>
            <div className={`${style.ico} ${(show ? style.show : style.hide)}`}>
                <img src={drop_down} alt={"下拉"} />
            </div>
        </div>
    );
};

export default UserAvatar;

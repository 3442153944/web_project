import BaseUserInfo from "@/home/head/model-sub/user-box-module/baseUserInfo.tsx";
import useStore from "@/store.ts";
import {useEffect, useRef, useState} from "react";
import UserLogin from "@/home/head/model-sub/user-box-module/userLogin.tsx";
import UserAvatar from "@/home/head/model-sub/user-box-module/userAvatar.tsx";
import style from "./userBox.module.scss"

const UserBox=()=>{
    const store = useStore();
    const [isLogin]=useState(store.getLogin())
    const [showStatus,setShowStatus]=useState(false)
    const UserBoxRef=useRef<HTMLDivElement>(null)

    useEffect(() => {
        const handleClickOutside=(event:MouseEvent)=>{
                if (UserBoxRef.current && !UserBoxRef.current.contains(event.target as Node)) {
                    setShowStatus(false)
                }
        }
        document.addEventListener("mousedown", handleClickOutside)
        return () => {
            document.removeEventListener("mousedown", handleClickOutside)
        };
    }, []);

    return (
        <div className={style.userBox} ref={UserBoxRef}>
            {isLogin?<>
                <UserAvatar show={showStatus} sendShow={setShowStatus} />
                <div className={style.userInfo} >
                {
                    showStatus?<BaseUserInfo show={showStatus}/>:null
                }
                </div>
            </>:<UserLogin/>}

        </div>
    )
}

export default UserBox;
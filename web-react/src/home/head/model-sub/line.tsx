import useStore from "@/store.ts";
import line from "./line.module.scss";
import {useState} from "react";
import msg from "@/assets/message.svg"
import notice from "@/assets/notice.svg"
import LeftMenuBox from "./leftMenuBox.tsx"
import SearchBox from "@/home/head/model-sub/searchBox.tsx";

const Line = () => {
    const store = useStore(); // 如果不需要可以取消注释这行
    const [isLogin]=useState(store.getLogin())
    const content=<>
        <div className={line.content}>
            <LeftMenuBox/>
            <div className={line.icon}>
                <img src={"https://www.sunyuanling.com/favicon.ico"} alt={"插画社区"}/>
            </div>
           <SearchBox/>
            <div className={line.userBox}>
                {isLogin?<div><span>已登录</span></div>:<div><span>未登录</span></div>}
            </div>
            <div className={line.msgBoxBtn}>
                <img src={msg} alt={"消息"}/>
            </div>
            <div className={line.noticeBoxBtn}>
                <img src={notice} alt={"通知"}/>
            </div>
        </div>
    </>
    return (
        <div>
            { content}
        </div>
    );
};

export default Line;
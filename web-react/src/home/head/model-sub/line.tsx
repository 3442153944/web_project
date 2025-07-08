import useStore from "@/store.ts";
import line from "./line.module.scss";
import {useState} from "react";
import msg from "@/assets/message.svg"
import notice from "@/assets/notice.svg"
import LeftMenuBox from "./leftMenuBox.tsx"
import SearchBox from "@/home/head/model-sub/searchBox.tsx";
import IsVip from "./isVip.tsx";
import SubmitWork from "@/home/head/model-sub/submitWork.tsx";
import UserBox from "@/home/head/model-sub/userBox.tsx";

const Line = () => {
    const store = useStore(); // 如果不需要可以取消注释这行
    const [isLogin]=useState(store.getLogin())
    const content=<>
        <div className={line.content}>
            <div className={line.left}>
                <LeftMenuBox/>
                <div className={line.icon}>
                    <img src={"https://www.sunyuanling.com/favicon.ico"} alt={"插画社区"}/>
                </div>
            </div>
            <div className={line.right}>
                <SearchBox/>
                <IsVip/>
                <SubmitWork/>
                <div className={"ico hover active"}>
                    <img src={msg} alt={"消息"}/>
                </div>
                <div className={"ico hover active"}>
                    <img src={notice} alt={"通知"}/>
                </div>
                <div className={line.userBox}>
                    {isLogin?<div><UserBox/></div>:<div><span>未登录</span></div>}
                </div>
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
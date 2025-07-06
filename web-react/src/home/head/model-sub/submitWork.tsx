import Select from "@/module/select.tsx"
import {Photo} from "@/home/head/model-sub/submit-work-svg/photo.tsx";
import {Play} from "@/home/head/model-sub/submit-work-svg/play.tsx";
import {Comic} from "@/home/head/model-sub/submit-work-svg/comic.tsx";
import {Novel} from "@/home/head/model-sub/submit-work-svg/novel.tsx";
import style from "./submitWork.module.scss"
import type {JSX} from "react";

interface option {
    icon: JSX.Element|string|File;
    value: string;
}

const SubmitWork=()=>{
    const selectList = [
        { icon: <Photo />, value: "插画" },
        { icon: <Play />, value: "动图" },
        { icon: <Comic />, value: "漫画" },
        { icon: <Novel />, value: "小说" },
    ];
    const onChange=(value:option)=>{
        console.log(value)
    }
    return (<>
        <div className={style.content}>
            <Select options={selectList} onChange={onChange}/>
        </div>
    </>);

}
export default SubmitWork;
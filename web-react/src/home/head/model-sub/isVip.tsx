import baseApi from "@/BaseApi.ts";
import useStore from "@/store.ts";
import {useState} from "react";
import style from "./isVip.module.scss"

const IsVip=()=>{
    const store = useStore();
    const [userInfo] = useState(store.getUserInfo());
    const content=<>
    <div className={style.isVip}>

    </div>
    </>
}
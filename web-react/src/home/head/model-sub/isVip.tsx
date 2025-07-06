import {useEffect, useState} from "react";
import style from "./isVip.module.scss"
import baseApi from "@/BaseApi.ts";
import {useNavigate} from "react-router-dom";

type IsVipType={
    code:number,
    msg:string,
    status:number
}

const IsVip=()=>{
    const [isVip,setIsVip]=useState(false)
    const navigate = useNavigate();
    useEffect(() => {
        (async ()=>{
            const res:IsVipType=await baseApi.post("api/GetVipStatus",{})
            if(res.code==200){
                if(res.status==1){
                    setIsVip(true)
                }
                else {
                    setIsVip( false)
                }
            }
            console.log(res)
        })()
    }, []);
    const toVipPage=(status:0|1)=>{
          navigate(`/vip?vipStatus=${status}`)
            }
    const content=<>
    <div className={style.isVip} style={{color:isVip?'#00aeff':'#f4c752'}}>
        <div className={"hover active"}>{isVip?<span onClick={()=>toVipPage(1)}>续费会员</span>:
            <span onClick={()=>toVipPage(0)}>开通会员</span>}</div>

    </div>
    </>
    return (content)
}

export default IsVip;
import ill from "@/assets/image.svg"
import comic from "@/assets/comic.svg"
import novel from "@/assets/novel.svg"
import group from "@/assets/people.svg"
import find from "@/assets/find.svg"
import rank_list from "@/assets/rank_list.svg"
import smail from "@/assets/smail.svg"
import flag from "@/assets/flag.svg"
import love from "@/assets/red_love.svg"
import NoticeBox from "@/home/head/model-sub/leftMenu-module/noticeBox.tsx";
import style from "./switchPage.module.scss"

const SwitchPage=()=>{
    const list=[
        {
            name:"插画",
            icon:ill
        },
        {
            name:"漫画",
            icon:comic
        },
        {
            name:"小说",
            icon:novel
        },{
            name:"br",
            icon:""
        }
        ,{
            name:"关注用户最新作品",
            icon:group
        },
        {
            name:"发现",
            icon:find
        },{
            name:"br"
            ,icon:""
        }
        ,{
            name:"排行榜",
            icon:rank_list
        },{
            name:"大家的新作",
            icon:smail
        },
        {
            name:"比赛",
            icon:flag
        },
        {
            name:"约稿",
            icon:love
        }
    ]
    return (<>
    <div className={style.list}>
        {
            list.map((item,index)=>{
                if(item.name=="br"){
                    return <div key={index} className={style.br}></div>
                }
                return <div className={style.item+" hover active"} key={index}>
                    <img src={item.icon} alt={item.name}/>
                    <span>{item.name}</span>
                </div>
            })
        }
        <NoticeBox></NoticeBox>
    </div>
    </>)
}
export default SwitchPage
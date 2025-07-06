import style from "./noticeBox.module.scss"

const NoticeBox=()=>{
    return (<>
        <div className={style.notice}>
            <div className={"font-bold"}>
                <span>公告</span>
            </div>
        </div>
    </>)
}
export default NoticeBox
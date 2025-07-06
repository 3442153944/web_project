import {useNavigate} from "react-router-dom";
import style from "./userMenu.module.scss"

const UserMenu = () => {
    const navigate = useNavigate();
    const loginOut = () => {
        localStorage.removeItem("token");
        localStorage.removeItem("userInfo");
        navigate("/login");
    }

    return (<>
        <div className={style.content}>
            <span onClick={()=>{navigate("/dataAnalysis")}}>数据分析</span>
            <span onClick={()=>{navigate("/orderManage")}}>约稿管理</span>
            <span onClick={()=>{navigate("/workStatus")}}>投稿作品状态</span>
            <span onClick={()=>{navigate("/wallet")}}>我的钱包</span>
            <span onClick={()=>{navigate("/history")}}>浏览历史</span>
            <div className={style.subContent}>
                <span onClick={() => {navigate("/setting")}}>设置</span>
                <span onClick={() => {navigate("/feedback")}}>发送反馈</span>
                <span onClick={()=>{loginOut()}}>退出登录</span>
            </div>
        </div>
    </>)
};
export default UserMenu;
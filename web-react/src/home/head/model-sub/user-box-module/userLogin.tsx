import {useNavigate} from "react-router-dom";
import style from "./userLogin.module.scss"

const UserLogin = () => {
    const navigate = useNavigate();
    return (
        <>
        <div className={style.userLogin}>
            <span onClick={() => navigate('/login')} className={"active hover"}>去登录</span>
        </div>
        </>
    )
};
export default UserLogin;
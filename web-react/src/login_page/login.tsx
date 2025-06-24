import { useState } from "react";
import BaseApi from "@/BaseApi";
import style from "@/login_page/login.module.scss";
import {useNavigate} from "react-router-dom";

interface response{
    code: number;
    msg: string;
    data: unknown;
    token: string;
}

function Login() {
    const [loginKey, setLoginKey] = useState("");
    const [password, setPassword] = useState("");
    const [error, setError] = useState("");
    const navigate = useNavigate();

    const login = async () => {
        setError(""); // 清空上次错误
        if (!loginKey || !password) {
            setError("账号或密码不能为空");
            return;
        }
        try {
            const res: response = await BaseApi.post("login/", {
                login_key: loginKey,
                password: password
            });

            if (res.code === 200) {
                localStorage.setItem("token", res.token);
                alert("登录成功");
                navigate("/")
            } else {
                setError(res.msg || "登录失败");
                console.log(res)
            }
        } catch (e) {
            setError("网络错误，请稍后重试");
            console.error(e);

        }
    };

    return (
        <div className={style.content}>
            <div className={style.login_box}>
                <h2>用户登录</h2>
                <input
                    type="text"
                    placeholder="用户名 / 邮箱 / 手机号"
                    value={loginKey}
                    onChange={(e) => setLoginKey(e.target.value)}
                />
                <input
                    type="password"
                    placeholder="密码"
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                />
                <button onClick={login}>登录</button>
                {error && <div style={{ color: "red" }}>{error}</div>}
            </div>
        </div>
    );
}

export default Login;

async function admin_login(token='10086', userid=null, password=null) {
    try {
        const res = await fetch('https://www.sunyuanling.com/api/admin_control/AdminLogin/', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                // 如果需要使用 token，可以在 Authorization 头部设置
                'Authorization': `Bearer ${token}` // 例如，若你的后端需要 Bearer Token
            },
            credentials: 'include', // 确保 cookies 被包含在请求中
            body: JSON.stringify({
                userid: userid,
                password: password,
                token: token,
            })
        });
        if (res.ok) {
            const data = await res.json();
            return data;
        } else {
            const data = await res.json();
            return data;
        }
    } catch (e) {
        console.log(e);
    }
}
export { admin_login };


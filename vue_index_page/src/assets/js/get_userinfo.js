async function get_user_follow_work_tags(token) {
    try {
        const res = await fetch('https://www.sunyuanling.com/api/GetUserInfo/GetUserFollowWorkTags/', {
            method: 'post',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ' + token
            },
            body: JSON.stringify({
                token: token
            })
        })
        if (res.ok) {
            const data = await res.json();
            return data;
        }
        else {
            console.log('获取关注作品标签失败');
            return false;
        }
    }
    catch (e) {
        console.log(e);
        return false;
    }
}
async function get_userinfo(token = null, userid = null) {
    try {
        const res = await fetch('https://www.sunyuanling.com/api/GetUserInfo/GetAllUserInfo/', {
            method: 'POST',
            body: JSON.stringify({
                token: token,
                userid: userid
            })
        })
        if (res.ok) {
            const data = await res.json();
            if (data.status == 'success') {
                return data.data;
            }
            else {
                return false;
            }
        }
        else {
            console.log(res.status);
            return false;
        }
    }
    catch (e) {
        console.log(e);
    }
}

export { get_user_follow_work_tags ,get_userinfo}
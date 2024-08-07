async function get_user_follow_work_tags(token)
{
    try{
        const res=await fetch('https://www.sunyuanling.com/api/GetUserInfo/GetUserFollowWorkTags/',{
            method:'post',
            headers:{
                'Content-Type':'application/json',
                'Authorization':'Bearer '+token
            },
            body:JSON.stringify({
                token:token
            })
        })
        if(res.ok)
        {
            const data=await res.json();
            return data;
        }
        else
        {
            console.log('获取关注作品标签失败');
            return false;
        }
    }
    catch(e)
    {
        console.log(e);
        return false;
    }
}

export {get_user_follow_work_tags}
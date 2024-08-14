async function get_user_list(){
    try{
        const res=await fetch('https://www.sunyuanling.com/api/admin_control/GetUserList/',{
            method:'post',
            headers:{
                'Content-Type':'application/json',
            },
            credentials:'include',
            body:JSON.stringify({
                
            })
        })
        if (res.ok)
        {
            const data=await res.json();
            return data;
        }
    }
    catch(e)
    {
        console.log(e);
    }
}
export {get_user_list};
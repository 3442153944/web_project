async function get_user_list(){
    try{
        const res=await fetch('https://www.sunyuanling.com/api/admin_control/GetUserList/',{
            method:'post',
            headers:{
                'Content-Type':'application/json',
                'Authorization':`Bearer ${localStorage.getItem('token')}`
            },
            credentials:'include',
            body:JSON.stringify({
                
            })
        })
        if (res.ok)
        {
            const data=await res.json();
            console.log(data);
            return data;
        }
    }
    catch(e)
    {
        console.log(e);
    }
}
export {get_user_list};
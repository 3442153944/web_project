async function admin_login(token='10086',userid=null,password=null){
    try{
        const res=await fetch('https://www.sunyuanling.com/api/admin_control/AdminLogin/',{
            method:'POST',
            headers:{
                'Content-Type':'application/json',
                'Authorization':token
            },
            body:JSON.stringify({
                userid:userid,
                password:password,
                token:token,
            })
        })
        if(res.ok)
        {
            const data=await res.json()
            if(data.status=='success')
            {
                return data
            }
            else{
                return data
            }
        }
        else{
            const data=await res.json()
            return data
        }
    }
    catch(e)
    {
        console.log(e)
    }
}
export {admin_login,}
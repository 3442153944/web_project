async function get_notice_info(token,operate_type){
    try{
        const res=await fetch('https://www.sunyuanling.com/api/notice_control/NoticeOperations/',
            {
                method:'post',
                headers:{
                    'Content-Type':'application/json'
                },
                body:JSON.stringify({
                    operate_type:operate_type,
                    token:token,
                })
            }
        )
        if(res.ok)
        {
            const data=await res.json()
            if(data.status=='success')
            {
                return data.data;
            }
            else{
                console.log(data.message)
            }
        }
        else{
            console.log(res.status)
        
        }
    }
    catch(error){
        console.log(error)
    }
}

export {get_notice_info}
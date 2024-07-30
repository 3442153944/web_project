async function get_workinfo(token,work_id)
{
    try{
        const res=await fetch('https://www.sunyuanling.com/api/get_work_info/GetNovelList/',{
            method:'post',
            headers:{
                'Content-Type':'application/json'
            },
            body:JSON.stringify({
                token:token,
                work_id:work_id
            })
        })
        if(res.ok)
        {
            const data=await res.json()
            if(data.status=='success')
            {
                return data.data
            }
            else
            {
                console.log(data.message)
            }
        }
        else
        {
            console.log('请求失败')
        }
    }
    catch(e)
    {
        console.log(e)
    }
}
export {get_workinfo}
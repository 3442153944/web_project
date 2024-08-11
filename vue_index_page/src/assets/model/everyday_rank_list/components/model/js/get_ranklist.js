async function get_rank_list(work_type='ill')
{
    try{
        const res=await fetch('https://www.sunyuanling.com/api/rank_list/GetRankList/',{
            method:'post',
            headers:{
                'Content-Type':'application/json',
            },
            body:JSON.stringify({
                work_type:work_type
            })
        }
        )
        if(res.ok)
        {
            const data=await res.json()
            if (data.status=='success')
            {
                return data.data
            }
            else{
                return data.message
            }
        }
        else{
            return '网络错误'
        }
    }
    catch(e)
    {
        console.log(e)
    }
}

export {get_rank_list}
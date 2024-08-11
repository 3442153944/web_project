async function get_all_work_data(token,ago_date=null)
{
    try{
        const res=await fetch('https://www.sunyuanling.com/api/data_analysis/GetAllWorkData/',{
            method:'post',
            headers:{
                'Content-Type':'application/json',
                
            },
            body:JSON.stringify(
                {
                    token:token,
                    ago_date:ago_date,
                }
            )
        })
        if(res.ok)
        {
            const data=await res.json()
            if(data.status=='success')
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

export {get_all_work_data}
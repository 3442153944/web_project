async function get_comment(work_id,work_type,token){
    try{
        const res=await fetch('https://www.sunyuanling.com/api/work_interaction/GetCommentSection/',{
            method:'POST',
            headers:{
                'Content-Type':'application/json'
            },
            body:JSON.stringify({
                work_id:work_id,
                work_type:work_type,
                token:token
            })
        })
        if(res.ok)
        {
            const data=await res.json();
            if(data.status=='success')
            {
                return data.data;
            }
            else
            {
                console.log(data.message);
                return null;
            }
        }
        else
        {
            console.log('网络错误');
            return null;
        }
    }
    catch(e)
    {
        console.log(e);
    }
}
export {get_comment}
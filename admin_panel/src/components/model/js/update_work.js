async function update_ill_work_status(work_status,work_id){
    try{
        const res=await fetch('https://www.sunyuanling.com/api/admin_control/UpdateIll/',{
            method:'POST',
            headers:{
                'Content-Type':'application/json',
                'Authorization':'Bearer '+localStorage.getItem('token')
            },
            body:JSON.stringify({
                work_status:work_status,
                work_id:work_id
            })
        })
        const data=await res.json();
        return data;
    }
    catch(e)
    {
        console.log(e);
    }
}

export {update_ill_work_status};
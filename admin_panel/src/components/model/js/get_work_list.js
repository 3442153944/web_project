async function get_ill_worklist(limit=10,offset=0)
{
    try{
        const res=await fetch("https://www.sunyuanling.com/api/admin_control/GetIllList/",{
            method:"post",
            headers:{
                "Content-Type":"application/json",
                "Authorization":`Bearer ${localStorage.getItem("token")}`
            },
            body:JSON.stringify({
                limit:limit,
                offset:offset
            })
        })
        const data=await res.json()
        return data
    }
    catch(e)
    {
        console.log(e)
    }
}
async function get_comic_worklist(limit=10,offset=0)
{
    try{
        const res=await fetch("https://www.sunyuanling.com/api/admin_control/GetComicList/",{
            method:"post",
            headers:{
                "Content-Type":"application/json",
                "Authorization":`Bearer ${localStorage.getItem("token")}`
            },
            body:JSON.stringify({
                limit:limit,
                offset:offset
            })
        })
        const data=await res.json()
        return data
    }
    catch(e)
    {
        console.log(e)
    }
}

export {get_ill_worklist,get_comic_worklist}
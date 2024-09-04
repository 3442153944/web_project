async function search_ill_work(search_key, work_status = 'all', limit = 10, offset = 0) {
    try {
        const res = await fetch('https://www.sunyuanling.com/api/admin_control/SearchIll/', {
            method: 'post',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ' + localStorage.getItem('token')
            },
            body: JSON.stringify({
                search_key: search_key,
                work_status: work_status,
                limit: limit,
                offset: offset
            })
        })
        const data = await res.json()
        return data
    }
    catch (e) {
        console.log(e)
    }
}

async function search_comic_work(search_key, work_status = 'all', limit = 10, offset = 0) {
    try {
        const res = await fetch('https://www.sunyuanling.com/api/admin_control/SearchComic/', {
            method: 'post',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ' + localStorage.getItem('token')
            },
            body: JSON.stringify({
                search_key: search_key,
                work_status: work_status,
                limit: limit,
                offset: offset
            })
        })
        const data = await res.json()
        return data
    }
    catch (e) {
        console.log(e)
    }
}

async function search_novel_work(search_key, work_status = 'all', limit = 10, offset = 0) {
    try {
        const res = await fetch('https://www.sunyuanling.com/api/admin_control/SearchNovelWork/', {
            method: 'post',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ' + localStorage.getItem('token')
            },
            body: JSON.stringify({
                search_type: search_key,
                work_status: work_status,
                limit: limit,
                offset: offset
            })
        })
        const data = await res.json()
        return data;
    }
    catch (e) { console.log(e) }
}

export { search_ill_work, search_comic_work,search_novel_work }
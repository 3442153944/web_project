async function update_user_back(file, token, user_data) {
    let formdata = new FormData();
    formdata.append('files', file); 
    formdata.append('data', JSON.stringify(user_data)); 
    formdata.append('token', token);

    try {
        const res = await fetch('https://www.sunyuanling.com/api/update/UpdateUserBack/', {
            method: 'POST',
            body: formdata
        });

        if (res.ok) {
            const data = await res.json();
            if (data.status === 'success') {
                return true;
            } 
             else if(data.status=='file_error')
            {
                alert(data.message)
                return false;
            }
            else {
                console.error('Upload failed:', data.message);
                return false;
            }
        } else {
            console.error('HTTP error:', res.status, res.statusText);
            return false;
        }
    } catch (e) {
        console.error('Error:', e);
        return false;
    }
}

async function delete_user_back(token){
    try {
        const res = await fetch('https://www.sunyuanling.com/api/update/DeleteUserBack/', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                token: token
            })
        });

        if (res.ok) {
            const data = await res.json();
            if (data.status === 'success') {
                return true;
            } else {
                console.error('Upload failed:', data.message);
                return false;
            }
        }
    }
    catch (e) {
        console.error('Error:', e);
    }
}

export { update_user_back ,delete_user_back};

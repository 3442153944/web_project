// utils.js

// 设置cookies
async function set_cookie(key, value) {
    expireCookie(key);
    // Get current time
    let now = new Date();
    // Set expiration time to 7 days later
    now.setTime(now.getTime() + 7 * 24 * 60 * 60 * 1000);
    let expires = "expires=" + now.toUTCString();
    // Concatenate new cookie
    let newCookie = key + '=' + value + '; ' + expires;
    // Get current cookies
    let cookies = document.cookie;
    // If the same key already exists, delete the old cookie first
    if (cookies.includes(key + '=')) {
        let cookieArray = cookies.split('; ');
        for (let i = 0; i < cookieArray.length; i++) {
            if (cookieArray[i].startsWith(key + '=')) {
                cookieArray[i] = newCookie;
            }
        }
        document.cookie = cookieArray.join('; ');
    } else {
        // Otherwise, directly set the new cookie
        document.cookie = newCookie;
    }
}

// 使cookie失效
function expireCookie(name) {
    document.cookie = `${name}=;expires=Thu, 01 Jan 1970 00:00:00 UTC;path=/;`;
}

// 获取指定cookie的值
function get_cookie(name) {
    let cookies = document.cookie.split('; ');
    for (let i = 0; i < cookies.length; i++) {
        let cookie = cookies[i].split('=');
        if (cookie[0] === name) {
            return cookie[1];
        }
    }
    return null; // Cookie not found
}

// 设置localStorage值，设置前清除之前的值
function set_storage(key, value) {
    localStorage.removeItem(key);
    localStorage.setItem(key, value);
}

// 获取localStorage值
function get_storage(key) {
    return localStorage.getItem(key);
}

// 导出所有函数
export { set_cookie, expireCookie, get_cookie, set_storage, get_storage };

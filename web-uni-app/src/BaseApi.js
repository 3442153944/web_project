// src/api/base.js
const BASE_URL = 'https://www.sunyuanling.com/api/';

class BaseApi {
  static IMG_URL = "https://www.sunyuanling.com/server/static/image/";
  static avatar_url = "https://www.sunyuanling.com/server/static/avatar/";

  constructor() {
    this.IMG_URL = "https://www.sunyuanling.com/server/static/image/";
    this.avatar_url = "https://www.sunyuanling.com/server/static/image/avatar_thumbnail/";
  }

  async getToken() {
    try {
      const res = await uni.getStorage({ key: 'token' });
      //console.log("getToken", res);
      if (res?.data && res.data.trim().length>0) return res.data;
    } catch (e) {
      // 存储不存在

    }

    // fallback 逻辑，开发模式自动使用默认 token
    
      console.warn('使用预设token（开发调试用）');
      return `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.
      eyJ1c2VyaWQiOiJlYzY4NjZkMy0xMjhjLTQyODEtOGZlZi03NmJlYjZiMjk1MDgiLCJ1c2VybmFtZSI6InVzZXIxIiwiZW1haWwiOiIy
      MjIiLCJwaG9uZSI6IjIyMjIyIiwic2V4IjoiXHU1OTczIiwiYXZhdGFyIjoiNjUwMTQyMjBfcDAuanBnIiwidXNlcl9sZXZlbCI6IjEiL
      CJiYWNrZ3JvdW5kIjoiMjAyNDA1MjUxNzQ5MTZfZjRmNGFjYzcyODBmNGVhYmI5ZmMxNzEyOTI5YzNjY2MucG5nIiwibm93IjoiMjAyNS
      0wNy0yN1QxMzoyMjoyMy44NTAxMzMrMDA6MDAiLCJpc19sb2dpbiI6dHJ1ZSwic3RhdHVzIjoiMSIsInZpcCI6IjEiLCJyb2xlIjoiYWRt
      aW4iLCJleHAiOjE3NTYyMTQ1NDN9.38THp3pwyilRDX6m3ypzgibx5Uyk8jwT--WEnPuACGY`;
    

    return '';
  }


  async buildHeaders(options) {
    const token = await this.getToken(); // 添加 await
    const headers = {
      ...(token ? { 'Authorization': `token ${token}` } : {}), // 建议使用 Bearer 模式
      ...(options.headers || {})
    };

    // Content-Type 处理逻辑保持不变
    if (options.requestType === 'json') {
      headers['Content-Type'] = 'application/json';
    } else if (options.requestType === 'form') {
      headers['Content-Type'] = 'application/x-www-form-urlencoded';
    }

    return headers;
  }

  async request(url, options = {}) {
    const method = options.method || 'GET';
    const headers = await this.buildHeaders(options);
    let data = null;

    if (method !== 'GET' && options.data) {
      data = options.requestType === 'form'
        ? new URLSearchParams(options.data).toString()
        : JSON.stringify(options.data);
    }

    try {
      const res = await new Promise((resolve, reject) => {
        uni.request({
          url: BASE_URL + url,
          method,
          header: headers,
          data,
          success: (res) => {
            if (res.statusCode !== 200) {
              reject({
                status: res.statusCode,
                data: res.data || { msg: `请求失败: ${res.statusCode}` }
              });
            } else {
              resolve(res.data);
            }
          },
          fail: (err) => reject({ status: 0, data: { msg: '网络连接失败' } })
        });
      });

      return res;

    } catch (e) {
      // 401 时清除 token
      if (e.status === 401) {
        await uni.removeStorage({ key: 'token' });
      }

      console.error(`请求 ${url} 失败:`, e);
      return e.data || { code: e.status || 500, msg: '请求异常' };
    }
  }

  get(url, params) {
    const query = params ? `?${new URLSearchParams(params).toString()}` : '';
    return this.request(url + query, { method: 'GET' });
  }

  post(url, data = {}, requestType = 'json') {
    return this.request(url, {
      method: 'POST',
      data,
      requestType
    });
  }

  put(url, data, requestType = 'json') {
    return this.request(url, {
      method: 'PUT',
      data,
      requestType
    });
  }

  delete(url, data, requestType = 'json') {
    return this.request(url, {
      method: 'DELETE',
      data,
      requestType
    });
  }

  async loginCheck() {
    try {
      const res = await this.post('verify/', {}, 'json');
      console.log('登录检查',res)
      return res?.code == 200;
    } catch (e) {
      console.error('登录检查失败:', e);
      return false;
    }
  }

  async getUserInfo() {
    const res = await this.post('GetUserInfo/GetSelfInfo', {}, 'json');
    return res?.code === 200 ? res.data : null;
  }

  getRandomColor() {
    const colorList = [
      '#a0f8f5', '#89f7d4', '#9beb9f', '#9ee1f7', '#f6caca',
      '#f6e9c0', '#f5c0f6', '#dea7fb', '#bd9de9',
      '#b5f4e6', '#8decd7', '#6feac0', '#72dab9'
    ];
    const index = Math.floor(Math.random() * colorList.length);
    const color = colorList[index];
    return color.startsWith('#') ? color : `#${color}`;
  }
}

export default new BaseApi();
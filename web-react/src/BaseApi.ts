// src/api/base.ts
// src/api/base.ts
import type {BodyInit} from 'node-fetch';
const BASE_URL = 'https://www.sunyuanling.com/api/';

type RequestMethod = 'GET' | 'POST' | 'PUT' | 'DELETE';

interface RequestOptions {
    method?: RequestMethod;
    data?: BodyInit | FormData |JSON| undefined|unknown;
    requestType?: 'json' | 'form';
    headers?: Record<string, string>;
    signal?: AbortSignal;
}

class BaseApi {
    private getToken(): string {
        return localStorage.getItem('token') || '';
    }

    private buildHeaders(options: RequestOptions): HeadersInit {
        const headers: Record<string, string> = {
            'Authorization': `token ${this.getToken()}`,
            ...options.headers,
        };

        if (options.requestType === 'json') {
            headers['Content-Type'] = 'application/json';
            headers['Accept'] = 'application/json';
        }

        // 如果是 FormData，不要设置 Content-Type，浏览器自动带上 boundary
        return headers;
    }

    async request<T = unknown>(url: string, options: RequestOptions): Promise<T | null> {
        const method = options.method || 'GET';
        const headers = this.buildHeaders(options);

        let body: unknown|null|undefined|BodyInit;

        if (method !== 'GET' && options.data) {
            if (options.requestType === 'json') {
                body = JSON.stringify(options.data);
            } else if (options.requestType === 'form') {
                body = options.data; // 应是 FormData 实例
            }
        }

        try {
            const res = await fetch(BASE_URL + url, {
                method,
                headers,
                body,
                signal: options.signal,
            });

            if (!res.ok) {
                console.log(await res.json())
                throw new Error(`请求失败: ${res.status}`);
            }

            return await res.json();
        } catch (e) {
            console.error('请求错误:', e);
            return null;
        }
    }

    get<T = unknown>(url: string, params?: Record<string, string>) {
        const query = params ? `?${new URLSearchParams(params).toString()}` : '';
        return this.request<T>(url + query, { method: 'GET' });
    }

    post<T = unknown>(url: string, data?: unknown, requestType: 'json' | 'form' = 'json') {
        return this.request<T>(url, { method: 'POST', data, requestType });
    }

    put<T = unknown>(url: string, data?: unknown, requestType: 'json' | 'form' = 'json') {
        return this.request<T>(url, { method: 'PUT', data, requestType });
    }

    delete<T = unknown>(url: string, data?: unknown, requestType: 'json' | 'form' = 'json') {
        return this.request<T>(url, { method: 'DELETE', data, requestType });
    }
    //登录验证方法
    async loginCheck() {
        const res=await this.post('verify/', {}, 'json') as {code:number,msg:string}
        if (res.code === 200){
            return true
        }
        else{
            console.log(res.msg)
            return false
        }
    }
    //获取登录用户信息
    async getUserInfo(){
        const res=await this.post('GetUserInfo/GetSelfInfo', {}, 'json') as {code:number,msg:string,data:{[key:string]:unknown}}
        if (res.code === 200){
            return res.data
        }
        else{
            console.log(res)
            return null
        }
    }
}

export default new BaseApi();

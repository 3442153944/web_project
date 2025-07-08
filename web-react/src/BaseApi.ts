// src/api/base.ts
import type { BodyInit } from 'node-fetch';
import { type ResType } from "@/types/resTypes.ts";
import type { UserInfo } from "@/types/userTypes.ts";

const BASE_URL = 'https://www.sunyuanling.com/api/';
type RequestMethod = 'GET' | 'POST' | 'PUT' | 'DELETE';

interface RequestOptions {
    method?: RequestMethod;
    data?: unknown; // 简化类型，使用 unknown
    requestType?: 'json' | 'form';
    headers?: Record<string, string>;
    signal?: AbortSignal;
}

class BaseApi {
    IMG_URL: string;
    avatar_url: string;
    static readonly IMG_URL: string = "https://www.sunyuanling.com/server/static/image/";
    static readonly avatar_url: string = "https://www.sunyuanling.com/server/static/avatar/";

    constructor() {
        this.IMG_URL = "https://www.sunyuanling.com/server/static/image/";
        this.avatar_url = "https://www.sunyuanling.com/server/static/image/avatar_thumbnail/";
    }

    private getToken(): string {
        return localStorage.getItem('token') || '';
    }

    private buildHeaders(options: RequestOptions): HeadersInit {
        const headers: Record<string, string> = {
            ...(this.getToken() ? { 'Authorization': `token ${this.getToken()}` } : {}),
            ...options.headers,
        };

        if (options.requestType === 'json') {
            headers['Content-Type'] = 'application/json';
        }
        // form 类型不需要设置 Content-Type，浏览器会自动处理
        return headers;
    }

    async request<T = unknown>(url: string, options: RequestOptions): Promise<T | null> {
        const method = options.method || 'GET';
        const headers = this.buildHeaders(options);

        let body: BodyInit | null | undefined = null;

        // 处理请求体
        if (method !== 'GET' && options.data) {
            if (options.requestType === 'json') {
                body = JSON.stringify(options.data);
            } else if (options.requestType === 'form' && options.data instanceof FormData) {
                body = options.data;
            } else {
                // 处理非 FormData 的 form 类型
                body = new URLSearchParams(options.data as Record<string, string>).toString();
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
                const errorResponse = await res.json().catch(() => null);
                console.error('请求失败:', res.status, errorResponse);
                throw new Error(`请求失败: ${res.status}`);
            }

            return (await res.json()) as T;
        } catch (e) {
            console.error('请求错误:', e);
            return null;
        }
    }

    get<T = unknown>(url: string, params?: Record<string, string>): Promise<T | null> {
        const query = params ? `?${new URLSearchParams(params).toString()}` : '';
        return this.request<T>(url + query, { method: 'GET' });
    }

    post<T = unknown>(url: string, data?: unknown, requestType: 'json' | 'form' = 'json'): Promise<T | null> {
        return this.request<T>(url, {
            method: 'POST',
            data,
            requestType
        });
    }

    put<T = unknown>(url: string, data?: unknown, requestType: 'json' | 'form' = 'json'): Promise<T | null> {
        return this.request<T>(url, {
            method: 'PUT',
            data,
            requestType
        });
    }

    delete<T = unknown>(url: string, data?: unknown, requestType: 'json' | 'form' = 'json'): Promise<T | null> {
        return this.request<T>(url, {
            method: 'DELETE',
            data,
            requestType
        });
    }

    // 登录验证方法
    async loginCheck(): Promise<boolean> {
        try {
            const res = await this.post<{ code: number; msg: string }>('verify/', {}, 'json');
            return res?.code === 200;
        } catch (e) {
            console.error('登录检查失败:', e);
            return false;
        }
    }

    // 获取登录用户信息
    async getUserInfo(): Promise<UserInfo | null> {
        const res = await this.post<ResType<UserInfo>>('GetUserInfo/GetSelfInfo', {}, 'json');
        return res?.code === 200 ? res.data : null;
    }

    // 颜色库
    getRandomColor(): string {
        const colorList = [
            '#a0f8f5', '#89f7d4', '#9beb9f', '#9ee1f7', '#f6caca',
            '#f6e9c0', '#f5c0f6', '#dea7fb', '#bd9de9',
            '#b5f4e6', '#8decd7', '#6feac0', '#72dab9'
        ];

        const index = Math.floor(Math.random() * colorList.length);
        const color = colorList[index];

        // 确保颜色代码格式正确
        return color.startsWith('#') ? color : `#${color}`;
    }
}

export default new BaseApi();
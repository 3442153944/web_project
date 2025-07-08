// src/types/common.ts
export interface ResType<T = unknown> {
    code: number;
    msg: string;
    data: T;
    status: number | string;
    token?: string;
}

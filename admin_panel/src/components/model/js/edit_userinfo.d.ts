// 在一个.d.ts文件中  
declare function edit_userinfo(options?: {  
    userid?: string | null,  
    username?: string | null,  
    user_avatar?: string | null,  
    user_address?: string | null,  
    password?: string | null,  
    user_back_img?: string | null,  
    phone?: string | null,  
    email?: string | null,  
    user_self_website?: string | null,  
    sex?: string | null,  
    select_work?: string | null,  
    occupation?: string | null,  
    birthday?: Date | string | null,  
    vip?: boolean | null,  
    account_status?: string | number | null,  
    account_permissions?: string[] | null  
}): Promise<any>; // 假设返回的是一个Promise，其解析值类型为any，你可以根据实际需要替换为更具体的类型  
  
export { edit_userinfo };
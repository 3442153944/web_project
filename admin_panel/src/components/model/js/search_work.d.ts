declare function search_ill_work(search_key:any,work_status:any,limit:any,offset:any): Promise<any>;
declare function search_comic_work(search_key:any,work_status:any,limit:any,offset:any): Promise<any>;
declare function search_novel_work(search_key:any, work_status:any, limit:any, offset:any):Promise<any>

export { search_ill_work, search_comic_work,search_novel_work };
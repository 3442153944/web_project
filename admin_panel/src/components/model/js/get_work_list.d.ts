declare function get_ill_worklist(limit:any,offset:any):any;
declare function get_comic_worklist(limit:any,offset:any):any;
declare function get_novel_work_list(limit:any,offset:any):any;
declare function get_novel_work_content_list(work_id:any,limit:any,offset:any):Promise<any>;

export { get_ill_worklist, get_comic_worklist ,get_novel_work_list,get_novel_work_content_list};
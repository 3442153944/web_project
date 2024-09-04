declare function update_ill_work_status(work_status:any,work_id:any): Promise<any>;
declare function update_comic_work_status(work_status:any,work_id:any): Promise<any>;
declare function update_novel_work_status(work_status:any, work_id:any): Promise<any>;
declare function update_novel_chapter_status(chapter_status:any,work_id:any,chapter_id:Array): Promise<any>;

export { update_ill_work_status,update_comic_work_status ,update_novel_work_status,update_novel_chapter_status};
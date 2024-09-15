declare function update_ill_work_status(work_status:any,work_id:any): Promise<any>;
declare function update_comic_work_status(work_status:any,work_id:any): Promise<any>;
declare function update_novel_work_status(work_status:any, work_id:any): Promise<any>;
declare function update_novel_chapter_status(chapter_status:any,work_id:any,chapter_id:Array): Promise<any>;
declare function delete_comment(comment_id_list:Array): Promise<any>;
declare function update_comment(comment_id:any,content:any): Promise<any>;

export { update_ill_work_status,update_comic_work_status ,update_novel_work_status,update_novel_chapter_status,
    delete_comment,update_comment
};
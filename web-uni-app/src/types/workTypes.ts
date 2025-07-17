// 文件路径：src/types/workTypes.ts
export interface BaseWork {
    userid: string;
    username: string;
    user_avatar: string | null;
    time: string;
    work_approved: string;
    work_tags?: string;
}

export interface IllustrationWork extends BaseWork {
    Illustration_id: number;
    name: string;
    content_file_list: string;
    brief_introduction?: string;
    age_classification?: string;
    belong_to_user_id: string;
    belong_to_user: string;
    belong_to_user_avatar: string | null;
    like_num?: number;
    views_num?: number;
}

export interface ComicWork extends BaseWork {
    id: number;
    work_name: string;
    content_file_list: string;
    brief_introduction?: string;
    belong_to_user: string;
    belong_to_userid: string;
    age_classification?: string;
}

export interface NovelWork extends BaseWork {
    work_id: number;
    work_name: string;
    brief_introduction?: string;
    category?: string;
    work_series?: string;
    is_vip_work?: string;
    work_status?: string;
    original?: string;
    belong_to_username: string;
    belong_to_userid: string;
    belong_to_avatar: string | null;
    work_cover?: string;
    work_create_time: string;
}

export interface WorkGroup<T> {
    count: number;
    list: T[];
}

export interface SearchResponseData {
    illustration: WorkGroup<IllustrationWork>;
    comic: WorkGroup<ComicWork>;
    novel: WorkGroup<NovelWork>;
}

export interface resType {
    data: SearchResponseData;
    status: number;
    msg: string;
    code: number;
}

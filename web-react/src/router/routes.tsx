import {lazy} from "react";
import type {RouteObject} from "react-router-dom";
import lazyLoad from "@/router/lazyout.tsx";

const routes:RouteObject[]=[
    {
        path:"/",
        //用户自动认证
        element:lazyLoad(lazy(()=>import("@/login_page/AuthGuard.tsx"))),
        children:[
            {
                path:"/",
                element:lazyLoad(lazy(()=>import("@/home/home.tsx"))),
                children:[
                    {
                        path:"/",
                        index:true,
                        element:lazyLoad(lazy(()=>import("@/home/ill/illMain.tsx")))
                    },{
                        path:"/ill",
                        element:lazyLoad(lazy(()=>import("@/home/ill/illMain.tsx")))
                    },
                    {
                        path:"/comic",
                        element:lazyLoad(lazy(()=>import("@/home/comic/comicMain.tsx")))
                    },
                    {
                        path:"/novel",
                        element:lazyLoad(lazy(()=>import("@/home/novel/novelMain.tsx")))
                    },
                    {
                        path:"/notice",
                        element:lazyLoad(lazy(()=>import("@/home/notice/noticeMain.tsx")))
                    },{
                        path:"/chat",
                        element:lazyLoad(lazy(()=>import("@/home/chat/chatMain.tsx")))
                    },{
                        path:"/user",
                        element:lazyLoad(lazy(()=>import("@/home/user/userMain.tsx")))
                    }
                ]
            },
        ]

    },
    {
        path:"/login",
        element:lazyLoad(lazy(()=>import("@/login_page/login.tsx")))
    }
]

export default routes;
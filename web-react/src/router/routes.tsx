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
                index:true,
                path:"/",
                element:lazyLoad(lazy(()=>import("@/home/home.tsx")))
            },
        ]

    },
    {
        path:"/login",
        element:lazyLoad(lazy(()=>import("@/login_page/login.tsx")))
    }
]

export default routes;
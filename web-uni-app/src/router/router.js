import { createRouter } from "uni-simple-router";

const router = createRouter({
  platform: process.env.UNI_PLATFORM, // 自动识别平台
  routes: [
    {
      path: "/pages/index/index", // 必须与 pages.json 路径一致
      component: () => import("@/pages/index/index.vue") // 补全 .vue 后缀
    },
    {
      path: "/pages/forgot/forgot",
      component: () => import("@/pages/forgot/forgot.vue")
    },
    {
      path: "/pages/register/register",
      component: () => import("@/pages/register/register.vue")
    }
  ]
});

export default router;
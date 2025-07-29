import { createSSRApp } from "vue";
import App from "./App.vue";
import { createPinia } from "pinia";
import uviewPlus from "uview-plus";

// 可选：你也可以直接引入 store/index 以初始化某些逻辑
// import pinia_file from "./store/index";

export function createApp() {
	const app = createSSRApp(App);
	const pinia = createPinia();

	app.use(pinia);
	app.use(uviewPlus);

	return {
		app,
	};
}

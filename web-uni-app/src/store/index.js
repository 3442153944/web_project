import { defineStore } from "pinia";

const useStore = defineStore("store", {
    state: () => {
        return {
            user_info: {

            },
            other_user_id: "",
            now_page:0,
            jump_page_info:{
                work_id:'',
                work_type:''
            }
        }
    }
})

export { useStore }
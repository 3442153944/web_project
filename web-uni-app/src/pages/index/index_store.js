import { defineStore } from "pinia";

const useIndexStore=defineStore("indexStore",{
    state:()=>{
        return {
            now_page:0
        }
    }
})

export {useIndexStore}
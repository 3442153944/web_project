import style from "./searchHistory.module.scss"
import {useEffect, useState} from "react"
import baseApi from "@/BaseApi.ts"
import useStore from "@/store.ts";
import type {ResType} from "@/types/resTypes.ts";

interface HistoryItem {
    id: number
    search_key: string
    user_id: string
    date: string
}

const SearchHistory = () => {
    const store = useStore()
    const [list, setList] = useState<string[]>(["无"])
    const api = baseApi

    useEffect(() => {
        (async () => {
            const res = await api.post<ResType<HistoryItem[]>>("api/GetSearchHis", {});
            console.log("res:", res);
            if (res&&res.code === 200 && res.data.length > 0) {
                const keywords = res.data.map(item => item.search_key);
                setList(keywords);
            }
        })();
    }, []);


    return (
        <div className={style.main}>
            <div className={"font-bold border-b-2 border-b-blue-400 p-3"}>
                <span>搜索历史</span>
            </div>
            <div className={"flex flex-wrap gap-1 max-h-24 overflow-hidden border-b-2 border-b-blue-400 p-3"}>
                {
                    list.map((item, index) => (
                        <div key={index}
                             className={"hover active p-1 rounded border-blue-400 font-semibold"}
                             style={{
                                 color: "white",
                                 background: baseApi.getRandomColor(),
                                 padding: "5px 15px"
                             }}
                             onClick={()=>{
                                 store.setSearchKey(item)
                             }}
                        >
                            {item}
                        </div>
                    ))
                }
            </div>
        </div>
    )
}

export default SearchHistory

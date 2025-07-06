import style from "./searchHistory.module.scss"
import {useState} from "react";

const SearchHistory = () => {
    const [list, setList]=useState<[string]>(["无"])
    return(
        <>
            <div className={style.main}>
                <div className={"font-bold border-b-2 border-b-blue-400"}>
                    <span>搜索历史</span>
                </div>
                <div className={"flex flex-wrap gap-1 max-h-24 overflow-hidden border-b-2 border-b-blue-400"}>
                    {
                        list.map((item, index) => {
                            return (
                                <div key={index} className={"hover active p-1 rounded border-blue-400"}>
                                    <img src={""} alt=""/>
                                    <span>{item}</span>
                                </div>
                            )
                        })
                    }
                </div>
            </div>
        </>
    )
};

export default SearchHistory;
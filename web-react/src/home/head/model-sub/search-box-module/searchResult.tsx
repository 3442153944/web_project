import style from "./searchResult.module.scss";
import React, {type Dispatch, type RefObject, type SetStateAction, useState} from "react";
import SearchHistory from "@/home/head/model-sub/search-box-module/searchHistory.tsx";
import baseApi from "@/BaseApi.ts";

interface Props {
    SearchKey: string;
    offSignal?: Dispatch<SetStateAction<boolean>>;
    searchBox?:RefObject<HTMLDivElement|null>
}

const SearchResult = ({ SearchKey, offSignal, searchBox }: Props) => {
    const [searchResult, setSearchResult] = useState(["无"]);
    const api=baseApi;
    const [resultWidth]=useState(():number=>{
        return searchBox?.current?.offsetWidth||0;
    })
    const [positionLeft]=useState(():number=>{
        return searchBox?.current?.offsetLeft||0;
    })

    const handleBackgroundClick = (e: React.MouseEvent<HTMLDivElement>) => {
        // 避免点击内容区域也触发关闭
        if (e.target === e.currentTarget) {
            offSignal?.(false);
        }
    };

    return (
        <div className={style.backGround} onClick={handleBackgroundClick}>
            <div className={style.searchResult} style={{ width: resultWidth, left: positionLeft }}>
                <SearchHistory />
            </div>
        </div>
    );
};

export default SearchResult;

import search from "@/assets/search.svg";
import style from "./searchBox.module.scss";
import {useEffect, useRef, type RefObject, useState} from "react";
import SearchResult from "./search-box-module/searchResult";
import useStore from "@/store.ts";

const SearchBox = () => {
    const store = useStore();
    const inputRef: RefObject<HTMLInputElement | null> = useRef(null);
    const searchBoxRef: RefObject<HTMLDivElement | null> = useRef(null);

    const searchKey = useStore((state) => state.searchKey);
    const showSearchResult = useStore((state)=>state.searchResultVisible)
    const setShowSearchResult = store.setSearchResultStatus;

    // 全局点击判断是否点击了组件外部
    useEffect(() => {
        const handleClickOutside = (e: MouseEvent) => {
            const box = searchBoxRef.current;
            // if (box && !box.contains(e.target as Node)) {
            //     console.log("点击了外部");
            //     setShowSearchResult(false);
            // }
        };

        document.addEventListener("click", handleClickOutside);
        return () => {
            document.removeEventListener("click", handleClickOutside);
        };
    }, []);

    return (
        <div className={`focus ${style.searchBox}`} ref={searchBoxRef}>
            <input
                className={style.input}
                value={searchKey}
                placeholder="请输入关键字"
                ref={inputRef}
                onFocus={() => setShowSearchResult(true)}
                onChange={(e) => store.setSearchKey(e.target.value)}
            />
            <div className={"ico hover active"}>
                <img src={search} alt="搜索" />
            </div>

            {showSearchResult && (
                <SearchResult
                    SearchKey={searchKey}
                    searchBox={searchBoxRef}
                    inputRef={inputRef}
                />
            )}
        </div>
    );
};

export default SearchBox;

import search from "@/assets/search.svg"
import style from "./searchBox.module.scss"
import {type RefObject, useEffect, useRef, useState} from "react";
import SearchResult from "./search-box-module/searchResult";

const SearchBox = () => {
    const [searchText, setSearchText] = useState("");
    const [searchRS, setSearchRS]=useState(false)
    const inputRef:RefObject<HTMLInputElement|null> = useRef<HTMLInputElement>(null);
    const searchBoxRef:RefObject<HTMLDivElement|null> = useRef<HTMLDivElement>(null);
    useEffect(() => {
        const inputElement = inputRef.current;
        if (!inputElement) return;

        const onFocus = () => setSearchRS(true);
        inputElement.addEventListener("focus", onFocus);

        return () => {
            inputElement.removeEventListener("focus", onFocus);
        };
    }, []);

    return (<>
        <div className={`focus ${style.searchBox}`} ref={searchBoxRef}>
            <input
                className={style.input}
                value={searchText}
                placeholder="请输入关键字"
                ref={inputRef}
                onChange={(e) => setSearchText(e.target.value)}
            />
            <div className={"ico hover active"}>
                <img src={search} alt="搜索"/>
            </div>
            {searchRS?<SearchResult SearchKey={searchText}
                                    offSignal={setSearchRS} searchBox={searchBoxRef}/>:<></>}
        </div>
    </>);
};

export default SearchBox;

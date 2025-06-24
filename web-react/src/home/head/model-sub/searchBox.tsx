import search from "@/assets/search.svg"
import style from "./searchBox.module.scss"
import { useState } from "react";

const SearchBox = () => {
    const [searchText, setSearchText] = useState("");

    const content=(<>
        <div className={style.searchBox}>
            <input
                className={style.input}
                value={searchText}
                placeholder="请输入关键字"
                onChange={(e) => setSearchText(e.target.value)}
            />
            <div className={style.searchBtn}>
                <img src={search} alt="搜索" />
            </div>
        </div>
    </>)

    return content;
};

export default SearchBox;

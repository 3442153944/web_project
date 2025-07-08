import style from "./searchResult.module.scss";
import React, {
    type Dispatch,
    type RefObject,
    type SetStateAction,
    useEffect,
    useState,
    useCallback,
    useRef
} from "react";
import SearchHistory from "@/home/head/model-sub/search-box-module/searchHistory.tsx";
import { type SearchResponseData } from "@/types/workTypes.ts";
import { type ResTypes } from "@/types/resTypes.ts";
import baseApi from "@/BaseApi.ts";
import {motion,AnimatePresence} from "framer-motion";

interface Props {
    SearchKey: string;
    offSignal?: Dispatch<SetStateAction<boolean>>;
    searchBox?: RefObject<HTMLDivElement | null>;
    inputRef?: RefObject<HTMLInputElement | null>;
    searchStatus: boolean;
    setSearchText: Dispatch<SetStateAction<string>>;
}

const SearchResult = ({ SearchKey, offSignal, searchBox, inputRef, searchStatus, setSearchText }: Props) => {
    const [searchResult, setSearchResult] = useState<SearchResponseData | null>(null);
    const [isComposing, setIsComposing] = useState(false);
    const api = baseApi;
    const timerRef = useRef<NodeJS.Timeout | null>(null);

    // 使用 ref 存储最新的搜索关键词
    const searchKeyRef = useRef(SearchKey);
    useEffect(() => {
        searchKeyRef.current = SearchKey;
    }, [SearchKey]);

    // 获取搜索框位置和宽度
    const resultWidth = searchBox?.current?.offsetWidth || 0;
    const positionLeft = searchBox?.current?.offsetLeft || 0;

    const handleBackgroundClick = (e: React.MouseEvent<HTMLDivElement>) => {
        if (e.target === e.currentTarget) {
            offSignal?.(false);
        }
    };

    // 输入法事件处理函数
    const handleCompositionStart = useCallback(() => setIsComposing(true), []);
    const handleCompositionEnd = useCallback(() => setIsComposing(false), []);

    // 搜索函数
    const performSearch = useCallback(async () => {
        const currentSearchKey = searchKeyRef.current.trim();
        if (!currentSearchKey) {
            setSearchResult(null);
            return;
        }

        try {
            const res = await api.post<ResTypes & { data: SearchResponseData }>("api/Search", {
                search_key: currentSearchKey
            });

            if (res.code === 200) {
                console.log("res:", res.data);
                setSearchResult(res.data);
            }
        } catch (error) {
            console.error("Search error:", error);
            setSearchResult(null);
        }
    }, [api]);

    // 主 useEffect：处理搜索逻辑
    useEffect(() => {
        // 清除之前的定时器
        if (timerRef.current) {
            clearTimeout(timerRef.current);
        }

        // 设置新的防抖定时器
        timerRef.current = setTimeout(() => {
            if (!isComposing && SearchKey.trim()) {
                performSearch();
            }
        }, 500);

        return () => {
            if (timerRef.current) {
                clearTimeout(timerRef.current);
            }
        };
    }, [SearchKey, isComposing, performSearch]);

    // 事件监听器 useEffect
    useEffect(() => {
        const inputElement = inputRef?.current;
        if (!inputElement) return;

        inputElement.addEventListener("compositionstart", handleCompositionStart);
        inputElement.addEventListener("compositionend", handleCompositionEnd);

        return () => {
            inputElement.removeEventListener("compositionstart", handleCompositionStart);
            inputElement.removeEventListener("compositionend", handleCompositionEnd);
        };
    }, [inputRef, handleCompositionStart, handleCompositionEnd]);

    return (
        <div className={style.backGround} onClick={handleBackgroundClick}>
            <AnimatePresence>
                {searchStatus&&(<motion.div
                    initial={{ opacity: 0, y: -20 }}
                    animate={{ opacity: 1, y: 0 }}
                    exit={{opacity: 0, y: -20}}
                    transition={{duration:0.3}}
                    className={style.searchResult}
                    key="searchResult"
                    style={{width:resultWidth,left:positionLeft}}
                >
                    <SearchHistory setSearchText={setSearchText} />
                    {searchResult && (
                        <>
                            <div className="p-2 font-bold">
                                插画作品（{searchResult.illustration.count}）
                            </div>
                            {searchResult.illustration.list.map((item) => (
                                <span key={item.Illustration_id}>{item.name}</span>
                            ))}
                        </>
                    )}
                </motion.div>)}
            </AnimatePresence>
        </div>
    );
};

export default SearchResult;
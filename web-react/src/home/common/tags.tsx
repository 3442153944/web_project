import baseApi from "@/BaseApi.ts";
import left from "@/assets/left.svg";
import style from "./tags.module.scss";
import useStore from "@/store.ts";
import {useRef, useEffect, useState} from "react"; // 引入关键Hook

interface Props {
    tags?: string[];
}

const Tags = ({ tags = ["默认测试项一"] }: Props) => {
    const store = useStore();

    // 1. 使用useRef保存颜色数组，确保只初始化一次
    const colorRef = useRef<Record<string, string>>({});
    const tagsRef=useRef<HTMLDivElement|null>(null)
    const leftCheckRef=useRef<HTMLDivElement|null>(null)
    const rightCheckRef=useRef<HTMLDivElement|null>(null)
    const [leftBtnClick,setLeftBtnClick]=useState(false)
    const [rightBtnClick,setRightBtnClick]=useState(false)
    const obsLeft=useRef<IntersectionObserver|null>(null);
    const obsRight=useRef<IntersectionObserver|null>(null)
    //滑动函数
    const scrollToTag = (direction: number) => {
        if (tagsRef.current) {
            const tagsBox = tagsRef.current;
            // 获取当前滚动位置
            const startPosition = tagsBox.scrollLeft;
            // 计算目标位置（每次滚动300px）
            const targetPosition = startPosition + (direction * 300);
            // 确保目标位置在有效范围内
            const maxScroll = tagsBox.scrollWidth - tagsBox.clientWidth;
            const finalPosition = Math.max(0, Math.min(targetPosition, maxScroll));

            // 动画参数
            const duration = 500; // 0.5秒
            const startTime = performance.now();

            // 缓动函数 - 加速减速效果
            const easeInOutQuad = (t: number) => {
                return t < 0.5
                    ? 4 * t * t * t
                    : 1 - Math.pow(-2 * t + 2, 3) / 2;
            };

            // 动画函数
            const animate = (currentTime: number) => {
                const elapsed = currentTime - startTime;
                const progress = Math.min(elapsed / duration, 1);
                const easedProgress = easeInOutQuad(progress);

                // 计算当前滚动位置
                tagsBox.scrollLeft = startPosition + (finalPosition - startPosition) * easedProgress;

                // 继续动画直到完成
                if (progress < 1) {
                    requestAnimationFrame(animate);
                }
            };

            // 启动动画
            requestAnimationFrame(animate);
        }
    };
    //滑动检查相关初始化
    useEffect(()=>{
        obsLeft.current=new IntersectionObserver((entries)=>{
            if(entries[0].isIntersecting){
                setLeftBtnClick(false)
            }
            else{
                setLeftBtnClick(true)
            }
        })
        obsRight.current=new IntersectionObserver((entries)=>{
            if(entries[0].isIntersecting){
                setRightBtnClick(false)
            }
            else{
                setRightBtnClick(true)
            }
        })
        if (leftCheckRef.current) {
            obsLeft.current.observe(leftCheckRef.current);
        }

        if (rightCheckRef.current) {
            obsRight.current.observe(rightCheckRef.current);
        }
        return () => {
            obsLeft.current?.disconnect()
            obsRight.current?.disconnect()
        };
    },[])

    // 2. 初始化颜色映射（只在tags变化时执行）
    useEffect(() => {
        if (!tags) return;

        tags.forEach(tag => {
            // 只为尚未分配颜色的标签生成新颜色
            if (!colorRef.current[tag]) {
                colorRef.current[tag] = baseApi.getRandomColor();
            }
        });
    }, [tags]); // 依赖tags确保新标签也能获得颜色

    // 3. 使用useCallback缓存事件处理函数
    const handleTagClick = (tag: string) => {
        store.setSearchKey(tag);
        store.setSearchResultStatus(true);
    };

    return (
        <div className={style.tags}>
            <div className={style.btnBox}>
                <div className={style.leftBtn} style={{cursor:(leftBtnClick?"pointer":"not-allowed"),pointerEvents:(leftBtnClick?"auto":"none")}} onClick={()=>{scrollToTag(-3)}}>
                    <img src={left} className={"ico"} alt="" />
                </div>
                <div className={style.rightBtn} style={{cursor:(rightBtnClick?"pointer":"not-allowed"),pointerEvents:(rightBtnClick?"auto":"none")}} onClick={()=>{scrollToTag(3)}}>
                    <img src={left} alt={""} className={"ico"} />
                </div>
            </div>
            <div className={style.tagBox} ref={tagsRef}>
                <div className={"h-full w-0.5 opacity-0 pointer-events-none"} ref={leftCheckRef}></div>
                {tags?.map((tag, index) => (
                    <div
                        key={`${tag}-${index}`} // 增加tag内容作为key的一部分
                        className={style.tag}
                        style={{
                            backgroundColor: colorRef.current[tag] || "#ccc", // 从ref获取颜色
                            color: "white"
                        }}
                        onClick={() => handleTagClick(tag)}
                    >
                        {tag}
                    </div>
                ))}
                <div className={"h-full w-0.5 opacity-0 pointer-events-none"} ref={rightCheckRef}></div>
            </div>
        </div>
    );
};

export default Tags;
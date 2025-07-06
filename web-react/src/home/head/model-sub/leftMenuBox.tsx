import menu from "@/assets/more.svg"
import style from "./leftMenuBox.module.scss"
import {type RefObject, useEffect, useRef, useState} from "react";
import { motion, AnimatePresence } from "framer-motion";
import LeftMenuMain from "@/home/head/model-sub/leftMenu-module/leftMenuMain.tsx";

const LeftMenuBox=()=>{
    const [listShow,setListShow]=useState(false)
    const leftMenuBoxRef:RefObject<HTMLDivElement | null>=useRef<HTMLDivElement>(null);
    useEffect(() => {
        const hideMenu = (event: MouseEvent) => {
            if (leftMenuBoxRef.current && !leftMenuBoxRef.current.contains(event.target as Node)) {
                setListShow(false);
            }
        };

        document.addEventListener("mousedown", hideMenu);

        return () => {
            document.removeEventListener("mousedown", hideMenu);
        };
    }, []);

    return( <>
        <div className={"relative flex-row items-center flex"} ref={leftMenuBoxRef}>
            <div className={"hover active"} onClick={()=>setListShow(!listShow)}>
                <img src={menu} className={"ico"} alt="展开"/>
            </div>
            <AnimatePresence>
                {listShow&&(
                  <motion.div key="leftMenuBox"
                  initial={{ opacity: 0, x: -20 }}
                  animate={{opacity:1,x:0}}
                  exit={{ opacity: 0, x: -20 }}
                  transition={{duration:0.3}}
                  className={style.main}>
                      <LeftMenuMain></LeftMenuMain>
                  </motion.div>
                )}
            </AnimatePresence>
        </div>
    </>)
}

export default LeftMenuBox
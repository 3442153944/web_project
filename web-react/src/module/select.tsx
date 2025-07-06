import { type JSX, useState, useRef, useEffect } from "react";
import style from "./select.module.scss";
import { motion, AnimatePresence } from "framer-motion";
import RenderIcon from "@/module/rendererIcon.tsx";

// Option 和 Props 定义同你已有的一样
interface Option {
    icon: string | JSX.Element | File;
    value: string;
}
interface SelectProps {
    options: Option[];
    onChange?: (value: Option) => void;
}

const Select = ({ options, onChange }: SelectProps) => {
    const [open, setOpen] = useState(false);
    const [selected, setSelected] = useState<Option | null>(null);
    const wrapperRef = useRef<HTMLDivElement>(null); //

    const handleSelect = (item: Option) => {
        setSelected(item);
        onChange?.(item);
        setOpen(false);
    };

    useEffect(() => {
        const handleClickOutside = (event: MouseEvent) => {
            if (wrapperRef.current && !wrapperRef.current.contains(event.target as Node)) {
                setOpen(false); // 点击外部时关闭下拉框
            }
        };

        document.addEventListener("mousedown", handleClickOutside);
        return () => {
            document.removeEventListener("mousedown", handleClickOutside);
        };
    }, []);

    return (
        <div ref={wrapperRef} className={style.selectWrapper}>
            <div className={style.selectBox} onClick={() => setOpen(!open)}>
                <span className={"flex items-center justify-start gap-[5px]"}>
                    {selected ? (
                        <>
                            <RenderIcon icon={selected.icon} />
                            {selected.value}
                        </>
                    ) : (
                        "投稿作品"
                    )}
                </span>
                <span className={style.arrow}>{open ? "▲" : "▼"}</span>
            </div>
            <AnimatePresence>
                {open && (
                    <motion.div
                        className={style.optionList}
                        initial={{ opacity: 0, y: -10 }}
                        animate={{ opacity: 1, y: 0 }}
                        exit={{ opacity: 0, y: -10 }}
                        transition={{ duration: 0.2 }}
                    >
                        {options.map((opt, index) => (
                            <div
                                key={index}
                                className={`hover active ${style.optionItem}`}
                                onClick={() => handleSelect(opt)}
                            >
                                <RenderIcon icon={opt.icon} />
                                <span>{opt.value}</span>
                            </div>
                        ))}
                    </motion.div>
                )}
            </AnimatePresence>
        </div>
    );
};

export default Select;

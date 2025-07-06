// rendererIcon.tsx
import type { JSX } from "react";
import style from "./select.module.scss";

interface Props {
    icon: string | File | JSX.Element;
}

const RenderIcon = ({ icon }: Props) => {
    if (typeof icon === "string") {
        return <img src={icon} className={style.iconImg} alt="" />;
    }
    if (icon instanceof File) {
        const url = URL.createObjectURL(icon);
        return <img src={url} className={style.iconImg} alt="" />;
    }
    if (typeof icon === "object" && (icon as JSX.Element).type) {
        return icon as JSX.Element;
    }
    return null;
};

export default RenderIcon;

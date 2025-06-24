import menu from "@/assets/more.svg"
import style from "./leftMenuBox.module.scss"

const LeftMenuBox=()=>{
    return( <>
        <div className={style.leftMenuBox}>
            <div className={style.btn}>
                <img src={menu} alt="展开"/>
            </div>
            <div className={style.listBox}>

            </div>
        </div>
    </>)
}

export default LeftMenuBox
import HeadMain from "@/home/head/head-main.tsx";
import {Outlet} from "react-router-dom";

function Home() {
  return (
    <div className="Home">
        <HeadMain />
     <Outlet/>
    </div>
  )
}
export default Home
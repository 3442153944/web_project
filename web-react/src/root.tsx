import {useRoutes} from "react-router-dom";
import routes from "@/router/routes.tsx";
import "@/root.scss"
import "@/main.css"

function Root() {
    return useRoutes(routes)
}

export default Root;

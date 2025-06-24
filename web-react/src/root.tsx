import {useRoutes} from "react-router-dom";
import routes from "@/router/routes.tsx";

function Root() {
    return useRoutes( routes)
}

export default Root;

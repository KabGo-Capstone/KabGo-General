import { Routes, Route, Navigate } from "react-router-dom";
import ContentComponent from "~/components/Content/ContentComponent";
import Details from "~/components/Details";
import BaseLayout from "~/layouts/BaseLayout";


const AppRoutes = () => {
    return (
        <Routes>
             {/* Protected routes */}
             {/* <Route element={<ProtectedRoute />}>
             </Route> */}
            <Route path = "/" element = {<BaseLayout/>}>
                <Route index element = {<ContentComponent/>}></Route>
                <Route path = "details" element = {<Details/>}></Route>
            </Route>
        </Routes>
    );
};

export default AppRoutes;

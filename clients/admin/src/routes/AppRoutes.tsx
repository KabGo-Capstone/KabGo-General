import { Routes, Route, Navigate } from "react-router-dom";
import BaseLayout from "~/layouts/BaseLayout";


const AppRoutes = () => {
    return (
        <Routes>
             {/* Protected routes */}
             {/* <Route element={<ProtectedRoute />}>
             </Route> */}
            <Route path = "/" element = {<BaseLayout/>}>
            </Route>
        </Routes>
    );
};

export default AppRoutes;

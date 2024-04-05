import { Routes, Route, Navigate } from "react-router-dom";
import ContentComponent from "~/components/Content/ContentComponent";
import Details from "~/components/Details";
import BaseLayout from "~/layouts/BaseLayout";

import { useAuth0 } from "@auth0/auth0-react";
import { AuthenticationGuard } from "../components/Authentication/authentication-guard";
import { useEffect } from "react";
import { CallbackPage } from "~/pages/callback-page";

const AppRoutes = () => {
    // const { loginWithRedirect } = useAuth0();

    // useEffect(() => {
        
    //     const handleLogin = async () => {

    //         await loginWithRedirect({
    //             appState: {
    //               returnTo: "/",
    //             },
    //             authorizationParams: {
    //               prompt: "login",
    //             },
    //           });
    //     };
    
    //     handleLogin();
    
    //   }, []);

    return (
        <Routes>
             {/* Protected routes */}
             {/* <Route element={<ProtectedRoute />}> 
             </Route> */}
            <Route path = "/" element = {<AuthenticationGuard component={BaseLayout} /> }>
                <Route index element = {<ContentComponent/>}></Route>
                <Route path = "details" element = {<Details />}></Route>
            </Route>
            <Route path="/callback" element={<CallbackPage />} />
        </Routes>
    );
};

export default AppRoutes;

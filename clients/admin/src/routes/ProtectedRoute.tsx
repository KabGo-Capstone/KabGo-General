import React from 'react';
import { Navigate, Outlet, useSearchParams } from "react-router-dom";

interface ProtectProps {
    auth?: boolean;
}
  
const ProtectedRoute: React.FC<ProtectProps> = ({ auth = false }: ProtectProps) => {
    return <Outlet />;
}

export default ProtectedRoute;
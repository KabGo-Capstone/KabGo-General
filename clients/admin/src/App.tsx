import './App.module.css';

import { useEffect } from 'react';
import { useLocation } from 'react-router-dom';
import AppRoutes from "~/routes/AppRoutes"

function App() {
  const location = useLocation();

  useEffect(() => {
    window.scrollTo(0, 0);
  }, [location]);

  return <AppRoutes />
}


export default App;
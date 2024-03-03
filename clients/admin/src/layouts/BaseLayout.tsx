import React from 'react';
import { Layout, theme } from 'antd';
import Sidebar from '~/components/Sidebar/Sidebar';
import NavBar from '~/components/Navbar/Navbar';
import { Outlet } from 'react-router-dom';


const { Header, Content, Footer, Sider } = Layout;

const BaseLayout: React.FC = () => {
  const {
    token: { colorBgContainer, borderRadiusLG },
  } = theme.useToken();

  return (
    <Layout hasSider>
      <Sidebar />
      <Layout style={{ marginLeft: 200 }}>
        <NavBar />
        <Outlet />
      </Layout>
    </Layout>
  );
};

export default BaseLayout;

import React from 'react';
import {
  AppstoreOutlined,
  BarChartOutlined,
  CloudOutlined,
  ShopOutlined,
  TeamOutlined,
  UploadOutlined,
  UserOutlined,
  VideoCameraOutlined,
} from '@ant-design/icons';
import type { MenuProps } from 'antd';
import { Layout, Menu, theme } from 'antd';
import Sidebar from '~/components/Sidebar/Sidebar';
import NavBar from '~/components/Navbar/Navbar';
import ContentComponent from '~/components/Content/ContentComponent';
import Edit from '~/components/Edit/edit';


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
        <ContentComponent />
      </Layout>
    </Layout>
  );
};

export default BaseLayout;

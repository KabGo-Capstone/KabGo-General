import React from "react";
import {
  AppstoreOutlined,
  BarChartOutlined,
  CloudOutlined,
  ShopOutlined,
  TeamOutlined,
  UploadOutlined,
  UserOutlined,
  VideoCameraOutlined,
} from "@ant-design/icons";
import type { MenuProps } from "antd";
import { Layout, Menu, theme } from "antd";
import Sidebar from "~/components/Sidebar/Sidebar";

const { Header, Content, Footer, Sider } = Layout;

const NavBar: React.FC = () => {
  const {
    token: { colorBgContainer, borderRadiusLG },
  } = theme.useToken();

  return (
    <Header
      style={{ borderRadius: borderRadiusLG, background: colorBgContainer }}
      className="!mt-3.5 !mb-0 !mx-3.5 !p-0"
    />
  );
};

export default NavBar;

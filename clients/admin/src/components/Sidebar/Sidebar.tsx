import { ReactComponent as Kabgo } from "assets/svg/Sidebar/kabgo.svg";

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

const { Sider } = Layout;

const items: MenuProps['items'] = [
    UserOutlined,
    VideoCameraOutlined,
    UploadOutlined,
    BarChartOutlined,
    CloudOutlined,
    AppstoreOutlined,
    TeamOutlined,
    ShopOutlined,
  ].map((icon, index) => ({
    key: String(index + 1),
    icon: React.createElement(icon),
    label: `nav ${index + 1}`,
  }));

const Sidebar: React.FC = () => {

  return (
    <Sider
      className="!overflow-auto !h-screen !fixed !inset-y-0 !left-0 !font-medium"
      theme="light"
    >
      <div className="demo-logo-vertical" />
      <Kabgo className="!w-36 !mt-4 !mx-6"/>
      <Menu
        theme="light"
        mode="inline"
        defaultSelectedKeys={["4"]}
        items={items}
      />
    </Sider>
  );
};

export default Sidebar;

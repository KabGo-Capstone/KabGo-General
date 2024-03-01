import { ReactComponent as Kabgo } from "assets/svg/Sidebar/kabgo.svg";

import React from "react";
import {
  CarOutlined,
  HomeOutlined,
  AppstoreOutlined,
  BarChartOutlined,
  CloudOutlined,
  ShopOutlined,
  TeamOutlined,
  UploadOutlined,
  UserOutlined,
  FileTextOutlined,
  UsergroupAddOutlined
} from "@ant-design/icons";

import type { MenuProps } from "antd";

import { Layout, Menu, theme } from "antd";

const { Sider } = Layout;

const labels = ["Dashboard", "Admin", "Tài xế", "Khách hàng", "Service phương tiện", "Loại Phương Tiện", "Hóa Đơn"];


const items: MenuProps['items'] = [
    HomeOutlined,
    UserOutlined,
    CarOutlined,
    UsergroupAddOutlined,
    ShopOutlined,
    AppstoreOutlined,
    FileTextOutlined,
  ].map((icon, index) => ({
    key: String(index + 1),
    icon: React.createElement(icon),
    label: labels[index],
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

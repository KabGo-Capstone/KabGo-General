import React from "react";
import { ReactComponent as LogOutSvgIcon } from '../../assets/svg/Sidebar/logout.svg';
import Avatar from '../../assets/images/avatar.png';

import {
  ArrowLeftOutlined,
  ReloadOutlined,
  AppstoreOutlined,
  BarChartOutlined,
  CloudOutlined,
  ShopOutlined,
  TeamOutlined,
  UploadOutlined,
  UserOutlined,
  VideoCameraOutlined,
  ProfileOutlined,
  AreaChartOutlined,
  BellOutlined,
  SettingOutlined
} from "@ant-design/icons";
import type { MenuProps } from "antd";
import { Layout, Menu, theme, Button, Typography, Divider } from "antd";
import Sidebar from "~/components/Sidebar/Sidebar";

const { Header, Content, Footer, Sider } = Layout;

const NavBar: React.FC = () => {
  const {
    token: { colorBgContainer, borderRadiusLG },
  } = theme.useToken();

  return (
    <Header
      style={{ borderRadius: borderRadiusLG, background: colorBgContainer }}
      className="!mt-3.5 !mb-0 !mx-3.5 !flex !justify-between !p-4"
    >
      <div className="flex items-center">
        <Button className="!w-8 !h-8 !flex !items-center !justify-center !bg-gray-200 !hover:bg-gray-400 mr-2">
          <ArrowLeftOutlined />
        </Button>
        <Button className="!w-8 !h-8 !flex !items-center !justify-center !bg-gray-200 !hover:bg-gray-400 !mr-5">
          <ReloadOutlined />
        </Button>
        <Typography.Text className="!text-gray-500 !text-lg !ml-2 !font-bold">Admin</Typography.Text>
      </div>

      <div className="flex items-center !gap-6">
        <div className="flex items-center">
          <Button className="!w-8 !h-8 !flex !items-center !justify-center !bg-gray-200 !hover:bg-gray-400 mr-2 !rounded-full">
            <UserOutlined />
          </Button>
          <Button className="!w-8 !h-8 !flex !items-center !justify-center !bg-gray-200 !hover:bg-gray-400 !mr-2 !rounded-full">
            <BellOutlined />
          </Button>
          <Button className="!w-8 !h-8 !flex !items-center !justify-center !bg-gray-200 !hover:bg-gray-400 !mr-2 !rounded-full">
            <SettingOutlined />
          </Button>
          <Button className="!w-auto !h-auto  !flex !items-center !justify-center !p-0 !mr-2 !rounded-full">
            <LogOutSvgIcon />
          </Button>
        </div>
        <div className="!flex !items-center !justify-center gap-2" style={{ lineHeight: '0px' }}>
          <div>
            <Typography.Text className="!font-bold">Tran Dam Gia Huy</Typography.Text>
            <br/>
            <Typography.Text>Administrator</Typography.Text>
          </div>
          <div>
            <img src={Avatar} alt="Avatar" />
          </div>
        </div>
      </div>
    </Header>
  );
};

export default NavBar;

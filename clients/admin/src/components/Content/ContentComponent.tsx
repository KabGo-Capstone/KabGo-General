import React from "react";
import { Button, Layout, theme } from "antd";

import { Space, Table, Tag } from "antd";
import type { TableProps } from "antd";
import axiosClient from "~/utils/axiosClient";

const { Content } = Layout;

interface DataType {
  id: string;
  gender: string;
  email:string;
  password: string;
  dob: string;
  verified: boolean;
  avatar: string;
  first_name: string;
  last_name: string;
  address: string;
}

const columns: TableProps<DataType>["columns"] = [
  {
    title: "STT",
    dataIndex: "id",
    key: "id",
  },
  {
    title: "Name",
    dataIndex: "name",
    key: "name",
    render: (_, record) => (
      <Space size="middle">
        <a>{record.first_name} {record.last_name}</a>
      </Space>
    ),
  },
  {
    title: "Email",
    dataIndex: "email",
    key: "email",
    width: "15%",
  },
  {
    title: "Address",
    dataIndex: "address",
    key: "address",
    width: "23%",
  },
  
  {
    title: "Status",
    dataIndex: "status",
    key: "status",
    render: (_, record) => (
      <span className={record.verified ? 'text-green-500' : 'text-red-500'}>
        {record.verified ? "Đã duyệt" : "Chờ xử lý"}
      </span>
    )
  },
  {
    title: "Actions",
    key: "action",
    render: (_, record) => (
      <div className="!flex gap-2">
        {record.verified ? <Button className="!min-w-80" onClick={()=>{
          // axiosClient.post(record.id);
        }}>
          Hủy
        </Button> : <Button className="!min-w-80" onClick={()=>{
          // axiosClient.post(record.id);
        }}>
          Duyệt
        </Button>}
        
        <Button className="!bg-red-500 !text-white !hover:bg-red-700" onClick={()=>{
          // axiosClient.post(record.id);
        }}>
          Xóa
        </Button>

        <Button onClick={()=>{
          // axiosClient.post(record.id);
        }}>
          Chi tiết
        </Button>
      </div>
    ),
  },
];

const data: DataType[] = [
    {
    id: '1',
    first_name: "Minh",
    last_name: "Nguyen",
    password: '$2a$04$4F68GFkr7Dt.hsRNRJ.dDeqixqtGMYrh0CKdMfdh1Y8EE9yHsnfam',
    dob: "2002-10-15",
    gender: "male",
    address: "25 Đào Trí, Phường Phú Thuận, Quận 7, TP.HCM",  
    verified: false,
    avatar: 'https://example.com',
    email: "nguyenducminh@gmail.com"
  },
  {
    id: '2',
    first_name: "Khoa",
    last_name: "Nguyen",
    password: '$2a$04$4F68GFkr7Dt.hsRNRJ.dDeqixqtGMYrh0CKdMfdh1Y8EE9yHsnfam',
    dob: "2002-4-14",
    gender: "male",
    address: "1647 Phạm Thế Hiển, Phường 6, Quận 8, TP.HCM",  
    verified: true,
    avatar: 'https://example.com',
    email: "khoanguyen@gmail.com"

  },  
  {
    id: '3',
    first_name: "Huy",
    last_name: "Nguyen",
    password: '$2a$04$4F68GFkr7Dt.hsRNRJ.dDeqixqtGMYrh0CKdMfdh1Y8EE9yHsnfam',
    dob: "2002-10-15",
    gender: "male",
    address: "22 Huỳnh Đình Hai, Phường 24, Quận Bình Thạnh, TP.HCM",  
    verified: false,
    avatar: 'https://example.com',
    email: "huynguyen@gmail.com"
  },
  {
     id: '4',
     first_name: "Khang",
     last_name: "Dinh",
     password: '$2a$04$4F68GFkr7Dt.hsRNRJ.dDeqixqtGMYrh0CKdMfdh1Y8EE9yHsnfam',
     dob: "2002-4-21",
     gender: "male",
     address: "22 Đường Số 10, Phường Thảo Điền, Quận 2, TP.HCM",  
     verified: true,
     avatar: 'https://example.com',
     email: "khangdinh@gmail.com"
  },
  {
     id: '5',
     first_name: "Thanh",
     last_name: "Bui",
     password: '$2a$04$4F68GFkr7Dt.hsRNRJ.dDeqixqtGMYrh0CKdMfdh1Y8EE9yHsnfam',
     dob: "2002-10-15",
     gender: "male",
     address: "227 Nguyễn Văn Cừ, Phường 4, Quận 5, TP.HCM",  
     verified: true,
     avatar: 'https://example.com',
     email: "thanhbui@gmail.com"
  },
];

const ContentComponent: React.FC = () => {
  const {
    token: { colorBgContainer, borderRadiusLG },
  } = theme.useToken();

  return (
    <Content
      style={{ overflow: "initial" }}
      className="!mt-4 !mb-0 !mx-3.5 !p-0"
    >
      <div
        style={{
          padding: 24,
          textAlign: "center",
          background: colorBgContainer,
          borderRadius: borderRadiusLG,
        }}
      >
        <Table
          columns={columns}
          dataSource={data}
        />
      </div>
    </Content>
  );
};

export default ContentComponent;

import React, { useEffect, useState } from "react";
import { Button, Layout, theme } from "antd";
import { Space, Table, Tag } from "antd";
import type { TableProps } from "antd";
import axiosClient from "~/utils/axiosClient";
import { Navigate, useNavigate } from "react-router-dom";

const { Content } = Layout;

interface DataType {
  id: string;
  gender: string;
  email: string;
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
        {record.verified ? <Button className="!min-w-80" onClick={() => {
          // axiosClient.post("/v1/driver/"{});
        }}>
          Hủy
        </Button> : <Button className="!min-w-80" onClick={() => handleVerify(record)}>
          Duyệt
        </Button >}

        <Button className="!bg-red-500 !text-white !hover:bg-red-700" onClick={() => {
          // axiosClient.post("/v1/driver/delete" + {record.id});
        }}>
          Xóa
        </Button>

        <Button onClick={() => {
          const navigate = useNavigate();
          navigate("/details");
        }}>
          Chi tiết
        </Button>
      </div>
    ),
  },
];

const ContentComponent: React.FC = () => {
  const {
    token: { colorBgContainer, borderRadiusLG },
  } = theme.useToken();

  const [data, setData] = useState<DataType[]>([]);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await axiosClient.get("/v1/driver");
        setData(response.data);
      } catch (error) {
        console.error("Error fetching data:", error);
      }
    };

    fetchData();
  }, []);
  
  const handleVerify = async (record: DataType) => {
    try {
      await axiosClient.post("/v1/driver/verify/" + record.id);
      const response = await axiosClient.get("/v1/driver");
      setData(response.data);
    } catch (error) {
      console.error("Error verifying driver:", error);
    }
  };

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
function handleVerify(record: DataType): void {
  throw new Error("Function not implemented.");
}


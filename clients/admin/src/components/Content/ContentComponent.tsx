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
    firstName: string;
    lastName: string;
    address: string;
  }

  const ContentComponent: React.FC = () => {
    const navigate = useNavigate();
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
            <p>{record.firstName} {record.lastName}</p>
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
          <Tag color={record.verified ? 'green' : 'red'} className="!text-sm !p-1.5 !pl-3 !pr-3">
            {record.verified ? "Đã duyệt" : "Chờ xử lý"}
          </Tag>
        ),
      },
      {
        title: "Actions",
        key: "action",
        render: (_, record) => (
          <div className="!flex gap-2">
            {record.verified ? <Button className="!w-1/3" onClick={() => {}}>
              Hủy
            </Button> : 
            <Button className="!w-1/3" onClick={() => handleVerify(record)}>
              Duyệt
            </Button >}
    
            <Button className="!w-1/3 !bg-red-500 !text-white !hover:bg-red-700" onClick={() => handleDelete(record)}>
              Xóa
            </Button>
    
            <Button onClick={() => {
              navigate("/details", { state: { record } });
            }}>
              Chi tiết
            </Button>
          </div>
        ),
      },
    ];
    
    const {
      token: { colorBgContainer, borderRadiusLG },
    } = theme.useToken();

    const [data, setData] = useState<DataType[]>([]);

    useEffect(() => {
      const fetchData = async () => {
        try {
          const response = await axiosClient.get("/v1/driver/approval");
          const supplyArray =  response.data.map((item: { supply: any; }) => item.supply);
          // console.log(supplyArray);
          setData(supplyArray);
        } catch (error) {
          console.error("Error fetching data:", error);
        }
      };

      fetchData();
    }, []);
    
    const handleDelete = async (record: DataType) => {
      try {
        await axiosClient.delete("/v1/driver/approval/delete/" + record.id);
        const response = await axiosClient.get("/v1/driver/approval");
        const supplyArray =  response.data.map((item: { supply: any; }) => item.supply);
        setData(supplyArray);
      } catch (error) {
        console.error("Error delete driver:", error);
      }
    };

    const handleVerify = async (record: DataType) => {
      try {
        await axiosClient.post("/v1/driver/approval/approve/" + record.id);
        const response = await axiosClient.get("/v1/driver/approval");
        const supplyArray =  response.data.map((item: { supply: any; }) => item.supply);
        setData(supplyArray);
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


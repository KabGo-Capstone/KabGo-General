import React, { useEffect, useState } from "react";
import { Button, Layout, theme } from "antd";
import { Space, Table, Tag } from "antd";
import type { TableProps } from "antd";
import axiosClient from "~/utils/axiosClient";
import { useNavigate } from "react-router-dom";
import IDriver from "../../interfaces/driver";
import { ApolloClient, InMemoryCache, ApolloProvider, gql, useMutation, useQuery } from '@apollo/client';

const { Content } = Layout;

const QUERY_ALL = gql`
query {
  serviceApprovals {
      id
      status
      createdDate
      driverLicense
      personalImg
      identityImg
      vehicleImg
      currentAddress
      supply {
          id
          firstName
          lastName
          password
          dob
          gender
          address
          verified
          avatar
          email
      }
      service {
          id
          name
          description
          basePrice
      }
      vehicle {
          id
          name
          identityNumber
          color
          brand
      }
  }
}
`



const ContentComponent: React.FC = () => {
  const { loading, error, data, refetch } = useQuery(QUERY_ALL);

  const navigate = useNavigate();
  const columns: TableProps<IDriver>["columns"] = [
    {
      title: "STT",
      dataIndex: "id",
      key: "id",
    },
    {
      title: "Họ tên",
      dataIndex: "name",
      key: "name",
      render: (_, record) => (
        <Space size="middle">
          <p>{record?.supply?.firstName} {record?.supply?.lastName}</p>
        </Space>
      ),
    },
    {
      title: "Email",
      dataIndex: "email",
      key: "email",
      width: "15%",
      render: (_, record) => (
        <Space size="middle">
          <p>{record?.supply?.email}</p>
        </Space>
      ),
    },
    {
      title: "Địa chỉ",
      dataIndex: "address",
      key: "address",
      width: "23%",
      render: (_, record) => (
        <Space size="middle">
          <p>{record?.supply?.address}</p>
        </Space>
      ),
    },
    {
      title: "Trạng thái",
      dataIndex: "status",
      key: "status",
      render: (_, record) => (
        <Tag color={record.status === "approved" ? 'green' : 'red'} className="!text-sm !p-1.5 !pl-3 !pr-3">
          {record?.status === "approved" ? "Đã duyệt" : "Chờ xử lý"}
        </Tag>
      ),
    },
    {
      title: "Hành động",
      key: "action",
      render: (_, record) => (
        <div className="!flex gap-2">
          {record.status === "approved" ? <Button className="!w-1/3" onClick={() => handleDisapprove(record)}>
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

  const [myData, setData] = useState<IDriver[]>([]);

  useEffect(() => {
    console.log('1');
    console.log(data);
    fetchData();
  }, [loading]);

  const fetchData = async () => {
    try {
      // updateData();
      updateDataByGraph();
    } catch (error) {
      console.error("Error fetching data:", error);
    }
  };

  const updateDataByGraph = async () => {
    try {
      const response: any = await refetch();
      if (response.data) setData(response.data.serviceApprovals);
      console.log('response: ', response);
    } catch (error) {
      console.error("Error updating data:", error);
    }
  };

  const handleVerifyByGraph = async (record: IDriver) => {
    try {
    } catch (error) {
      console.error("Error verifying driver:", error);
    }
  };


  const updateData = async () => {
    try {
      const response = await axiosClient.get("/v1/driver/approval");
      setData(response.data);
    } catch (error) {
      console.error("Error updating data:", error);
    }
  };

  const handleDelete = async (record: IDriver) => {
    try {
      await axiosClient.delete("/v1/driver/approval/" + record?.supply?.id);
      updateData();
    } catch (error) {
      console.error("Error delete driver:", error);
    }
  };

  const handleVerify = async (record: IDriver) => {
    try {
      await axiosClient.post("/v1/driver/approval/approve/" + record?.id);
      updateData();
    } catch (error) {
      console.error("Error verifying driver:", error);
    }
  };

  const handleDisapprove = async (record: IDriver) => {
    try {
      await axiosClient.patch("/v1/driver/approval/disapprove/" + record?.id);
      updateData();
    } catch (error) {
      console.error("Error disapprove driver:", error);
    }
  };


  return data ? (
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
        {
          data ?
            <Table
              columns={columns}
              dataSource={myData}
            /> : <p>loading</p>
        }

      </div>
    </Content>
  ) : <p>loading...</p>;
};

export default ContentComponent;


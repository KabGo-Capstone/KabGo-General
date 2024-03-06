import React, { useEffect, useRef, useState } from "react";
import { Button, Input, Layout, theme } from "antd";
import { Space, Table, Tag, message } from "antd";
import type { InputRef, TableProps } from "antd";
import axiosClient from "~/utils/axiosClient";
import { useNavigate } from "react-router-dom";
import IDriver from "../../interfaces/driver";
import { ApolloClient, InMemoryCache, ApolloProvider, gql, useMutation, useQuery } from '@apollo/client';
import { SearchOutlined } from '@ant-design/icons';
import Highlighter from 'react-highlight-words';
import type { ColumnType, ColumnsType } from 'antd/es/table';
import type { FilterConfirmProps } from 'antd/es/table/interface';
import * as QUERY from "~/graph_queries/queries";

const { Content } = Layout;
const ContentComponent: React.FC = () => {
  // setup GraphQL queries
  const { loading, error, data, refetch } = useQuery(QUERY.SERVICE_APPROVALS);
  const [approveDriver, { data: approve_mutation_data, loading: approve_mutation_loading, error: approve_mutation_error}] = useMutation(QUERY.APPROVE_DRIVER);
  const [disApproveDriver, { data: disApprove_mutation_data, loading: disApprove_mutation_loading, error: disApprove_mutation_error}] = useMutation(QUERY.DISAPPROVE_DRIVER);
  const [deleteServiceApproval, {data: delete_mutation_data, loading: delete_mutation_loading, error: delete_mutation_error}] = useMutation(QUERY.DELETE_SERVICE_APPROVAL);
 
  const [dataSource, setDataSource] = useState<IDriver[]>([]);
  const navigate = useNavigate();

  const [searchText, setSearchText] = useState<string>('');
  const [searchedColumn, setSearchedColumn] = useState<string>('');
  const searchInput = useRef<InputRef>(null);
  const [isTableLoading, setIsTableLoading] = useState<boolean>(true);
 
  // search item in column
  const handleSearch = (
    selectedKeys: string[],
    confirm: (param?: FilterConfirmProps) => void,
    dataIndex: any,
  ) => {
    confirm();
    setSearchText(selectedKeys[0]);
    setSearchedColumn(dataIndex);
  };

  // reset search text
  const handleReset = (clearFilters: () => void) => {
    clearFilters();
    setSearchText('');
  };

  // handle searching for columns
  const getColumnSearchProps = (dataIndex: any): ColumnType<any> => ({
    filterDropdown: ({ setSelectedKeys, selectedKeys, confirm, clearFilters, close }) => (
      <div style={{ padding: 8 }} onKeyDown={(e) => e.stopPropagation()}>
        <Input
          ref={searchInput}
          placeholder={`Search ${dataIndex}`}
          value={selectedKeys[0]}
          onChange={(e) => setSelectedKeys(e.target.value ? [e.target.value] : [])}
          onPressEnter={() => handleSearch(selectedKeys as string[], confirm, dataIndex)}
          style={{ marginBottom: 8, display: 'block' }}
        />
        <Space>
          <Button
            className = "!flex !justify-center !items-center !gap-0"
            type="primary"
            onClick={() => handleSearch(selectedKeys as string[], confirm, dataIndex)}
            icon={<SearchOutlined />}
            style={{ width: 90 }}
            size = "middle"
          >
            Search
          </Button>
          <Button
            className= "!flex !justify-center !items-center"
            onClick={() => clearFilters && handleReset(clearFilters)}
            size="small"
            style={{ width: 90}}
          >
            Reset
          </Button>
          <Button
            type="link"
            size="small"
            onClick={() => {
              confirm({ closeDropdown: false });
              setSearchText((selectedKeys as string[])[0]);
              setSearchedColumn(dataIndex);
            }}
          >
            Filter
          </Button>
          <Button
            type="link"
            size="small"
            onClick={() => {
              close();
            }}
          >
           Close
          </Button>
        </Space>
      </div>
    ),
    filterIcon: (filtered: boolean) => (
      <SearchOutlined className = {filtered ? "!text-primary" : ''}/>
    ),
    onFilter: (value, record) => {
      if (dataIndex === 'name') {
        return record.supply['firstName']
        .toString()
        .toLowerCase()
        .includes((value as string).toLowerCase()) 
        || record.supply['lastName']
        .toString()
        .toLowerCase()
        .includes((value as string).toLowerCase())
      }
      if (record[dataIndex]) {
        return record[dataIndex].toString().toLowerCase().includes((value as string).toLowerCase());
      }
      if (record.supply[dataIndex]) {
       return record.supply[dataIndex]
        .toString()
        .toLowerCase()
        .includes((value as string).toLowerCase()) 
      } 
      return false;
    },
    onFilterDropdownOpenChange: (visible) => {
      if (visible) {
        setTimeout(() => searchInput.current?.select(), 100);
      }
    },
    render: (text, record) => {
      if (dataIndex === 'name') {
        return searchedColumn === dataIndex ? <Highlighter
        highlightStyle={{ backgroundColor: '#ffc069', padding: 0 }}
        searchWords={[searchText]}
        autoEscape
        textToHighlight={`${record['supply']['firstName'] ?? ''} ${record['supply']['lastName'] ?? ''}`}
        /> : `${record['supply']['firstName']} ${record['supply']['lastName']}`
      }
      return searchedColumn === dataIndex ?
      <Highlighter
      highlightStyle={{ backgroundColor: '#ffc069', padding: 0 }}
      searchWords={[searchText]}
      autoEscape
      textToHighlight={record['supply'][dataIndex] ? record['supply'][dataIndex].toString() : ''}
    /> : record['supply'][dataIndex]
    }
  });


  const columns: TableProps<IDriver>["columns"] = [
    {
      title: "Họ tên",
      dataIndex: "name",
      key: "name",
      ...getColumnSearchProps('name'),
    },
    {
      title: "Email",
      dataIndex: "email",
      key: "email",
      ...getColumnSearchProps('email'),
      width: "15%",
    },
    {
      title: "Địa chỉ",
      dataIndex: "address",
      key: "address",
      ...getColumnSearchProps('address'),
      width: "28%",
    },
    {
      title: "Trạng thái",
      dataIndex: "status",
      key: "status",
      filters: [
        { text: 'Đã duyệt', value: 'approved' },
        { text: 'Chờ xử lý', value: 'pending' },
      ],
      onFilter: (value: any, record) => {
        return record.status === value;
      },
      render: (_, record) => (
        <Tag color={record.status === "approved" ? 'green' : 'blue'} className="!text-sm !p-1.5 !pl-3 !pr-3">
          {record?.status === "approved" ? "Đã duyệt" : "Chờ xử lý"}
        </Tag>
      ),
    },
    {
      title: "Hành động",
      key: "action",
      render: (_, record) => (
        <div className="!flex gap-2">
          {record.status === "approved" ? <Button style={{ width: '80px'}} onClick={() => handleDisapprove(record)}>
            Hủy
          </Button> :
            <Button style={{ width: '80px'}} className="!bg-green-600 !border-transparent !text-white !hover:bg-green-700" onClick={() => handleVerify(record)}>
              Duyệt
            </Button >}

          <Button style={{ width: '80px'}} className="!bg-red-500 !text-white !border-transparent" onClick={() => handleDelete(record)}>
            Xóa
          </Button>

          {/* {record.status === "approved" ? <Button style={{ width: '80px'}} onClick={() => handleDisapproveByGraph(record)}>
            Hủy
          </Button> :
            <Button style={{ width: '80px'}} className="!bg-green-600 !border-transparent !text-white !hover:bg-green-700" onClick={() => handleVerifyByGraph(record)}>
              Duyệt
            </Button >}

          <Button style={{ width: '80px'}} className="!bg-red-500 !text-white !border-transparent" onClick={() => handleDeleteByGraph(record)}>
            Xóa
          </Button> */}
       

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


  useEffect(() => {
    fetchData();
  }, []);

  const fetchData = async () => {
    try {
      updateData();
      // updateDataByGraph();
    } catch (error) {
      console.error("Error fetching data:", error);
    }
  };

  const updateDataByGraph = async () => {
    try {
      const response: any = await refetch();
      if (!error && response.data) {
        setTimeout(() => {
          setIsTableLoading(false);
          message.success({
            content: 'Dữ liệu được tải hoàn tất!',
            style: {
              fontFamily: 'Montserrat',
              fontSize: 16,
            }
          }, 1.2);
        setDataSource(response.data.serviceApprovals);
        }, 1000);
      }
    } catch (error) {
      console.error("Error updating data:", error);
    }
  };

  const handleVerifyByGraph = async (record: IDriver) => {
    try {
        setIsTableLoading(true);
        await approveDriver({variables: {
            service_approval_id: record.id,
          }
        });
        await updateDataByGraph();
    } catch (error) {
      console.error("Error verifying driver:", error);
    }
  };

  const handleDisapproveByGraph = async (record: IDriver) => {
    try {
      setIsTableLoading(true);
      await disApproveDriver({variables: {
        service_approval_id: record.id,
        }
      });
      await updateDataByGraph();
    } catch (error) {
      console.error("Error disapprove driver:", error);
    }
  };

  const handleDeleteByGraph = async (record: IDriver) => {
    try {
      setIsTableLoading(true);
      await deleteServiceApproval({variables: {
        service_approval_id: record.id,
        }
      });
      await updateDataByGraph();
    } catch (error) {
      console.error("Error delete driver:", error);
    }
  };

  // RESTFUL API
  const updateData = async () => {
    try {
      const response = await axiosClient.get("/v1/driver/approval");
      if (response.data) {
        setTimeout(() => {
          setIsTableLoading(false);
          message.success({
            content: 'Dữ liệu được tải hoàn tất!',
            style: {
              fontFamily: 'Montserrat',
              fontSize: 16,
            }
          }, 1.2);
            setDataSource(response.data);
        }, 1000);
      }
    } catch (error) {
      console.error("Error updating data:", error);
    }
  };

  const handleDelete = async (record: IDriver) => {
    try {
      setIsTableLoading(true);
      await axiosClient.delete("/v1/driver/approval/" + record?.supply?.id);
      updateData();
    } catch (error) {
      console.error("Error delete driver:", error);
    }
  };

  const handleVerify = async (record: IDriver) => {
    try {
      setIsTableLoading(true);
      await axiosClient.post("/v1/driver/approval/approve/" + record?.id);
      updateData();
    } catch (error) {
      console.error("Error verifying driver:", error);
    }
  };

  const handleDisapprove = async (record: IDriver) => {
    try {
      setIsTableLoading(true);
      await axiosClient.patch("/v1/driver/approval/disapprove/" + record?.id);
      updateData();
    } catch (error) {
      console.error("Error disapprove driver:", error);
    }
  };


  return <Content style={{ overflow: "initial" }} className="!mt-4 !mb-0 !mx-3.5 !p-0">
      <div
        style={{
          padding: 24,
          textAlign: "center",
          background: colorBgContainer,
          borderRadius: borderRadiusLG,
        }}>
          <Table
            columns={columns}
            dataSource={dataSource}
            loading = {isTableLoading}
            pagination={{
              total: dataSource.length,
              pageSize: 6,
              showSizeChanger: false, // Turn off feature to change page size
              showTotal: (total, range) => `${range[0]}-${range[1]} of ${total} items`,
            }}
          /> 
      </div>
    </Content>
  
};

export default ContentComponent;


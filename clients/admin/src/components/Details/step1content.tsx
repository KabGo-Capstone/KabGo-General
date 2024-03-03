import React, { useEffect, useState } from "react";
import { Button, Cascader, Checkbox, Col, DatePicker, Form, Input, Radio, Row, Select, Space, Table, Tag, TreeSelect, Typography, theme } from "antd";
import { Content } from "antd/es/layout/layout";
import { ReactComponent as UploadImg } from "../../assets/svg/Sidebar/upload_img.svg";
import IDriver from "../../interfaces/driver";

const Step1Content: React.FC<any> = ( {record} ) => {
    const [componentDisabled, setComponentDisabled] = useState<boolean>(false);
    const {
        token: { colorBgContainer, borderRadiusLG },
    } = theme.useToken();

    useEffect(() => {
        if (record) {
            //   const firstName = record.firstName;
              console.log("Record: ", record);
        }
    }, [record]);

    return (
        <Content
            style={{ overflow: "initial" }}
            className="!mt-4 !mb-0 !mx-3.5 !p-0"
        >
            <div
                style={{
                    padding: 24,
                    background: colorBgContainer,
                    borderRadius: borderRadiusLG,
                }}
            >
                <div className="!flex">
                    <div className="!w-3/5">
                        <Typography.Text className="!font-bold !text-2xl">Thông tin cá nhân</Typography.Text>
                        <br /><br />
                        <Form
                            labelCol={{ span: 4 }}
                            wrapperCol={{ span: 14 }}
                            layout="horizontal"
                            disabled={componentDisabled}
                        >
                            <Form.Item label="Họ">
                                <Input value={record?.supply.lastName} readOnly={true} />
                            </Form.Item>
                            <Form.Item label="Tên">
                                <Input value={record?.supply.firstName} readOnly={true}/>
                            </Form.Item>
                            <Form.Item label="Giới tính">
                                <Input value={record?.supply.gender === "male" ? "Nam" : "Nữ"} readOnly={true}/>
                            </Form.Item>
                            <Form.Item label="Ngày sinh">
                                <Input value={record?.supply.dob} readOnly={true}/>
                            </Form.Item>
                            <Form.Item label="Email">
                                <Input value={record?.supply.email} readOnly={true}/>
                            </Form.Item>
                            <Form.Item label="Địa chỉ nhà">
                                <Input value={record?.supply.address} readOnly={true}/>
                            </Form.Item>
                            <Form.Item label="Dịch vụ đăng ký">
                                <Input value={record?.service.name} readOnly={true}/>
                            </Form.Item>
                            {/* <Form.Item label="TK Ngân hàng">
                                <Input />
                            </Form.Item> */}
                        </Form>
                    </div>
                    <div className="!flex !flex-col gap-8 !w-2/5">
                        <Typography.Text className="!font-bold !text-2xl !flex !justify-center">Ảnh đại diện</Typography.Text>
                        <div className="!flex !justify-center">
                            <UploadImg />
                        </div>
                    </div>
                </div>
            </div>
        </Content >
    );
};

export default Step1Content;
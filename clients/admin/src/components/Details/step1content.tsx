import React, { useEffect, useState } from "react";
import { Form, Input, Typography, theme } from "antd";
import NoImg from '../../assets/images/no_img.jpg';

const Step1Content: React.FC<any> = ({ record }) => {
    const [componentDisabled, setComponentDisabled] = useState<boolean>(false);
    const {
        token: { colorBgContainer, borderRadiusLG },
    } = theme.useToken();

    useEffect(() => {
        if (record) {
            console.log("Record step1: ", record);
        }
    }, [record]);

    return (
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
                            <Input value={record?.supply.firstName} readOnly={true} />
                        </Form.Item>
                        <Form.Item label="Giới tính">
                            <Input value={record?.supply.gender === "male" ? "Nam" : "Nữ"} readOnly={true} />
                        </Form.Item>
                        <Form.Item label="Ngày sinh">
                            <Input value={record?.supply.dob} readOnly={true} />
                        </Form.Item>
                        <Form.Item label="Email">
                            <Input value={record?.supply.email} readOnly={true} />
                        </Form.Item>
                        <Form.Item label="Địa chỉ nhà">
                            <Input value={record?.currentAddress} readOnly={true} />
                        </Form.Item>
                        <Form.Item label="Dịch vụ đăng ký">
                            <Input value={record?.service.name} readOnly={true} />
                        </Form.Item>
                        {/* <Form.Item label="TK Ngân hàng">
                                <Input />
                            </Form.Item> */}
                    </Form>
                </div>
                <div className="!flex !flex-col gap-8 !w-2/5">
                    <Typography.Text className="!font-bold !text-2xl !flex !justify-center">Ảnh đại diện</Typography.Text>
                    <div className="!flex !justify-center">
                        {record && record.personalImg ?
                            <img src={record.personalImg} alt="Personal" className="!w-1/2" /> :
                            <img src={NoImg} alt="Alternative" className="rounded-full !w-60 !h-60" />
                        }
                    </div>
                </div>
            </div>
        </div>
    );
};

export default Step1Content;
import React, { useState } from "react";
import { Button, Cascader, Checkbox, Col, DatePicker, Form, Input, Radio, Row, Select, Space, Table, Tag, TreeSelect, Typography, theme } from "antd";
import { Content } from "antd/es/layout/layout";
import { ReactComponent as UploadImg } from "../../assets/svg/Sidebar/upload_img.svg";

const Step1Content = () => {
    const [componentDisabled, setComponentDisabled] = useState<boolean>(true);
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
                    background: colorBgContainer,
                    borderRadius: borderRadiusLG,
                }}
            >
                <div className="!flex">
                    <div className="!w-3/5">
                        <Typography.Text className="!font-bold !text-xl">Thông tin cá nhân</Typography.Text>
                        <br />
                        <Checkbox
                            checked={componentDisabled}
                            onChange={(e) => setComponentDisabled(e.target.checked)}
                        >
                            Form disabled
                        </Checkbox>
                        <Form
                            labelCol={{ span: 4 }}
                            wrapperCol={{ span: 14 }}
                            layout="horizontal"
                            disabled={componentDisabled}
                        >
                            <Form.Item label="Giới tính">
                                <Radio.Group>
                                    <Radio value="male"> Nam </Radio>
                                    <Radio value="female"> Nữ </Radio>
                                </Radio.Group>
                            </Form.Item>

                            <Row>
                                <Col span={10}>
                                    <Form.Item
                                        label="Họ"
                                    >
                                        <Input />
                                    </Form.Item>
                                </Col>
                                <Col span={12}>
                                    <Form.Item
                                        label="Tên"
                                    >
                                        <Input />
                                    </Form.Item>
                                </Col>
                            </Row>

                            <Row>
                                <Col span={10}>
                                    <Form.Item label="Tuổi">
                                        <Input />
                                    </Form.Item>
                                </Col>
                                <Col span={12}>
                                    <Form.Item label="Email">
                                        <Input />
                                    </Form.Item>
                                </Col>
                            </Row>

                            <Form.Item label="Địa chỉ nhà">
                                <Input />
                            </Form.Item>
                            <Form.Item label="Dịch vụ đăng ký">
                                <Input />
                            </Form.Item>
                            <Form.Item label="TK Ngân hàng">
                                <Input />
                            </Form.Item>
                            <Typography.Text className="!font-bold !text-xl">Tạo mật khẩu</Typography.Text>
                            <Form.Item label="Mật khẩu">
                                <Input />
                            </Form.Item>
                            <Form.Item label="Xác nhận">
                                <Input />
                            </Form.Item>
                            <Form.Item label="">
                                <Radio.Group className="">
                                    <Radio value="send_pw_email">Gửi mật khẩu qua email</Radio>
                                    <Radio value="send_pw_sms">Gửi mật khẩu qua tin nhắn sms</Radio>
                                </Radio.Group>
                            </Form.Item>
                        </Form>
                    </div>
                    <div className="!flex !flex-col gap-8 !w-2/5">
                        <Typography.Text className="!font-bold !text-xl">Ảnh đại diện</Typography.Text>
                        <div className="!flex !justify-center">
                            <UploadImg />
                        </div>
                        {/* <div className="!flex !justify-center">
                            <Button>Chọn ảnh</Button>
                        </div> */}
                    </div>
                </div>
            </div>
        </Content >
    );
};

export default Step1Content;
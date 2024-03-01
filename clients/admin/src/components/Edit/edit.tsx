import React, { useState } from "react";

import { Cascader, Checkbox, DatePicker, Form, Input, Radio, Select, Space, Table, Tag, TreeSelect } from "antd";
import type { TableProps } from "antd";
import { Layout, Menu, theme, Button, Typography, Divider } from "antd";

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

const Edit: React.FC = () => {
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
          // textAlign: "center",
          background: colorBgContainer,
          borderRadius: borderRadiusLG,
        }}
      >
        <div className="!flex">
          <div>
            <Typography.Text className="!font-bold !text-xl">Thông tin cá nhân</Typography.Text>
            <br/>
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
              style={{ maxWidth: 800 }}
            >
              <Form.Item label="Giới tính">
                <Radio.Group>
                  <Radio value="apple"> Nam </Radio>
                  <Radio value="pear"> Nữ </Radio>
                </Radio.Group>
              </Form.Item>
              <Form.Item label="Họ">
                <Input />
              </Form.Item>
              <Form.Item label="Tên">
                <Input />
              </Form.Item>
              <Form.Item label="Email">
                <Input />
              </Form.Item>
              <Form.Item label="Địa chỉ nhà">
                <Input />
              </Form.Item>
              <Typography.Text className="!font-bold !text-xl">Tạo mật khẩu</Typography.Text>
              <Form.Item label="Mật khẩu">
                <Input />
              </Form.Item>
              <Form.Item label="Xác nhận mật khẩu">
                <Input />
              </Form.Item>
              <Form.Item label="">
                <Radio.Group className="!w-200">
                  <Radio value="send_pw_email"> Gửi mật khẩu qua email </Radio>
                  <Radio value="send_pw_sms"> Gửi mật khẩu qua tin nhắn sms </Radio>
                </Radio.Group>
              </Form.Item>
            </Form>
          </div>
          <div>
            <Typography.Text className="!font-bold !text-xl">Ảnh đại diện</Typography.Text>
          </div>
        </div>
      </div>
    </Content>
  );
};

export default Edit;


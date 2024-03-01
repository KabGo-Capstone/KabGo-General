import React, { useState } from "react";

import { Cascader, Checkbox, DatePicker, Form, Input, Radio, Select, Space, Table, Tag, TreeSelect } from "antd";
import type { TableProps } from "antd";
import { Layout, Menu, theme, Button, Typography, Steps } from "antd";
import {
  UserOutlined
} from "@ant-design/icons";
import { ReactComponent as UploadImg } from "../../assets/svg/Sidebar/upload_img.svg";

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

const { Step } = Steps;

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
          // textAlign: "center",
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
              // style={{ maxWidth: 600 }}
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
              <Form.Item label="Độ tuổi">
                <Input />
              </Form.Item>
              <Form.Item label="Email">
                <Input />
              </Form.Item>
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
            <div className="!flex !justify-center">
              <Button>Chọn ảnh</Button>
            </div>
          </div>
        </div>
      </div>
    </Content>
  );
};

const Step2Content = () => {
  return (
    <div>
      {/* Your Step 2 content here */}
      <Typography.Text>Step 2 Content</Typography.Text>
    </div>
  );
};

const Edit: React.FC = () => {
  // const [componentDisabled, setComponentDisabled] = useState<boolean>(true);
  // const {
  //   token: { colorBgContainer, borderRadiusLG },
  // } = theme.useToken();

  const [currentStep, setCurrentStep] = useState(0);
  const steps = [
    {
      title: 'Step 1',
      content: <Step1Content />,
    },
    {
      title: 'Step 2',
      content: <Step2Content />,
    },
    // Add more steps as needed
  ];

  const nextStep = () => {
    setCurrentStep(currentStep + 1);
  };

  const prevStep = () => {
    setCurrentStep(currentStep - 1);
  };

  return (
    <Layout.Content className="!mt-4 !mb-0 !mx-3.5 !p-0 relative">
    <Steps current={currentStep}>
      {/* ... (previous code) */}
    </Steps>
    <div className="steps-content">{steps[currentStep].content}</div>
    <div className="absolute bottom-4 right-4">
      <div className="flex space-x-4">
        {currentStep > 0 && (
          <Button onClick={prevStep} className="bg-gray-300 text-gray-700">
            Previous
          </Button>
        )}
        {currentStep < steps.length - 1 && (
          <Button type="primary" onClick={nextStep}>
            Next
          </Button>
        )}
        {currentStep === steps.length - 1 && (
          <Button type="primary" onClick={() => console.log('Process completed!')}>
            Done
          </Button>
        )}
      </div>
    </div>
  </Layout.Content>
  );
};

export default Edit;


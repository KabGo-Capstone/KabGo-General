import React, { useEffect, useState } from "react";
import { Layout, Menu, theme, Button, Typography, Steps } from "antd"
import Step1Content from "./step1content";
import Step2Content from "./step2content";
import Step3Content from "./step3content";
import Step4Content from "./step4content";
import { useLocation, useNavigate } from "react-router-dom";
import IDriver from "~/interfaces/driver";
import { RightCircleOutlined, LeftCircleOutlined, CheckCircleOutlined } from "@ant-design/icons";

const Details: React.FC = () => {
  const location = useLocation();
  const navigate = useNavigate();
  const [currentStep, setCurrentStep] = useState(0);

  const [record, setRecord] = useState<IDriver | null>(null);

  useEffect(() => {
    if (location.state && location.state.record) {
      setRecord(location.state.record);
    } else {
      navigate("/");
    }
  }, [location.state, navigate]);

  const steps = [
    {
      title: 'Step 1',
      content: <Step1Content record={record} />,
    },
    {
      title: 'Step 2',
      content: <Step2Content />,
    },
    {
      title: 'Step 3',
      content: <Step3Content />,
    },
    {
      title: 'Step 4',
      content: <Step4Content />,
    },
  ];

  const nextStep = () => {
    setCurrentStep(currentStep + 1);
  };

  const prevStep = () => {
    setCurrentStep(currentStep - 1);
  };

  const buttonStyles = `
  !text-4xl !border-none !bg-transparent !p-0 
  hover:text-green-500 focus:text-green-500 active:text-green-500
`;

  return (
    <Layout.Content className="!mt-4 !mb-0 !mx-3.5 !p-0 relative">
      <div className="relative">
        <div className="steps-content">{steps[currentStep].content}</div>
        <div className="!fixed !right-5 !top-1/2 !h-auto flex !gap-2">
          {currentStep > 0 && (
            <Button onClick={prevStep} className="!text-4xl !border-none !bg-transparent !p-0">
              <LeftCircleOutlined />
            </Button>
          )}
          {currentStep < steps.length - 1 && (
            <Button className="!text-4xl !border-none !bg-transparent !p-0" onClick={nextStep}>
              <RightCircleOutlined />
            </Button>
          )}
          {currentStep === steps.length - 1 && (
            <Button
              style={{ width: "20px" }}
              className="!text-4xl !border-none !bg-transparent !p-0" onClick={() => navigate(-1)}>
              <CheckCircleOutlined />
            </Button>
          )}
        </div>
      </div>
    </Layout.Content>
  );
};

export default Details;


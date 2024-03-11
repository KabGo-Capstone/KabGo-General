import React, { useEffect, useState } from "react";
import { Layout, Menu, theme, Button, Typography, Steps } from "antd"
import Step1Content from "./step1content";
import Step2Content from "./step2content";
import Step3Content from "./step3content";
import Step4Content from "./step4content";
import { useLocation, useNavigate } from "react-router-dom";
import IDriver from "~/interfaces/driver";
import { RightCircleOutlined, LeftCircleOutlined, CloseCircleOutlined } from "@ant-design/icons";

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
      content: <Step3Content record={record} />,
    },
    {
      title: 'Step 4',
      content: <Step4Content record={record} />,
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
        <div className="relative steps-content !w-2/2">
          {steps[currentStep].content}
          <Button onClick={() => navigate(-1)} 
            className="!absolute !right-3 !top-0 !text-2xl !border-none !bg-transparent !p-0 !ml-4 !text-red-400 hover:!text-red-600">
            <CloseCircleOutlined />
          </Button>
        </div>
        {currentStep > 0 && (
          <Button onClick={prevStep} className="!fixed !left-2/5 !top-1/2 !text-4xl !border-none !bg-transparent !p-0 !ml-4">
            <LeftCircleOutlined />
          </Button>
        )}
        {currentStep < steps.length - 1 && (
          <Button className="!fixed !right-5 !top-1/2 !text-4xl !border-none !bg-transparent !p-0 !mr-5" onClick={nextStep}>
            <RightCircleOutlined />
          </Button>
        )}
        
        {/* {currentStep === steps.length - 1 && (
          <Button
            style={{ width: "20px" }}
            className="!fixed !right-5 !top-1/2  !text-4xl !border-none !bg-transparent !p-0 hover:!text-green-500 !mr-5" onClick={() => navigate(-1)}>
            <CheckCircleOutlined />
          </Button>
        )} */}
      </div>
    </Layout.Content>
  );
};

export default Details;


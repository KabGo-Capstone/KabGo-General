import React, { useEffect, useState } from "react";
import { Layout, Menu, theme, Button, Typography, Steps } from "antd"
import Step1Content from "./step1content";
import Step2Content from "./step2content";
import Step3Content from "./step3content";
import Step4Content from "./step4content";
import { useLocation, useNavigate } from "react-router-dom";


const Details: React.FC = () => {
  const location = useLocation();
  const navigate = useNavigate();
  const [currentStep, setCurrentStep] = useState(0);

  const [record, setRecord] = useState<any | null>(null);

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

  return (
    <Layout.Content className="!mt-4 !mb-0 !mx-3.5 !p-0 relative">
      <Steps current={currentStep}>
        {/* ... (previous code) */}
      </Steps>
      <div className="steps-content">{steps[currentStep].content}</div>
      <div className="fixed bottom-4 right-4 flex space-x-4">
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
          <Button type="primary" onClick={() => {
            navigate(-1);
          }}>
            Done
          </Button>
        )}
      </div>
    </Layout.Content>
  );
};

export default Details;


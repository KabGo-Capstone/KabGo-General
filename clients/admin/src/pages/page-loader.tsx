import React from "react";
import { Flex, Spin } from "antd";

export const PageLoader: React.FC = () => {
  return (
    <Flex justify="center" align="center" className="!w-full !h-screen">
      <Spin size="large" />
    </Flex>
  );
};

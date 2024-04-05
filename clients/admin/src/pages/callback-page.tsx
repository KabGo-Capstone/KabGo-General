import React from "react";
import { Layout, theme } from "antd";
import { Spin } from "antd";
import { Flex } from "antd";

export const CallbackPage: React.FC = () => {
  return (
    <Flex
      justify="center"
      align="center"
      className="!w-full !h-screen"
    >
      <Spin size="large" />
    </Flex>
  );
};

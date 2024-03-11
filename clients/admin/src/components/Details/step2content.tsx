import React, { useEffect, useState } from "react";
import { Typography, Image, theme } from "antd";

const Step2Content: React.FC<any> = ({ record }) => {
  const {
    token: { colorBgContainer, borderRadiusLG },
  } = theme.useToken();

  return (
    <div className="flex justify-between space-x-4" style={{ padding: 24, background: colorBgContainer, borderRadius: borderRadiusLG }}>
      <div className="flex-1 space-y-4">
        {renderCard("CCCD/CMND/Hộ chiếu", "Mặt trước:", record?.identityImgFrontsight)}
        {renderCard("CCCD/CMND/Hộ chiếu", "Mặt sau:", record?.identityImgBacksight)}
      </div>

      {/* Vertical Line */}
      <div className="!border-l !border-gray-300 !h-full"></div>

      <div className="flex-1 flex flex-col items-center">
        {renderCard("Giấy đăng ký xe", "Mặt trước:", record?.vehicleRegistrationFrontsight)}
        {renderCard("Giấy đăng ký xe", "Mặt sau:", record?.vehicleRegistrationBacksight)}
      </div>
    </div>
  );
};

const renderCard = (title: string, subTitle: string, imageSource:any) => (
  <div className="flex flex-col items-center !m-5 !h-35">
    <Typography.Text className="!text-2xl font-bold !mb-2">{title}</Typography.Text>
    <Typography.Text className="!text-lg !mb-2">{subTitle}</Typography.Text>
    <Image
        width={300}
        src={imageSource}
        placeholder={
          <Image
            preview={false}
            src={imageSource    }
            width={200}
          />
        }
      />
  </div>
);

export default Step2Content;

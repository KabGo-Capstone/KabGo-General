import React, { useState } from "react";
import { Typography, Image, theme } from "antd";
import Motocycle from "../../assets/images/motocycle.png";

const Step3Content = () => {
  const [componentDisabled, setComponentDisabled] = useState<boolean>(true);

  const {
    token: { colorBgContainer, borderRadiusLG },
  } = theme.useToken();

  return (
    <div className="" style={{ padding: 24, background: colorBgContainer, borderRadius: borderRadiusLG }}>
      <Typography.Text className="!text-2xl font-bold !mb-2">Hình ảnh xe đăng ký</Typography.Text>    
      <div className="flex justify-between space-x-4 !pl-3" style={{ padding: 24, background: colorBgContainer, borderRadius: borderRadiusLG }}>
      <div className="flex-1 space-y-4">
        {renderCard("Đằng trước:", Motocycle)}
        {renderCard("Đằng sau:", Motocycle)}
      </div>

      {/* Second Column for Vehicle Image */}
      <div className="flex-1 flex flex-col items-center">
        {renderCard("Bên phải:", Motocycle)}
        {renderCard("Bên trái:", Motocycle)}
      </div>
    </div>
    </div>
  );
};

const renderCard = (title: string, imageSource:any) => (
  <div className="flex flex-col items-center">
    <Typography.Text className="!text-lg !mb-2">{title}</Typography.Text>
    {/* <img src={imageSource} alt={title} className="w-3/5 h-auto" /> */}
    <Image
        width={300}
        src={imageSource}
        placeholder={
          <Image
            preview={false}
            src={imageSource}
            width={200}
          />
        }
      />
  </div>
);

export default Step3Content;

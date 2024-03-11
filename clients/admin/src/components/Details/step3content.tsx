import React, { useState } from "react";
import { Typography, Image, theme } from "antd";
import CCCD2 from '../../assets/images/motocycle.png';
import NoImg from '../../assets/images/no_img.jpg';

const Step3Content: React.FC<any> = ({ record }) => {
  const {
    token: { colorBgContainer, borderRadiusLG },
  } = theme.useToken();

  return (
    // <div className="" style={{ padding: 24, background: colorBgContainer, borderRadius: borderRadiusLG }}>
    //   <Typography.Text className="!text-2xl font-bold !mb-2">Hình ảnh xe đăng ký</Typography.Text>    
    //   <div className="flex justify-between space-x-4 !pl-3" style={{ padding: 24, background: colorBgContainer, borderRadius: borderRadiusLG }}>
    //   <div className="flex-1 space-y-4">
    //     {renderCard("Đằng trước:", record?.vehicleImgFrontsight)}
    //     {renderCard("Đằng sau:", record?.vehicleImgBacksight)}
    //   </div>

    //   {/* Second Column for Vehicle Image */}
    //   <div className="flex-1 flex flex-col items-center">
    //     {renderCard("Bên phải:", record?.vehicleImgRightsight)}
    //     {renderCard("Bên trái:", record?.vehicleImgLeftsight)}
    //   </div>
    // </div>
    // </div>
    <div className="" style={{ padding: 24, background: colorBgContainer, borderRadius: borderRadiusLG }}>
      <Typography.Text className="!text-2xl font-bold !mb-2">Hình ảnh xe đăng ký</Typography.Text>
      <div
        className="grid grid-cols-2 gap-4"
        style={{ padding: 24, background: colorBgContainer, borderRadius: borderRadiusLG }}
      >
        {renderCard("Đằng trước", record?.vehicleImgFrontsight)}
        {renderCard("Đằng sau", record?.vehicleImgBacksight)}
        {renderCard("Bên phải", record?.vehicleImgRightsight)}
        {renderCard("Bên trái", record?.vehicleImgLeftsight)}
      </div>
    </div>
  );
};

const renderCard = (title: string, imageSource: any) => (
  <div className="flex flex-col items-center">
    <Typography.Text className="!text-lg !mb-2">{title}</Typography.Text>
    {/* <img src={imageSource} alt={title} className="w-3/5 h-auto" /> */}
    <div>
      <Image
        // height={200}
        width={200}
        src={imageSource || NoImg}
        placeholder={
          <Image
            preview={false}
            src={imageSource || NoImg}
          />
        }
      />
    </div>
  </div>
);

export default Step3Content;

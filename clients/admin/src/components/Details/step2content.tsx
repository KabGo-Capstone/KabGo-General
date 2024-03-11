import React, { useEffect, useState } from "react";
import { Typography, Image, theme } from "antd";
import NoImg from '../../assets/images/no_img.jpg';
import GiayPhepLaiXe from '../../assets/images/giay_phep_lai_xe.jpg';
import CCCD from '../../assets/images/identity card.jpg';
import CCCD2 from '../../assets/images/motocycle.png';

const Step2Content: React.FC<any> = ({ record }) => {
  const {
    token: { colorBgContainer, borderRadiusLG },
  } = theme.useToken();

  return (
    // <div className="flex justify-between space-x-4" style={{ padding: 24, background: colorBgContainer, borderRadius: borderRadiusLG }}>
    //   <div className="flex-1 space-y-4">
    //     {renderCard("CCCD/CMND/Hộ chiếu", "Mặt trước:", CCCD)}
    //     {renderCard("CCCD/CMND/Hộ chiếu", "Mặt sau:", CCCD2)}
    //   </div>

    //   {/* Vertical Line */}
    //   {/* <div className="!border-l !border-gray-300 !h-full"></div> */}

    //   <div className="flex-1 flex flex-col items-center">
    //     {renderCard("Giấy đăng ký xe", "Mặt trước:", GiayPhepLaiXe)}
    //     {renderCard("Giấy đăng ký xe", "Mặt sau:", NoImg)}
    //   </div>
    // </div>
    <div
      className="grid grid-cols-2 gap-4"
      style={{ padding: 24, background: colorBgContainer, borderRadius: borderRadiusLG }}
    >
      {renderCard("CCCD/CMND/Hộ chiếu", "Mặt trước:", record?.identityImgFrontsight)}
      {renderCard("CCCD/CMND/Hộ chiếu", "Mặt sau:", record?.identityImgBacksight)}
      {renderCard("Giấy đăng ký xe", "Mặt trước:", record?.vehicleRegistrationFrontsight)}
      {renderCard("Giấy đăng ký xe", "Mặt sau:", record?.vehicleRegistrationBacksight)}
    </div>

  );
};

const renderCard = (title: string, subTitle: string, imageSource: any) => (
  <div className="flex grow flex-col items-center !m-5 !h-35">
    <Typography.Text className="!text-2xl font-bold !mb-2">{title}</Typography.Text>
    <Typography.Text className="!text-lg !mb-2">{subTitle}</Typography.Text>
    <Image
      width={300}
      src={imageSource || NoImg}
      // className="!bg-cover"
      placeholder={
        <Image
          preview={false}
          src={imageSource || NoImg}
        // width={500}
        />
      }
    />
  </div>
);

export default Step2Content;

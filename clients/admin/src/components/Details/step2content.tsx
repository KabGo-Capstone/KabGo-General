import React, { useState } from "react";
import { Typography, Image, theme } from "antd";
import IdentityCard from "../../assets/images/identity card.jpg";
import IdentityCard2 from "../../assets/images/identity card 2.jpg";
import GiayDKXe from "../../assets/images/giay_dk_xe.jpg";

const Step2Content = () => {
  const [componentDisabled, setComponentDisabled] = useState<boolean>(true);

  const {
    token: { colorBgContainer, borderRadiusLG },
  } = theme.useToken();

  return (
    <div className="flex justify-between space-x-4" style={{ padding: 24, background: colorBgContainer, borderRadius: borderRadiusLG }}>
      <div className="flex-1 space-y-4">
        {renderCard("CCCD/CMND/Hộ chiếu", "Mặt trước:", IdentityCard)}
        {renderCard("CCCD/CMND/Hộ chiếu", "Mặt sau:", IdentityCard2)}
      </div>

      {/* Vertical Line */}
      <div className="!border-l !border-gray-300 !h-full"></div>

      <div className="flex-1 flex flex-col items-center">
        {renderCard("Giấy đăng ký xe", "Mặt trước:", GiayDKXe)}
        {renderCard("Giấy đăng ký xe", "Mặt sau:", GiayDKXe)}
      </div>
    </div>
  );
};

const renderCard = (title: string, subTitle: string, imageSource:any) => (
  <div className="flex flex-col items-center !m-5">
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

import React, { useState } from "react";
import { Typography, Image, theme } from "antd";
import GiayPhepLaiXe from '../../assets/images/giay_phep_lai_xe.jpg';
import BaoHiemXe from '../../assets/images/bao_hiem_Xe.jpg';

const Step4Content = () => {
  const [componentDisabled, setComponentDisabled] = useState<boolean>(true);

  const {
    token: { colorBgContainer, borderRadiusLG },
  } = theme.useToken();

  return (
    <div className="flex justify-between space-x-4" style={{ padding: 24, background: colorBgContainer, borderRadius: borderRadiusLG }}>
      <div className="flex-1 flex flex-col items-center space-y-4">
        <Typography.Text className="!text-2xl font-bold !mb-2">Giấy phép lái xe</Typography.Text>
        {renderCard("Mặt trước", GiayPhepLaiXe)}
        {renderCard("Mặt sau", GiayPhepLaiXe)}
      </div>

      {/* Second Column for Vehicle Image */}
      <div className="flex-1 flex flex-col items-center space-y-4">
        <Typography.Text className="!text-2xl font-bold !mb-2">Bảo hiểm xe</Typography.Text>
        {renderCard("Mặt trước", BaoHiemXe)}
        {renderCard("Mặt sau", BaoHiemXe)}
      </div>
    </div>
  );
};

const renderCard = (title: string, imageSource: any) => (
  <div className="flex flex-col items-center">
    {/* <Typography.Text className="!text-2xl font-bold !mb-2">{title}</Typography.Text> */}
    <Typography.Text className="!text-lg !mb-2">{title}</Typography.Text>
    <Image
      width={300}
      src={imageSource}
      placeholder={<Image preview={false} src={imageSource} width={200} />}
    />
  </div>
);

export default Step4Content;

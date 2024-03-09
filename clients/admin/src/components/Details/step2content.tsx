import { Typography, theme } from "antd";
import IdentityCard from "../../assets/images/identity card.jpg";
import IdentityCard2 from "../../assets/images/identity card 2.jpg";
import GiayDKXe from "../../assets/images/giay_dk_xe.jpg";
import { useState } from "react";

const Step2Content = () => {
    const [componentDisabled, setComponentDisabled] = useState<boolean>(true);
    const {
        token: { colorBgContainer, borderRadiusLG },
    } = theme.useToken();
    return (
        <div className="flex justify-between space-x-4"
            style={{
                padding: 24,
                background: colorBgContainer,
                borderRadius: borderRadiusLG,
            }}
        >
            <div className="flex-1 space-y-4">
                <div className="flex flex-col items-center">
                    <Typography.Text className="!text-2xl font-bold !mb-2">CCCD/CMND/Hộ chiếu</Typography.Text>
                    <Typography.Text className="!text-lg !mb-2">Mặt trước:</Typography.Text>
                    <img src={IdentityCard} alt="Identity 1" className="w-3/5 h-auto" />
                </div>
                <div className="flex flex-col items-center">
                    <Typography.Text className="!text-lg !mb-2">Mặt sau:</Typography.Text>
                    <img src={IdentityCard2} alt="Identity 2" className="w-3/5 h-auto" />
                </div>
            </div>

            {/* Vertical Line */}
            <div className="!border-l !border-gray-300 !h-full"></div>

            <div className="flex-1 flex flex-col items-center">
                <Typography.Text className="!text-2xl font-bold !mb-2">Giấy đăng ký xe</Typography.Text>
                <Typography.Text className="!text-lg !mb-2">Mặt trước:</Typography.Text>
                <img src={GiayDKXe} alt="Vehicle" className="w-3/5 h-auto" />
                <br />
                <Typography.Text className="!text-lg !mb-2">Mặt sau:</Typography.Text>
                <img src={GiayDKXe} alt="Vehicle" className="w-3/5 h-auto" />
            </div>
        </div>
    );
};

export default Step2Content;
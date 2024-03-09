import { Typography, theme } from "antd";
import Motocycle from "../../assets/images/motocycle.png";
import { useState } from "react";

const Step3Content = () => {
    const [componentDisabled, setComponentDisabled] = useState<boolean>(true);
    const {
        token: { colorBgContainer, borderRadiusLG },
    } = theme.useToken();
    return (
        <div className="flex justify-between space-x-4 !pl-3" style={{
            padding: 24,
            background: colorBgContainer,
            borderRadius: borderRadiusLG,
        }}>
            <div className="flex-1 space-y-4">
                <div className="flex flex-col items-center">
                    <Typography.Text className="!text-2xl font-bold !mb-2">Hình ảnh xe đăng ký</Typography.Text>
                    <Typography.Text className="!text-lg !mb-2">Đằng trước:</Typography.Text>
                    <img src={Motocycle} alt="Identity 1" className="w-3/5 h-auto" />
                </div>
                <div className="flex flex-col items-center">
                    <Typography.Text className="!text-lg !mb-2">Đằng sau:</Typography.Text>

                    <img src={Motocycle} alt="Identity 2" className="w-3/5 h-auto" />
                </div>
            </div>

            {/* Second Column for Vehicle Image */}
            <div className="flex-1 flex flex-col items-center">
                <Typography.Text className="!text-lg !mb-2 !mt-8">Bên phải:</Typography.Text>
                <img src={Motocycle} alt="Vehicle" className="w-3/5 h-auto" />
                <br />
                <Typography.Text className="!text-lg !mb-2">Bên trái:</Typography.Text>
                <img src={Motocycle} alt="Vehicle" className="w-3/5 h-auto" />
            </div>
        </div>
    );
};

export default Step3Content;

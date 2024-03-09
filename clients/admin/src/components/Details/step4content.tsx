import { Typography, theme } from "antd";
import GiayPhepLaiXe from '../../assets/images/giay_phep_lai_xe.jpg';
import BaoHiemXe from '../../assets/images/bao_hiem_Xe.jpg';
import { useState } from "react";

const Step4Content = () => {
    const [componentDisabled, setComponentDisabled] = useState<boolean>(true);
    const {
        token: { colorBgContainer, borderRadiusLG },
    } = theme.useToken();
    return (
        <div className="flex justify-between space-x-4" style={{
            padding: 24,
            background: colorBgContainer,
            borderRadius: borderRadiusLG,
        }}>
            <div className="flex-1 space-y-4">
                <div className="flex flex-col items-center">
                    <Typography.Text className="!text-2xl font-bold !mb-2">Hình ảnh xe đăng ký</Typography.Text>
                    <Typography.Text className="!text-lg !mb-2">Mặt trước</Typography.Text>
                    <img src={GiayPhepLaiXe} alt="Identity 1" className="w-3/5 h-auto" />
                </div>
                <div className="flex flex-col items-center">
                    <Typography.Text className="!text-lg !mb-2">Mặt sau</Typography.Text>
                    <img src={GiayPhepLaiXe} alt="Identity 2" className="w-3/5 h-auto" />
                </div>
            </div>

            {/* Second Column for Vehicle Image */}
            <div className="flex-1 flex flex-col items-center">
                <Typography.Text className="!text-2xl font-bold !mb-2">Bảo hiểm xe</Typography.Text>
                <Typography.Text className="!text-lg !mb-2">Mặt Trước</Typography.Text>
                <img src={BaoHiemXe} alt="Vehicle" className="w-3/5 h-auto" />
                <br />
                <Typography.Text className="!text-lg !mb-2">Mặt Sau</Typography.Text>
                <img src={BaoHiemXe} alt="Vehicle" className="w-3/5 h-auto" />
            </div>
        </div>
    );
};

export default Step4Content;

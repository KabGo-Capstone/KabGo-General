import { Typography } from "antd";
import GiayPhepLaiXe from '../../assets/images/giay_phep_lai_xe.jpg';
import BaoHiemXe from '../../assets/images/bao_hiem_Xe.jpg';

const Step4Content = () => {
    return (
        <div className="flex justify-between space-x-4">
            <div className="flex-1 space-y-4">
                <div className="flex flex-col items-start">
                    <Typography.Text className="!text-xl font-bold">Giấy phép lái xe mặt trước</Typography.Text>
                    <img src={GiayPhepLaiXe} alt="Identity 1" className="w-3/5 h-auto" />
                </div>
                <div className="flex flex-col items-start">
                    <Typography.Text className="!text-xl font-bold">Giấy phép lái xe mặt sau</Typography.Text>
                    <img src={GiayPhepLaiXe} alt="Identity 2" className="w-3/5 h-auto" />
                </div>
            </div>

            {/* Second Column for Vehicle Image */}
            <div className="flex-1 flex flex-col items-start">
                <Typography.Text className="!text-xl font-bold">Giấy tờ bảo hiểm xe (Mặt Trước)</Typography.Text>
                <img src={BaoHiemXe} alt="Vehicle" className="w-3/5 h-auto" />
                <br />
                <Typography.Text className="!text-xl font-bold">Giấy tờ bảo hiểm xe (Mặt Sau)</Typography.Text>
                <img src={BaoHiemXe} alt="Vehicle" className="w-3/5 h-auto" />
            </div>
        </div>
    );
};

export default Step4Content;

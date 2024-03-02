import { Typography } from "antd";
import IdentityCard from "../../assets/images/identity card.jpg";
import IdentityCard2 from "../../assets/images/identity card 2.jpg";
import GiayDKXe from "../../assets/images/giay_dk_xe.jpg";

const Step2Content = () => {
    return (
        <div className="flex justify-between space-x-4">
            <div className="flex-1 space-y-4">
                <div className="flex flex-col items-start">
                    <Typography.Text className="!text-xl font-bold">CCCD mặt trước</Typography.Text>
                    <img src={IdentityCard} alt="Identity 1" className="w-3/5 h-auto" />
                </div>
                <div className="flex flex-col items-start">
                    <Typography.Text className="!text-xl font-bold">CCCD mặt sau</Typography.Text>
                    <img src={IdentityCard2} alt="Identity 2" className="w-3/5 h-auto" />
                </div>
            </div>

            {/* Second Column for Vehicle Image */}
            <div className="flex-1 flex flex-col items-start">
                <Typography.Text className="!text-xl font-bold">Giấy đăng ký xe (Mặt trước)</Typography.Text>
                <img src={GiayDKXe} alt="Vehicle" className="w-3/5 h-auto" />
                <br />
                <Typography.Text className="!text-xl font-bold">Giấy đăng ký xe (Mặt sau)</Typography.Text>
                <img src={GiayDKXe} alt="Vehicle" className="w-3/5 h-auto" />
            </div>
        </div>
    );
};

export default Step2Content;
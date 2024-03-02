import { Typography } from "antd";
import Motocycle from "../../assets/images/motocycle.png";

const Step3Content = () => {
    return (
        <div className="flex justify-between space-x-4">
            <div className="flex-1 space-y-4">
                <div className="flex flex-col items-start">
                    <Typography.Text className="!text-xl font-bold">Xe đăng ký mặt trước</Typography.Text>
                    <img src={Motocycle} alt="Identity 1" className="w-3/5 h-auto" />
                </div>
                <div className="flex flex-col items-start">
                    <Typography.Text className="!text-xl font-bold">Xe đăng ký mặt sau</Typography.Text>
                    <img src={Motocycle} alt="Identity 2" className="w-3/5 h-auto" />
                </div>
            </div>

            {/* Second Column for Vehicle Image */}
            <div className="flex-1 flex flex-col items-start">
                <Typography.Text className="!text-xl font-bold">Xe đăng ký (phải)</Typography.Text>
                <img src={Motocycle} alt="Vehicle" className="w-3/5 h-auto" />
                <br />
                <Typography.Text className="!text-xl font-bold">Xe đăng ký (trái)</Typography.Text>
                <img src={Motocycle} alt="Vehicle" className="w-3/5 h-auto" />
            </div>
        </div>
    );
};

export default Step3Content;

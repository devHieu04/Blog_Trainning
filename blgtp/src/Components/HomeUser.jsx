
import bg from '../assets/bg.jpeg' // Tạo file CSS riêng để cấu hình giao diện
import Header from './HeaderUser';
const HomeUser = () => {

  return (
    <div>
      <h1 className="text-2xl font-bold mb-4 flex items-center justify-center ">Trang chủ user </h1>
      <Header />
      <img src={bg} alt="" />
    </div>
  );
};

export default HomeUser;

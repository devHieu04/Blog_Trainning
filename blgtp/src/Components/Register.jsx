import { useState } from 'react';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';

function Register() {

  const navigate = useNavigate();
  const [formData, setFormData] = useState({
    email: '',
    username: '',
    password: '',
    password_confirmation: '',
    phone: '', // Thêm trường phone vào state
    role: '',  // Thêm trường role vào state
  });

  const handleInputChange = (event) => {
    const { name, value } = event.target;
    setFormData((prevData) => ({
      ...prevData,
      [name]: value,
    }));
  };

  const handleSubmit = (event) => {
    event.preventDefault();

    // Kiểm tra xác nhận mật khẩu
    if (formData.password !== formData.password_confirmation) {
      console.log('Xác nhận mật khẩu không khớp');
      return;
    }

    // Kiểm tra dữ liệu hợp lệ trước khi gửi lên server
    if (!formData.email || !formData.username || !formData.password || !formData.phone || !formData.role) {
      console.log('Vui lòng điền đầy đủ thông tin');
      return;
    }

    axios
      .post('http://localhost:3000/api/users', { user: formData }) // Gửi dữ liệu bằng cú pháp "user: formData"
      .then((response) => {
        console.log(response.data);
        // Hiển thị thông báo đăng ký thành công
        alert('Đăng ký thành công! Vui lòng đăng nhập.');
        // Chuyển hướng đến trang đăng nhập
        navigate('/login');
      })
      .catch((error) => {
        console.log(error.response.data);
        // Xử lý lỗi từ server
      });
  };

  return (
    <div className="max-w-md mx-auto p-4">
      <h2 className="text-2xl font-bold mb-4">Đăng ký</h2>
      <form onSubmit={handleSubmit}>
        <div className="mb-4">
          <label htmlFor="username" className="block mb-2 font-medium">
            Tên người dùng
          </label>
          <input
            type="text"
            id="username"
            name="username"
            className="w-full p-2 border border-gray-300 rounded"
            value={formData.username}
            onChange={handleInputChange}
          />
        </div>
        <div className="mb-4">
          <label htmlFor="email" className="block mb-2 font-medium">
            Email
          </label>
          <input
            type="email"
            id="email"
            name="email"
            className="w-full p-2 border border-gray-300 rounded"
            value={formData.email}
            onChange={handleInputChange}
          />
        </div>
        <div className="mb-4">
          <label htmlFor="password" className="block mb-2 font-medium">
            Mật khẩu
          </label>
          <input
            type="password"
            id="password"
            name="password"
            className="w-full p-2 border border-gray-300 rounded"
            value={formData.password}
            onChange={handleInputChange}
          />
        </div>
        <div className="mb-4">
          <label htmlFor="password_confirmation" className="block mb-2 font-medium">
            Xác nhận mật khẩu
          </label>
          <input
            type="password"
            id="password_confirmation"
            name="password_confirmation"
            className="w-full p-2 border border-gray-300 rounded"
            value={formData.password_confirmation}
            onChange={handleInputChange}
          />
        </div>
        {/* Thêm trường phone vào form */}
        <div className="mb-4">
          <label htmlFor="phone" className="block mb-2 font-medium">
            Điện thoại
          </label>
          <input
            type="text"
            id="phone"
            name="phone"
            className="w-full p-2 border border-gray-300 rounded"
            value={formData.phone}
            onChange={handleInputChange}
          />
        </div>
        {/* Thêm trường role vào form */}
        <div className="mb-4">
          <label htmlFor="role" className="block mb-2 font-medium">
            Vai trò
          </label>
          <input
            type="text"
            id="role"
            name="role"
            className="w-full p-2 border border-gray-300 rounded"
            value={formData.role}
            onChange={handleInputChange}
          />
        </div>
        <button
          type="submit"
          className="w-full bg-blue-500 text-white font-medium py-2 px-4 rounded"
        >
          Đăng ký
        </button>
      </form>
    </div>
  );
}

export default Register;

import { useState } from 'react';
import axios from 'axios';
function Register() {

    const [formData, setFormData] = useState({
        username: '',
        email: '',
        password: ''
      });
    
      const handleInputChange = (event) => {
        const { name, value } = event.target;
        setFormData((prevData) => ({
          ...prevData,
          [name]: value
        }));
      };
    
      const handleSubmit = (event) => {
        event.preventDefault();
        
        axios.post('http://localhost:3000/api/users', formData)
          .then(response => {
            console.log(response.data);
            // Xử lý phản hồi từ server
          })
          .catch(error => {
            console.log(error.response.data);
            // Xử lý lỗi từ server
          });
      };
    
      return (
        <div className="max-w-md mx-auto p-4">
      <h2 className="text-2xl font-bold mb-4">Đăng ký</h2>
      <form onSubmit={handleSubmit}>
        <div className="mb-4">
          <label htmlFor="username" className="block mb-2 font-medium">Tên người dùng</label>
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
          <label htmlFor="email" className="block mb-2 font-medium">Email</label>
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
          <label htmlFor="password" className="block mb-2 font-medium">Mật khẩu</label>
          <input
            type="password"
            id="password"
            name="password"
            className="w-full p-2 border border-gray-300 rounded"
            value={formData.password}
            onChange={handleInputChange}
          />
        </div>
        <button type="submit" className="w-full bg-blue-500 text-white font-medium py-2 px-4 rounded">
          Đăng ký
        </button>
      </form>
    </div>
      );
    
}

export default Register;
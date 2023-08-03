import { useState } from 'react';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';

const LoginForm = () => {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const navigate = useNavigate();

  const handleInputChange = (event) => {
    const { name, value } = event.target;

    if (name === 'username') {
      setUsername(value);
    } else if (name === 'password') {
      setPassword(value);
    }
  };

  const handleSubmit = async (event) => {
    event.preventDefault();

    try {
      const response = await axios.post('http://localhost:3000/api/login', {
        user: {
          username,
          password,
        },
      });

      const { role, token, user_id } = response.data;

      // Lưu token và thông tin người dùng vào Local Storage
      localStorage.setItem('token', token);
      localStorage.setItem('role', role);
      localStorage.setItem('user_id', user_id);

      if (role === 'Admin') {
        navigate('/homeadmin'); // Chuyển hướng đến trang quản lý (admin)
      } else if (role === 'User') {
        navigate('/comment'); // Chuyển hướng đến trang danh sách bài viết (user)
      }
    } catch (error) {
      console.log(error.response.data);
    }
  };

  return (
    <div className="max-w-md mx-auto p-4">
      <h2 className="text-2xl font-bold mb-4">Đăng nhập</h2>
      <form onSubmit={handleSubmit}>
        <div className="mb-4">
          <label htmlFor="username" className="block mb-2 font-medium">Admin name</label>
          <input
            type="text"
            id="username"
            name="username"
            className="w-full p-2 border border-gray-300 rounded"
            value={username}
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
            value={password}
            onChange={handleInputChange}
          />
        </div>
        <button type="submit" className="w-full bg-blue-500 text-white font-medium py-2 px-4 rounded">
          Đăng nhập
        </button>
      </form>
    </div>
  );
};

export default LoginForm;

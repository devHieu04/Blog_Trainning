import  { useState } from 'react';
import React from 'react'
import ReactDOM from 'react-dom'
import axios from 'axios';

const LoginForm = () => {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');

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

      // Lưu thông tin vào localStorage
      localStorage.setItem('token', token);
      localStorage.setItem('role', role);
      localStorage.setItem('user_id', user_id);

      // Chuyển trang sau khi đăng nhập thành công
      window.location.reload();
      if (role === 'Admin') {
        window.location.href = '/homeadmin';
      } else if (role === 'User') {
        window.location.href = '/homeuser';
      }
    } catch (error) {
      console.log(error.response.data);
    }
  };

  return (
    <div className="container d-flex justify-content-center align-items-center vh-100 ">
      <div className='card p-4 w-50 min-w-md'>
      <h2 className="text-center font-weight-bold mb-4">Đăng nhập</h2>
      <form onSubmit={handleSubmit}>
        <div className="mb-4">
          <label htmlFor="username" className="form-label mb-2 font-weight-bold">Admin name</label>
          <input
            type="text"
            id="username"
            name="username"
            className="form-control"
            value={username}
            onChange={handleInputChange}
          />
        </div>
        <div className="mb-4">
          <label htmlFor="password" className="form-label mb-2 font-weight-bold">Mật khẩu</label>
          <input
            type="password"
            id="password"
            name="password"
            className="form-control"
            value={password}
            onChange={handleInputChange}
          />
        </div>
        <button type="submit" className="btn btn-primary btn-block">
          Đăng nhập
        </button>
      </form>
      <p className="mt-3">
          Chưa có tài khoản? <a href="/register">Đăng kí</a>
        </p>
    </div>
   
    </div>
  );
};

export default LoginForm;

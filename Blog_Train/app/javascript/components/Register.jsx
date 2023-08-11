import React, { useState } from 'react';
import axios from 'axios';
import { useNavigate } from 'react-router-dom';

function Register() {
  const navigate = useNavigate();
  const [formData, setFormData] = useState({
    email: '',
    username: '',
    password: '',
    password_confirmation: '',
    phone: '',
    role: '',
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

    if (formData.password !== formData.password_confirmation) {
      console.log('Xác nhận mật khẩu không khớp');
      return;
    }

    if (!formData.email || !formData.username || !formData.password || !formData.phone || !formData.role) {
      console.log('Vui lòng điền đầy đủ thông tin');
      return;
    }

    axios
      .post('http://localhost:3000/api/users', { user: formData })
      .then((response) => {
        console.log(response.data);
        alert('Đăng ký thành công! Vui lòng đăng nhập.');
        navigate('/login');
      })
      .catch((error) => {
        console.log(error.response.data);
      });
  };

  return (
    <div className="container">
      <div className="row justify-content-center">
        <div className="col-md-6">
          <h2 className="text-center font-weight-bold mb-4">Đăng ký</h2>
          <form onSubmit={handleSubmit}>
            <div className="mb-3">
              <label htmlFor="username" className="form-label">
                Tên người dùng
              </label>
              <input
                type="text"
                id="username"
                name="username"
                className="form-control"
                value={formData.username}
                onChange={handleInputChange}
              />
            </div>
            <div className="mb-3">
              <label htmlFor="email" className="form-label">
                Email
              </label>
              <input
                type="email"
                id="email"
                name="email"
                className="form-control"
                value={formData.email}
                onChange={handleInputChange}
              />
            </div>
            <div className="mb-3">
              <label htmlFor="password" className="form-label">
                Mật khẩu
              </label>
              <input
                type="password"
                id="password"
                name="password"
                className="form-control"
                value={formData.password}
                onChange={handleInputChange}
              />
            </div>
            <div className="mb-3">
              <label htmlFor="password_confirmation" className="form-label">
                Xác nhận mật khẩu
              </label>
              <input
                type="password"
                id="password_confirmation"
                name="password_confirmation"
                className="form-control"
                value={formData.password_confirmation}
                onChange={handleInputChange}
              />
            </div>
            <div className="mb-3">
              <label htmlFor="phone" className="form-label">
                Điện thoại
              </label>
              <input
                type="text"
                id="phone"
                name="phone"
                className="form-control"
                value={formData.phone}
                onChange={handleInputChange}
              />
            </div>
            <div className="mb-3">
              <label htmlFor="role" className="form-label">
                Vai trò
              </label>
              <input
                type="text"
                id="role"
                name="role"
                className="form-control"
                value={formData.role}
                onChange={handleInputChange}
              />
            </div>
            <button type="submit" className="btn btn-primary w-100">
              Đăng ký
            </button>
          </form>
        </div>
      </div>
    </div>
  );
}

export default Register;

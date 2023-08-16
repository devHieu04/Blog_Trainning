import React, { Component } from 'react';

class LoginForm extends Component {
  constructor(props) {
    super(props);

    this.state = {
      email: '',
      password: ''
    };
  }

  handleInputChange = event => {
    const { name, value } = event.target;
    this.setState({ [name]: value });
  };

  handleSubmit = event => {
    event.preventDefault();
    const { email, password } = this.state;
    // Thực hiện xử lý đăng nhập tại đây (gọi API, kiểm tra đăng nhập, vv.)
  };

  render() {
    const { email, password } = this.state;

    return (
      <div className="container mt-4">
        <h2 className="mb-4">Login Form</h2>
        <form onSubmit={this.handleSubmit}>
          <div className="mb-3">
            <label htmlFor="email" className="form-label">Email:</label>
            <input
              type="email"
              name="email"
              className="form-control"
              value={email}
              onChange={this.handleInputChange}
            />
          </div>
          <div className="mb-3">
            <label htmlFor="password" className="form-label">Password:</label>
            <input
              type="password"
              name="password"
              className="form-control"
              value={password}
              onChange={this.handleInputChange}
            />
          </div>
          <button type="submit" className="btn btn-primary">Login</button>
        </form>
      </div>
    );
  }
}

export default LoginForm;

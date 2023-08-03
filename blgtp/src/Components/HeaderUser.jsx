import axios from 'axios';
import './Home.css';
import { Link } from 'react-router-dom';
import './Header.css';

const Header = () => {
  const handleLogout = async () => {
    const token = localStorage.getItem('token');
    const headers = { Authorization: `Bearer ${token}` };

    try {
      await axios.delete('http://localhost:3000/api/logout', { headers });
      localStorage.removeItem('token');
      localStorage.removeItem('user_id');
      window.location.href = '/login';
    } catch (error) {
      console.log(error.response.data);
    }
  };

  return (
    <div>
      
      <nav className="menu">
        <ul>
            <li className='bg-green-500 text-white rounded px-4 py-2'>
                <Link to="/homeadmin">Trang chủ</Link>
            </li>
          <li className='bg-green-500 text-white rounded px-4 py-2'>
            <Link to="/post">Xem bài viết</Link>
          </li>
          <li className='bg-green-500 text-white rounded px-4 py-2'>
            <Link to="/manage"></Link>
          </li>
        </ul>
        <button onClick={handleLogout} className="logout-btn">
          Đăng xuất
        </button>
      </nav>
    </div>
  );
};

export default Header;

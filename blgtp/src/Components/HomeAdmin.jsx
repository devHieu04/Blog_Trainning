import { useNavigate } from 'react-router-dom';
import axios from 'axios';
// http://localhost:3000/api/admins/logout
function HomeAdmin() {
  const navigate = useNavigate();

  const handleLogout = () => {
    axios.delete('http://localhost:3000/api/admins/logout')
      .then(() => {
        navigate('/login');
      })
      .catch((error) => {
        console.log(error);
      });
  };

  return (
    <div>
      <h2>Trang chủ admin</h2>
      <button onClick={handleLogout}>Đăng xuất</button>
    </div>
  );
}

export default HomeAdmin;

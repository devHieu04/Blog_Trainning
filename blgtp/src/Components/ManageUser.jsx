import  { useState, useEffect } from 'react';
import axios from 'axios';

function ManageUsers() {
  const [users, setUsers] = useState([]);
  const [selectedUser, setSelectedUser] = useState(null);
  const [username, setUsername] = useState('');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [phone, setPhone] = useState('');

  useEffect(() => {
    fetchUsers();
  }, []);

  const fetchUsers = async () => {
    try {
      const response = await axios.get('http://localhost:3000/api/users');
      setUsers(response.data);
    } catch (error) {
      console.error(error);
    }
  };

  const addUser = async () => {
    try {
      const response = await axios.post('http://localhost:3000/api/users', { user: { username, email, password, phone } });
      console.log(response.data);
      fetchUsers();
      setUsername('');
      setEmail('');
      setPassword('');
      setPhone('');
    } catch (error) {
      console.error(error);
    }
  };

  const editUser = async (userId, userData) => {
    try {
      const response = await axios.patch(`http://localhost:3000/api/users/${userId}`, { user: userData });
      console.log(response.data);
      fetchUsers();
      setSelectedUser(null);
      setUsername('');
      setEmail('');
      setPassword('');
      setPhone('');
    } catch (error) {
      console.error(error);
    }
  };

  const deleteUser = async (userId) => {
    try {
      const response = await axios.delete(`http://localhost:3000/api/users/${userId}`);
      console.log(response.data);
      fetchUsers();
      setSelectedUser(null);
      setUsername('');
      setEmail('');
      setPassword('');
      setPhone('');
    } catch (error) {
      console.error(error);
    }
  };

  const handleUserSelect = (user) => {
    setSelectedUser(user);
    setUsername(user.username);
    setEmail(user.email);
    setPassword(user.password);
    setPhone(user.phone);
  };

  return (
    <div className="container mx-auto p-4">
      <h1 className="text-2xl font-bold mb-4">User Management</h1>
      <div className="mb-4">
        <input
          type="text"
          placeholder="Username"
          value={username}
          onChange={(e) => setUsername(e.target.value)}
          className="border border-gray-300 rounded-md px-2 py-1 mr-2"
        />
        <input
          type="email"
          placeholder="Email"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          className="border border-gray-300 rounded-md px-2 py-1 mr-2"
        />
        <input
          type="password"
          placeholder="Password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
          className="border border-gray-300 rounded-md px-2 py-1 mr-2"
        />
        <input
          type="text"
          placeholder="Phone"
          value={phone}
          onChange={(e) => setPhone(e.target.value)}
          className="border border-gray-300 rounded-md px-2 py-1 mr-2"
        />
        {selectedUser ? (
          <>
            <button onClick={() => editUser(selectedUser.id, { username, email, password, phone })} className="bg-blue-500 text-white px-4 py-1 rounded-md">
              Update User
            </button>
            <button onClick={() => deleteUser(selectedUser.id)} className="bg-red-500 text-white px-4 py-1 rounded-md ml-2">
              Delete User
            </button>
          </>
        ) : (
          <button onClick={addUser} className="bg-blue-500 text-white px-4 py-1 rounded-md">
            Add User
          </button>
        )}
      </div>
      <table className="table-auto">
        <thead>
          <tr>
            <th className="px-4 py-2">Username</th>
            <th className="px-4 py-2">Email</th>
            <th className="px-4 py-2">Phone</th>
            <th className="px-4 py-2">Actions</th>
          </tr>
        </thead>
        <tbody>
          {users.map((user) => (
            <tr key={user.id} onClick={() => handleUserSelect(user)}>
              <td className="border px-4 py-2">{user.username}</td>
              <td className="border px-4 py-2">{user.email}</td>
              <td className="border px-4 py-2">{user.phone}</td>
              <td className="border px-4 py-2">
                <button className="bg-yellow-500 text-white px-2 py-1 rounded-md mr-2">
                  Edit
                </button>
                <button className="bg-red-500 text-white px-2 py-1 rounded-md">
                  Delete
                </button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

export default ManageUsers;

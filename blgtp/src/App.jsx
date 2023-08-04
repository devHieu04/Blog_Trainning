import { useState } from 'react';
import { BrowserRouter, Route, Routes, Navigate } from 'react-router-dom';
import { ChakraProvider } from '@chakra-ui/react';
import Register from './Components/Register';
import SignIn from './Components/LogForm';
import Manage from './Components/ManageUser';
import HomeAdmin from './Components/HomeAdmin';
import HomeUser from './Components/HomeUser';
import PostForm from './Components/PostForm';
import PostList from './Components/PostList';
import UserComment from './Components/PostDetail';
import './App.css';

function App() {
  const [isLoggedIn, setIsLoggedIn] = useState(!!localStorage.getItem('user_id'));
  const role = localStorage.getItem('role');
  console.log(role);

  return (
    <ChakraProvider>
      <BrowserRouter>
        <Routes>
          <Route path="/login" element={isLoggedIn ? <Navigate to={role === 'Admin' ? '/homeadmin' : '/homeuser'} /> : <SignIn setIsLoggedIn={setIsLoggedIn} />} />
          <Route path="/register" element={<Register />} />
          {role === 'Admin' && (
            <>
              <Route path="/homeadmin" element={<HomeAdmin />} />
              <Route path="/post" element={<PostForm />} />
              <Route path="/manage" element={<Manage />} />
              <Route path="/listpost" element={<PostList />} />
              <Route path="/comment" element={<UserComment />} />
            </>
          )}
          {role === 'User' && (
            <>
              <Route path="/homeuser" element={<HomeUser />} />
              <Route path="/comment" element={<UserComment />} />
            </>
          )}
          <Route path="/*" element={isLoggedIn ? <Navigate to={role === 'Admin' ? '/homeadmin' : '/homeuser'} /> : <Navigate to="/login" />} />
        </Routes>
      </BrowserRouter>
    </ChakraProvider>
  );
}

export default App;

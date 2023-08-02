import { BrowserRouter, Route, Routes } from 'react-router-dom';

import { ChakraProvider } from '@chakra-ui/react';
import Register from './Components/Register'
// import AdminSignIn from './Components/Loginadmin'
import SignIn from './Components/LogForm'
import Manage from './Components/ManageUser'
import HomeAdmin from './Components/HomeAdmin'
import PostForm from './Components/PostForm'
import PostList from './Components/PostList'
import UserComment from './Components/PostDetail'
import './App.css'

function App() {
  return (
    <ChakraProvider>
      <BrowserRouter>
        <Routes>
          <Route path='/*' element={<SignIn />} />
          <Route path='/register' element ={<Register/>}/>
          <Route path='/login' element ={<SignIn/>}/>
          <Route path='/homeadmin' element ={<HomeAdmin/>}/>
          <Route path='/post' element ={<PostForm/>}/>
          <Route path='/manage' element ={<Manage/>}/>
          <Route path='/listpost' element ={<PostList/>}/>
          <Route path='/comment' element ={<UserComment/>}/>
        </Routes>
      </BrowserRouter>
    </ChakraProvider>
  );
}

export default App;
import { useState } from 'react';
import axios from 'axios';
import Header from './Header';

const PostForm = () => {
  const [title, setTitle] = useState('');
  const [banner, setBanner] = useState(null);
  const [introduction, setIntroduction] = useState('');
  const [content, setContent] = useState('');
  const [bannerUrl, setBannerUrl] = useState('');

  const handleTitleChange = (event) => {
    setTitle(event.target.value);
  };

  const handleBannerChange = (event) => {
    setBanner(event.target.files[0]);
  };

  const handleIntroductionChange = (event) => {
    setIntroduction(event.target.value);
  };

  const handleContentChange = (event) => {
    setContent(event.target.value);
  };

  const handleSubmit = async (event) => {
    event.preventDefault();
  
    const formData = new FormData();
    formData.append('title', title);
    formData.append('banner', banner);
    formData.append('introduction', introduction);
    formData.append('content', content);
  
    try {
      const response = await axios.post('http://localhost:3000/api/posts', formData, {
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      });
      const bannerUrl = 'http://localhost:3000'+response.data.bannerUrl;
      setBannerUrl(bannerUrl); // Đây là phần lấy đường dẫn ảnh từ backend và đặt vào state
      console.log(bannerUrl);
      window.location.reload(); // In ra đường dẫn ảnh trong console
    } catch (error) {
      console.log(error.response.data);
    }
  };
  

  return (
    <div>
       <Header/>
    <div className="max-w-md mx-auto p-4">
     
      <h2 className="text-2xl font-bold mb-4">Đăng bài viết</h2>
      <form onSubmit={handleSubmit}>
        <div className="mb-4">
          <label htmlFor="title" className="block mb-2 font-medium">
            Tiêu đề
          </label>
          <input
            type="text"
            id="title"
            name="title"
            className="w-full p-2 border border-gray-300 rounded"
            value={title}
            onChange={handleTitleChange}
          />
        </div>
        <div className="mb-4">
          <label htmlFor="banner" className="block mb-2 font-medium">
            Banner
          </label>
          <input
            type="file"
            id="banner"
            name="banner"
            accept="image/*"
            onChange={handleBannerChange}
          />
        </div>
        <div className="mb-4">
          <label htmlFor="introduction" className="block mb-2 font-medium">
            Giới thiệu
          </label>
          <textarea
            id="introduction"
            name="introduction"
            rows="3"
            className="w-full p-2 border border-gray-300 rounded"
            value={introduction}
            onChange={handleIntroductionChange}
          ></textarea>
        </div>
        <div className="mb-4">
          <label htmlFor="content" className="block mb-2 font-medium">
            Nội dung
          </label>
          <textarea
            id="content"
            name="content"
            rows="5"
            className="w-full p-2 border border-gray-300 rounded"
            value={content}
            onChange={handleContentChange}
          ></textarea>
        </div>
        <button
          type="submit"
          className="w-full bg-blue-500 text-white font-medium py-2 px-4 rounded"
        >
          Đăng bài
        </button>
      </form>
      {bannerUrl && (
        <div className="mt-4">
          <h3 className="text-lg font-bold">Banner đã tải lên:</h3>
          <img src={bannerUrl} alt="Banner" className="mt-2" />
        </div>
      )}
    </div>
    </div>
  );
};

export default PostForm;

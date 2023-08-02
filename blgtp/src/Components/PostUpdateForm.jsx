import { useState, useEffect } from 'react';
import axios from 'axios';
import PropTypes from 'prop-types';

const PostUpdateForm = ({ postId }) => {
  const [title, setTitle] = useState('');
  const [banner, setBanner] = useState(null);
  const [introduction, setIntroduction] = useState('');
  const [content, setContent] = useState('');

  useEffect(() => {
    fetchPost();
  }, [postId]);

  const fetchPost = () => {
    axios
      .get(`http://localhost:3000/api/posts/${postId}`)
      .then((response) => {
        const post = response.data;
        setTitle(post.title);
        setIntroduction(post.introduction);
        setContent(post.content);
      })
      .catch((error) => {
        console.log(error.response.data);
      });
  };

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
      const response = await axios.put(`http://localhost:3000/api/posts/${postId}`, formData, {
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      });
      console.log('Updated post:', response.data);
      // Thực hiện các hành động sau khi cập nhật thành công (nếu có)
      window.location.reload();
    } catch (error) {
      console.log(error.response.data);
    }
  };

  return (
    <div className="max-w-md mx-auto p-4">
      <h2 className="text-2xl font-bold mb-4">Cập nhật bài viết</h2>
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
          Cập nhật
        </button>
      </form>
    </div>
  );
};

PostUpdateForm.propTypes = {
  postId: PropTypes.number.isRequired,
};

export default PostUpdateForm;

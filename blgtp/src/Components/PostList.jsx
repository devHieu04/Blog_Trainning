import { useState, useEffect } from 'react';
import axios from 'axios';
import PostUpdateForm from './PostUpdateForm';

const PostList = () => {
  const [posts, setPosts] = useState([]);
  const [selectedPostId, setSelectedPostId] = useState(null);

  useEffect(() => {
    fetchPosts();
  }, []);

  const fetchPosts = () => {
    axios
      .get('http://localhost:3000/api/posts')
      .then((response) => {
        setPosts(response.data);
      })
      .catch((error) => {
        console.log(error.response.data);
      });
  };

  const handleDeletePost = (postId) => {
    axios
      .delete(`http://localhost:3000/api/posts/${postId}`)
      .then((response) => {
        console.log(response.data);
        // Cập nhật danh sách bài viết sau khi xoá thành công
        fetchPosts();
      })
      .catch((error) => {
        console.log(error.response.data);
      });
  };

  const handlePostClick = (postId) => {
    setSelectedPostId(postId);
  };

  const handlePostUpdate = () => {
    // Cập nhật danh sách bài viết sau khi cập nhật thành công
    fetchPosts();
    // Ẩn form cập nhật khi cập nhật thành công
    setSelectedPostId(null);
    // window.location.reload();
  };

  return (
    <div className="max-w-md mx-auto p-4">
      <h2 className="text-2xl font-bold mb-4">Danh sách bài viết</h2>
      {posts.map((post) => (
        <div key={post.id} className="mb-4 p-4 border border-gray-300 rounded">
          <h3 className="text-lg font-bold" onClick={() => handlePostClick(post.id)}>
            {post.title}
          </h3>
          <p className="text-gray-600">{post.introduction}</p>
          {post.banner && (
            <img src={'http://localhost:3000' + post.banner.url} alt="Banner" className="mt-4" />
          )}

          <p className="mt-4">{post.content}</p>
          <button
            onClick={() => handleDeletePost(post.id)}
            className="mt-4 bg-red-500 text-white font-medium py-2 px-4 rounded"
          >
            Xoá
          </button>

          {/* Hiển thị form cập nhật bài viết khi click vào nút "Cập nhật" */}
          {selectedPostId === post.id && <PostUpdateForm postId={post.id} onPostUpdate={handlePostUpdate} />}
        </div>
      ))}
    </div>
  );
};

export default PostList;

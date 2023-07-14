import { useEffect, useState } from 'react';
import axios from 'axios';

const PostList = () => {
  const [posts, setPosts] = useState([]);

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

  return (
    <div className="max-w-md mx-auto p-4">
      <h2 className="text-2xl font-bold mb-4">Danh sách bài viết</h2>
      {posts.map((post) => (
        <div key={post.id} className="mb-4 p-4 border border-gray-300 rounded">
          <h3 className="text-lg font-bold">{post.title}</h3>
          <p className="text-gray-600">{post.introduction}</p>
          {post.banner && (
            <img
              src={`http://localhost:3000/uploads/post/${post.id}/${post.banner}`}
              alt="Banner"
              className="mt-4"
            />
          )}
          <p className="mt-4">{post.content}</p>
          <button
            onClick={() => handleDeletePost(post.id)}
            className="mt-4 bg-red-500 text-white font-medium py-2 px-4 rounded"
          >
            Xoá
          </button>
        </div>
      ))}
    </div>
  );
};

export default PostList;

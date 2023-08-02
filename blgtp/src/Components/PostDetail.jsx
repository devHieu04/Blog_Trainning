import { useState, useEffect } from 'react';
import axios from 'axios';

const PostDetail = () => {
    const [posts, setPosts] = useState([]);
    const [selectedPost, setSelectedPost] = useState(null);
    const [newComment, setNewComment] = useState('');
    const [selectedComment, setSelectedComment] = useState(null); // Lưu trữ bình luận được chọn
    const [currentUser, setCurrentUser] = useState(null);
    const [currentUserId, setCurrentUserId] = useState(null);
    useEffect(() => {
        fetchPosts();
        getCurrentUser();
    }, []);

    const fetchPosts = () => {
        const token = localStorage.getItem('token');
        const headers = { Authorization: `Bearer ${token}` };

        axios
            .get('http://localhost:3000/api/posts', { headers })
            .then((response) => {
                setPosts(response.data);
            })
            .catch((error) => {
                console.log(error.response.data);
            });
    };

    // Trong React component
    const getCurrentUser = () => {
        const token = localStorage.getItem('token');
        if (token) {
            axios
                .get('http://localhost:3000/api/users/current', {
                    headers: { Authorization: `Bearer ${token}` },
                })
                .then((response) => {
                    setCurrentUser(response.data); // Lưu thông tin người dùng vào state currentUser
                    setCurrentUserId(response.data.id);
                    console.log(response.data.id); // Lưu user_id vào state currentUserId
                })
                .catch((error) => {
                    console.log(error.response.data);
                });
        }
    };


    const handlePostClick = (post) => {
        setSelectedPost(post);
        fetchComments(post.id); // Lấy danh sách bình luận cho bài viết khi người dùng chọn vào
    };

    const fetchComments = (postId) => {
        axios
            .get(`http://localhost:3000/api/posts/${postId}/show_comments`)
            .then((response) => {
                setSelectedPost((prevPost) => ({
                    ...prevPost,
                    comments: response.data,
                }));
            })
            .catch((error) => {
                console.log(error.response.data);
            });
    };

    const handleCommentChange = (event) => {
        setNewComment(event.target.value);
    };

    const handleCommentSubmit = () => {
        const token = localStorage.getItem('token');
        const headers = { Authorization: `Bearer ${token}` };

        // Gửi yêu cầu tạo bình luận mới
        axios
            .post(
                `http://localhost:3000/api/comments`,
                {
                    comment: {
                        content: newComment,
                        post_id: selectedPost.id, // Gửi post_id của bài viết đang chọn
                    },
                },
                { headers }
            )
            .then((response) => {
                console.log(response.data);
                // Đặt lại nội dung trong khung bình luận thành rỗng
                setNewComment('');

                // Sau khi thêm bình luận thành công, cập nhật danh sách bình luận cho bài viết đó
                fetchComments(selectedPost.id); // Gọi lại hàm fetchComments với id của bài viết đã chọn
            })
            .catch((error) => {
                console.log(error.response.data);
            });
    };

    const handleCommentSelect = (comment) => {
        setSelectedComment(comment);
    };

    const handleCommentEdit = (commentId, newContent) => {
        const token = localStorage.getItem('token');
        const headers = { Authorization: `Bearer ${token}` };

        // Gọi API sửa bình luận
        axios
            .put(
                `http://localhost:3000/api/comments/${commentId}`,
                {
                    comment: {
                        content: newContent,
                    },
                },
                { headers }
            )
            .then((response) => {
                // Cập nhật nội dung bình luận trong danh sách khi sửa thành công
                console.log(response.data);
                setSelectedPost((prevPost) => ({
                    ...prevPost,
                    comments: prevPost.comments.map((comment) =>
                        comment.id === commentId ? { ...comment, content: newContent } : comment
                    ),
                }));
                setSelectedComment(null); // Đặt lại bình luận được chọn về null để ẩn form sửa bình luận
            })
            .catch((error) => {
                console.log(error.response.data);
            });
    };

    const handleCommentCancel = () => {
        setSelectedComment(null);
    };

    const handleDeleteClick = (comment) => {
        if (comment.user.id !== localStorage.getItem('userId')) {
            alert('Không phải bình luận của bạn!');
        } else {
            axios
                .delete(`http://localhost:3000/api/comments/${comment.id}`, {
                    headers: { Authorization: `Bearer ${localStorage.getItem('token')}` },
                })
                .then((response) => {
                    console.log(response.data);
                    setSelectedPost((prevPost) => ({
                        ...prevPost,
                        comments: prevPost.comments.filter((c) => c.id !== comment.id),
                    }));
                    setSelectedComment(null);
                })
                .catch((error) => {
                    console.log(error.response.data);
                });
        }
    };

    return (
        <div>
            {/* Hiển thị thông tin người dùng hiện tại và người dùng của bình luận được chọn */}

            {/* Hiển thị thông tin người dùng hiện tại và người dùng của bình luận được chọn */}
            <div>
                <h4>Thông tin người dùng hiện tại:</h4>
                {currentUser && (
                    <p>
                        ID: {currentUser.id}, Username: {currentUser.username}
                    </p>
                )}
                <h4>Thông tin người dùng của bình luận được chọn:</h4>
                {selectedComment && (
                    <p>
                        ID: {selectedComment.user.id}, Username: {selectedComment.user.username}
                    </p>
                )}
            </div>
            {posts.map((post) => (
                <div key={post.id} className="mb-4 p-4 border border-gray-300 rounded">
                    <h3 className="text-lg font-bold" onClick={() => handlePostClick(post)}>
                        {post.title}
                    </h3>
                    <p className="text-gray-600">{post.introduction}</p>
                    {post.banner && <img src={'http://localhost:3000' + post.banner.url} alt="Banner" className="mt-4" />}
                    {selectedPost?.id === post.id && (
                        <>
                            <p className="mt-4">{post.content}</p>
                            {/* Hiển thị danh sách bình luận */}
                            <div>
                                <h3>Bình luận:</h3>
                                {selectedPost.comments ? (
                                    selectedPost.comments.map((comment) => (
                                        <div key={comment.id} onClick={() => handleCommentSelect(comment)}>
                                            <p>{comment.user.username}: {comment.content}</p>
                                            {/* Hiển thị form chỉnh sửa khi chọn bình luận */}
                                            {selectedComment?.id === comment.id && (
                                                <div>
                                                    <textarea value={selectedComment.content} onChange={(e) => setSelectedComment({ ...selectedComment, content: e.target.value })} />
                                                    <button onClick={() => handleCommentEdit(comment.id, selectedComment.content)}>Lưu</button>
                                                    <button onClick={handleCommentCancel}>Hủy</button>
                                                    <button onClick={() => handleDeleteClick(comment)}>Xoá</button>
                                                </div>
                                            )}
                                        </div>
                                    ))
                                ) : (
                                    <p>Không có bình luận</p>
                                )}
                            </div>
                            {/* Hiển thị khung bình luận cho người dùng */}
                            <div>
                                <textarea value={newComment} onChange={handleCommentChange} />
                                <button onClick={handleCommentSubmit}>Gửi bình luận</button>
                            </div>
                        </>
                    )}
                </div>
            ))}
        </div>
    );
};

export default PostDetail;

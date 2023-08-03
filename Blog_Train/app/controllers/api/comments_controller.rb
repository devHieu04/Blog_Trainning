class Api::CommentsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy, :destroy_all]
    before_action :authenticate_user!, only: [:create, :update, :destroy]
  
    def index
      comments = Comment.all
      render json: comments, include: :user, status: :ok
    end
  
    def create
      comment = Comment.new(comment_params)
      comment.user = current_user
  
      if comment.save
        render json: comment_with_user(comment), status: :created
      else
        render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
        comment = Comment.find(params[:id])
      
        # Check if the current user has permission to delete the comment (can only delete their own comments or if they are an admin)
        if comment.user == current_user || current_user&.Admin?
          if comment.destroy
            render json: { message: 'Xoá bình luận thành công' }, status: :ok
          else
            render json: { message: 'Xoá không thành công' }, status: :unprocessable_entity
          end
        else
          render json: { error: 'Bạn không có quyền xoá bình luận này' }, status: :forbidden
        end
    end
      
    def destroy_all
        post_id = params[:id] # Lấy post_id từ params[:id]
        Comment.where(post_id: post_id).destroy_all # Xóa tất cả các comments có post_id tương ứng
        render json: { message: 'All comments deleted successfully' }, status: :ok
    rescue ActiveRecord::RecordNotFound
        render json: { error: 'Post not found' }, status: :not_found
    end
      
  
    def update
      comment = Comment.find(params[:id])
  
      # Kiểm tra xem người dùng hiện tại có quyền sửa bình luận không (chỉ được sửa bình luận của mình)
      if comment.user == current_user
        if comment.update(comment_params)
          render json: { message: 'Cập nhật bình luận thành công' }, status: :ok
        else
          render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { error: 'Bạn không có quyền sửa bình luận này' }, status: :forbidden
      end
    end
  
    private
  
    def comment_params
      params.require(:comment).permit(:content, :post_id)
    end
  
    def authenticate_user!
        token = request.headers['Authorization']&.split(' ')&.last
        if token
          decoded_token = JwtHandler.decode(token)
          user_id = decoded_token['user_id']
          @current_user = User.find_by(id: user_id)
      
          if @current_user
            # User is authenticated
            return
          else
            # User ID from the token is not valid
            render json: { error: 'Invalid user ID from token' }, status: :unauthorized
          end
        else
          # Token is missing
          render json: { error: 'Unauthorized: Token missing' }, status: :unauthorized
        end
      rescue JWT::DecodeError => e
        # Invalid token
        render json: { error: 'Invalid token' }, status: :unauthorized
    end
      
  
    def current_user
      @current_user
    end
  
    def comment_with_user(comment)
      # Hàm này sẽ trả về một hash chứa thông tin bình luận và thông tin người dùng của bình luận
      # để đảm bảo rằng ta có thông tin của người dùng hiện tại khi gửi response về frontend.
      {
        id: comment.id,
        content: comment.content,
        post_id: comment.post_id,
        user: {
          id: comment.user.id,
          username: comment.user.username
        }
      }
    end
end
  
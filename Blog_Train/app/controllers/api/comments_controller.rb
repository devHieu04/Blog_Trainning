class Api::CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy, :destroy_all]
  before_action :authenticate_user!, only: [:update, :destroy]

  def index
    comments = Comment.all
    render json: comments, include: :user, status: :ok
  end

  def create
    # Lấy user_id từ dữ liệu frontend (params[:comment][:user_id])
    user_id_from_frontend = params[:comment][:user_id]
  
    comment = Comment.new(comment_params)
  
    # Gán user_id từ frontend vào comment
    comment.user_id = user_id_from_frontend
  
    if comment.save
      render json: comment_with_user(comment), status: :created
    else
      render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  

  def destroy
    comment = Comment.find(params[:id])
    
    # Lấy user_id từ request DELETE
    user_id = params[:user_id].to_i
    user = User.find_by(id: user_id)
  
    # Check if the user_id from the request matches the user_id of the comment
    if comment.user_id == user_id || user.Admin?
      if comment.destroy
        render json: { message: 'Xoá bình luận thành công' }, status: :ok
      else
        render json: { message: 'Xoá không thành công' }, status: :unprocessable_entity
      end
    else
      render json: { error: "Không thể xoá bình luận của người khác" }, status: :forbidden
    end
  end
  

  def destroy_all
    post_id = params[:id]
    Comment.where(post_id: post_id).destroy_all
    render json: { message: 'All comments deleted successfully' }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Post not found' }, status: :not_found
  end

  def update
    comment = Comment.find(params[:id])
  
    # Get user_id from the request parameters
    user_id = params[:user_id].to_i
  
    
    if comment.user_id == user_id
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
    params.require(:comment).permit(:content, :post_id, :user_id)
  end

  def current_user
    @current_user
  end

  def authenticate_user!
    token = request.headers['Authorization']&.split(' ')&.last
    if token
      decoded_token = JwtHandler.decode(token)
      user_id = decoded_token['user_id']
      @current_user = User.find_by(id: user_id)
      @current_user = nil if @current_user.nil?
    else
      @current_user = nil
    end
     rescue JWT::DecodeError => e
    @current_user = nil
  end
  def comment_with_user(comment)
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

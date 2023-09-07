module Api
    class PostsController < ApplicationController
      skip_before_action :verify_authenticity_token
      # before_action :verify_admin_role, only: [:create, :update, :destroy]
  
      def create
        if @current_user && @current_user.Admin?
          @post = Post.new(post_params)
      
          if @post.save
            render json: { bannerUrl: @post.banner.url }, status: :created
          else
            render json: { error: 'Không thể tạo bài viết' }, status: :unprocessable_entity
          end
        else
          render json: { error: 'Không có quyền truy cập. Chỉ admin mới có thể tạo bài viết.' }, status: :forbidden
        end
      end
      
  
      def index
        @posts = Post.all
        render json: @posts, status: :ok
      end
  
      def destroy
        @post = Post.find(params[:id])
      
        if @current_user && (@current_user.Admin? || @current_user.id == @post.user_id)
          @post.destroy
          head :no_content
        else
          render json: { error: 'Không có quyền truy cập. Chỉ admin hoặc người tạo bài viết mới có thể xoá.' }, status: :forbidden
        end
      end
      

      
      def show
        @post = Post.find(params[:id])
        render json: @post, status: :ok
      end

      def update
        if @current_user && @current_user.Admin?
          @post = Post.find(params[:id])
      
          if @post.update(post_params)
            render json: { bannerUrl: @post.banner.url }, status: :ok
          else
            render json: { error: 'Không thể cập nhật bài viết' }, status: :unprocessable_entity
          end
        else
          render json: { error: 'Không có quyền truy cập. Chỉ Admin mới có thể cập nhật.' }, status: :forbidden
        end
      end
      
  
      def show_comments
        post = Post.find(params[:id])
        comments = post.comments
        render json: comments, include: :user, status: :ok
      end
      
      private
  
      def post_params
        params.permit(:title, :introduction, :content, :banner)
      end
      def verify_admin_role
        if @current_user && @current_user.role == 'Admin'
        else
          render json: { error: 'Permission denied' }, status: :forbidden
        end
      end
      def authenticate_user!
        if session[:user_id].present? && session[:user_role].present?
          user_id = session[:user_id]
          user_role = session[:user_role]
          @current_user = User.find_by(id: user_id)
          @current_user = nil if @current_user.nil?
        else
          @current_user = nil
        end
      end
    end
end
  
module Api
    class PostsController < ApplicationController
      skip_before_action :verify_authenticity_token
      # before_action :verify_admin_role, only: [:create, :update, :destroy]
  
      def create
        @post = Post.new(post_params)
  
        if @post.save
          render json: { bannerUrl: @post.banner.url }, status: :created
        else
          render json: { error: 'Failed to create post' }, status: :unprocessable_entity
        end
      end
  
      def index
        @posts = Post.all
        render json: @posts, status: :ok
      end
  
      def destroy
        @post = Post.find(params[:id])
        @post.destroy
        head :no_content
      end

      
      def show
        @post = Post.find(params[:id])
        render json: @post, status: :ok
      end

      def update
        @post = Post.find(params[:id])
        
        if @post.update(post_params)
          render json: { bannerUrl: @post.banner.url }, status: :ok
        else
          render json: { error: 'Failed to update post' }, status: :unprocessable_entity
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
          # Người dùng có vai trò là Admin, cho phép thực hiện hành động
        else
          render json: { error: 'Permission denied' }, status: :forbidden
        end
      end
    end
end
  
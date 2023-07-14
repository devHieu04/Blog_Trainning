module Api
    class PostsController < ApplicationController
      skip_before_action :verify_authenticity_token
  
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
      private
  
      def post_params
        params.permit(:title, :introduction, :content, :banner)
      end
    end
end
  
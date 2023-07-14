class Api::AdminsController < ApplicationController
    skip_before_action :verify_authenticity_token
    protect_from_forgery with: :null_session
  
    def create
      admin = Admin.new(admin_params)
      admin.password = params[:password] # Gán mật khẩu từ request body
      admin.password_confirmation = params[:password] # Gán xác nhận mật khẩu từ request body

  
      if admin.save
        render json: { message: 'Đăng ký thành công' }
      else
        render json: { errors: admin.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def login
        admin = Admin.find_by(username: params[:username])
    
        if admin&.authenticate(params[:password])
          # Đăng nhập thành công
          session[:admin_id] = admin.id # Lưu admin_id trong session
          render json: { message: 'Đăng nhập thành công', admin: admin }
        else
          # Đăng nhập thất bại
          render json: { message: 'Đăng nhập thất bại' }, status: :unauthorized
        end
    end

    def logout
        session[:admin_id] = nil 
        render json: { message: 'Đăng xuất thành công' }
    end
    private
  
    def admin_params
      params.require(:admin).permit(:username)
    end
end
  
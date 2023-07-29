class Api::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    users = User.all
    render json: users
  end

  def create
    user = User.new(user_params)
  
    if user.save
      render json: { message: 'Đăng ký thành công' }
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  

  def show
    user = User.find(params[:id])
    render json: user
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      render json: { message: 'Cập nhật thành công' }
    else
      puts user.errors.full_messages # In ra thông tin lỗi
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end
  

  def destroy
    user = User.find(params[:id])
    user.destroy
    render json: { message: 'Xoá thành công' }
  end

  def login
    user = User.find_by(username: params[:username])

    if user.nil? || !user.authenticate(params[:password])
      render json: { message: 'Tài khoản hoặc mật khẩu không đúng' }, status: :unauthorized
    else
      token = JwtHandler.encode({ user_id: user.id })
      render json: { message: 'Đăng nhập thành công', role: user.role, token: token }
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :phone, :role)
  end
 
end
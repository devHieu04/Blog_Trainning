class Api::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, except: [:show] 
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
    if @current_user && @current_user.Admin?
      user = User.find(params[:id])
  
      if user.update(user_params)
        render json: { message: 'Cập nhật thành công' }
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Không có quyền truy cập. Chỉ Admin mới có thể cập nhật.' }, status: :forbidden
    end
  end
  
  def destroy
    if @current_user && @current_user.Admin?
      user = User.find(params[:id])
      user.destroy
      render json: { message: 'Xoá thành công' }
    else
      render json: { error: 'Không có quyền truy cập. Chỉ Admin mới có thể xoá.' }, status: :forbidden
    end
  end
  

  def login
    user = User.find_by(username: params[:user][:username])
  
    if user.nil? || !user.authenticate(params[:user][:password])
      render json: { message: 'Tài khoản hoặc mật khẩu không đúng' }, status: :unauthorized
    else
      # Lưu user_id và role vào session
      session[:user_id] = user.id
      session[:user_role] = user.role
  
      render json: { message: 'Đăng nhập thành công', user_id: user.id, role: user.role }
    end
  end
  


  def logout
    if @current_user
      # Xoá người dùng hiện tại khỏi session
      session.delete(:user_id)
      session.delete(:user_role)
      @current_user = nil
      render json: { message: 'Đăng xuất thành công' }, status: :ok
    else
      render json: { error: 'User not found' }, status: :not_found
    end
  end
  
  
  def current
    if session[:user_id].present? && session[:user_role].present?
      user_id = session[:user_id]
      user_role = session[:user_role]
      render json: { user_id: user_id, role: user_role }, status: :ok
    else
      render json: { error: 'User not found in session' }, status: :not_found
    end
  end
  
  

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :phone, :role)
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

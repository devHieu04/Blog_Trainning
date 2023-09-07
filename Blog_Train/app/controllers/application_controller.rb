class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session
    protect_from_forgery with: :exception
    before_action :set_current_user
  
    def current_user
      if session[:user_id].present?
        user_id = session[:user_id]
        user = User.find_by(id: user_id)
        return user if user
      end
      nil
    end
    
    

  def decode_token(token)
    begin
      decoded = JwtHandler.decode(token)
      user = User.find(decoded[:user_id])
      return user
    rescue JWT::DecodeError
      return nil
    end
  end
  def authenticate_user!
    unless current_user
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
  

  def set_current_user
    if session[:user_id].present?
      user_id = session[:user_id]
      @current_user = User.find_by(id: user_id)
    else
      @current_user = nil
    end
  end 
end

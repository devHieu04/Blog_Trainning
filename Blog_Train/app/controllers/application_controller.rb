class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session
    protect_from_forgery with: :exception
    private

  def current_user
    token = request.headers['Authorization']&.split(' ')&.last
    if token
      decoded_token = JwtHandler.decode(token)
      user_id = decoded_token['user_id']
      @current_user ||= User.find_by(id: user_id)
    end
    @current_user
  rescue JWT::DecodeError => e
    nil
  end

  def authenticate_user!
    unless current_user
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include Devise::Controllers::Helpers

  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in @user, event: :authentication
      redirect_to '/homeuser'
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"].except(:extra) 
      redirect_to new_user_registration_url
    end
  end
   def google_oauth2
    user = User.from_google(from_google_params)

    if user.present?
      sign_out_all_scopes
      flash[:notice] = t 'devise.omniauth_callbacks.success', kind: 'Google'
      sign_in user, event: :authentication
      redirect_to '/homeuser'
    else
      flash[:alert] = t 'devise.omniauth_callbacks.failure', kind: 'Google', reason: "#{auth.info.email} is not authorized."
      redirect_to new_user_session_path
    end
   end
   def google_oauth2_logout
    @user = current_user
  
    if @user.present? && @user.provider == 'google_oauth2'
      @user.update(uid: nil, provider: nil) 
    end
  
    sign_out @user
    redirect_to root_path, notice: "Logged out from Google"
   end
   def from_google_params
     @from_google_params ||= {
       uid: auth.uid,
       email: auth.info.email
     }
   end

   def auth
     @auth ||= request.env['omniauth.auth']
   end

   def failure
    redirect_to root_path
   end
  
end

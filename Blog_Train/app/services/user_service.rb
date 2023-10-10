class UserService
      def self.from_google(auth)
        user = User.find_by(email: auth[:email])
      
        if user.present? 
          user
        else
          random_phone = '%010d' % rand(10**10)
      
          user = User.new(
            uid: auth[:uid],
            username: auth[:email],  
            provider: 'google',
            phone: random_phone,
            role: 'User',
            password: Devise.friendly_token[0, 20]
          ) 
      
          user.email = auth[:email]
          user.save!
      
          user
        end
      end
      
      def self.new_with_session params, session
        super.tap do |user|
          if data = session["devise.facebook_data"] &&
            session["devise.facebook_data"]["extra"]["raw_info"]
            user.email = data["email"] if user.email.blank?
          end
        end
      end
      def self.from_omniauth(auth)
        where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
          random_phone = '%010d' % rand(10**10) # Tạo số điện thoại ngẫu nhiên 10 chữ số
          user.email = auth.info.email
          user.phone = random_phone
          user.password = Devise.friendly_token[0,20]
          user.username = auth.info.name
          user.role = 'User'
        end
      end
end
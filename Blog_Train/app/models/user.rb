class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,:omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  def self.from_google(u)
    random_phone = '%010d' % rand(10**10) # Tạo số điện thoại ngẫu nhiên 10 chữ số
    create_with(uid: u[:uid], username: u[:email], provider: 'google',
                  phone: random_phone, role: 'User',
                  password: Devise.friendly_token[0, 20]).find_or_create_by!(email: u[:email])
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
  
     #has_secure_password
    has_many :comments, dependent: :destroy
    validates :username, presence: true
    validates :email, presence: true, uniqueness: true
    validates :phone, presence: true
    validates :role, presence: true # Thêm validation cho trường role
    enum role: { User: 'User', Admin: 'Admin' }
end
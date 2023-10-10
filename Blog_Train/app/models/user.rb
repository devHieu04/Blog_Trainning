class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,:omniauthable, omniauth_providers: [:facebook, :google_oauth2]
     #has_secure_password
    has_many :comments, dependent: :destroy
    validates :username, presence: true
    validates :email, presence: true, uniqueness: true
    validates :phone, presence: true
    validates :role, presence: true # Thêm validation cho trường role
    enum role: { User: 'User', Admin: 'Admin' }
    def self.from_google(u)
      UserService.from_google(u)
    end
    def self.new_with_session params, session
      UserService.new_with_session params, session
    end
    def self.from_omniauth(auth)
      UserService.from_omniauth(auth)
    end
end
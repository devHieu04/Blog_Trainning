class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
     #has_secure_password
    has_many :comments, dependent: :destroy
    validates :username, presence: true
    validates :email, presence: true, uniqueness: true
    validates :phone, presence: true
    validates :role, presence: true # Thêm validation cho trường role
    enum role: { User: 'User', Admin: 'Admin' }
end
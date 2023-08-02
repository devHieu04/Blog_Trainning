class User < ApplicationRecord
    has_many :comments
    has_secure_password
  
    validates :username, presence: true
    validates :email, presence: true, uniqueness: true
    validates :phone, presence: true
    validates :role, presence: true # Thêm validation cho trường role
end
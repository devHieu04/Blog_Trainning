# spec/factories/users.rb

FactoryBot.define do
    factory :user do
      username { 'john_doe' }
      email { 'john@example.com' }
      phone { '1234567890' }
      role { 'User' }
      password { 'password123' }
    end
  end
  
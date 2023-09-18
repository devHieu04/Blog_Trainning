# spec/factories/users.rb

FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "user#{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    phone { '1234567890' }
    role { 'User' }
    password { 'password123' }
  end
end

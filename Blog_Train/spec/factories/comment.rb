# spec/factories/comment.rb

FactoryBot.define do
    factory :comment do
      content { Faker::Lorem.sentence }
      
      # Khi tạo một comment, nó sẽ được gán cho một user và một post ngẫu nhiên.
      user { association :user }
      post { association :post }
    end
  end
  
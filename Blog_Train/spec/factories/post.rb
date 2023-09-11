# spec/factories/post.rb

FactoryBot.define do
    factory :post do
      title { "Example Post" }
      content { "This is an example post content." }
  
      # Định nghĩa một factory có tên là :post_with_images_folder để tạo bài viết
      # và tạo một thư mục images liên quan đến bài viết đó.
      factory :post_with_images_folder do
        after(:create) do |post|
          images_folder_path = Rails.root.join("public/uploads/post/#{post.id}")
          FileUtils.mkdir_p(images_folder_path)
        end
      end
    end
  end
  
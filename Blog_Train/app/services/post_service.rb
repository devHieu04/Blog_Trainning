class PostService 
    def remove_images_folder
        folder_path = Rails.root.join("public/uploads/post/#{id}")
        FileUtils.remove_dir(folder_path, force: true)
    end
end
class Post < ApplicationRecord
    mount_uploader :banner, BannerUploader
    before_destroy :remove_images_folder
    has_many :comments, dependent: :destroy
    def remove_images_folder
      PostService.remove_images_folder(id)
    end
end
  
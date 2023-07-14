class Post < ApplicationRecord
    mount_uploader :banner, BannerUploader
end
  
class Category < ApplicationRecord
  include ImageUploader::Attachment(:image)
  has_many :category_photos
  has_many :photos, through: :category_photos
end

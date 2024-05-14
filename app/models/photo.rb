class Photo < ApplicationRecord
  include ImageUploader::Attachment(:image)
  has_many :category_photos, dependent: :destroy

  has_many :categories, through: :category_photos
end

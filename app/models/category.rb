class Category < ApplicationRecord
  include ImageUploader::Attachment(:image)
  has_and_belongs_to_many :photos
end

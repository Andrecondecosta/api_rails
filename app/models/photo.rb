class Photo < ApplicationRecord
  include ImageUploader::Attachment(:image)
  has_and_belongs_to_many :category
end

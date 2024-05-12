class Article < ApplicationRecord
  include ImageUploader::Attachment(:image)
end

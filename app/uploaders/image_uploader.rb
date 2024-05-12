class ImageUploader < Shrine
  Attacher.validate do
    validate_max_size 5*1024*1024, message: "is too large (max is 5 MB)"
    validate_mime_type_inclusion ['image/jpeg', 'image/png', 'image/webp']
  end
end

require "cloudinary"
require "shrine/storage/cloudinary"

Cloudinary.config(
  cloud_name: ENV["CLOUDINARY_CLOUD_NAME"],
  api_key:    ENV["CLOUDINARY_API_KEY"],
  api_secret: ENV["CLOUDINARY_API_SECRET"],
)

Shrine.storages = {
  cache: Shrine::Storage::Cloudinary.new(prefix: "cdphotos/cache"), # for direct uploads
  store: Shrine::Storage::Cloudinary.new(prefix: "cdphotos")
}

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data # for retaining the cached file across form redisplays
Shrine.plugin :restore_cached_data # re-extract metadata when attaching a cached file
Shrine.plugin :validation_helpers # for validating attachment metadata
Shrine.plugin :validation

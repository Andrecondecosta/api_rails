module Api
  module V1

class PhotosController < ApplicationController
  before_action :set_photo, only: %i[ show update destroy ]


  # GET /photos
  def index
    @photos = Photo.all

    render json: @photos
  end

  # GET /photos/1
  def show
    render json: @photo
  end

  # POST /photos
  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      image = params[:photo][:image]
      result = Cloudinary::Uploader.upload(image.path) if image
      @photo.update(image_data: result['secure_url'])

      render json: @photo, status: :created, location: @photo
    else
      render json: @photo.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /photos/1
  def update
    if @photo.update(photo_params)
      if params[:photo][:image]
        image = params[:photo][:image]
        result = Cloudinary::Uploader.upload(image.path)
        @photo.update(image_data: result['secure_url'])
      end
      if params[:photo][:category_id]
        @category = Category.find(params[:photo][:category_id])
        @category.photos << @photo unless @category.photos.include?(@photo)
      end

      render json: @photo
    else
      render json: @photo.errors, status: :unprocessable_entity
    end
  end

  # DELETE /photos/1
  def destroy
    public_id = File.basename(@photo.image_data, File.extname(@photo.image_data))
    Cloudinary::Uploader.destroy(public_id)
    @photo.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      begin
        if params[:category_id] && params[:photo_id]
          @category = Category.find(params[:category_id])
          @photo = @category.photos.find(params[:photo_id])
        else
          @photo = Photo.find(params[:id])
        end
      rescue ActiveRecord::RecordNotFound => e
        render json: { error: e.message }, status: :not_found
      end
    end

    # Only allow a list of trusted parameters through.
    def photo_params
      params.require(:photo).permit(:title, :image)
    end


end
end
end

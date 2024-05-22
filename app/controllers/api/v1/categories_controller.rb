module Api
  module V1

class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show update destroy ]

  # GET /categories
  def index
    @categories = Category.all

    render json: @categories
  end

  # GET /categories/1
  def show
    render json: @category
  end

  # POST /categories
  def create
    @category = Category.new(category_params)

    if @category.save
      image = params[:category][:image]
      result = Cloudinary::Uploader.upload(image.path)
      @category.update(image_data: result['secure_url'])

      render json: @category, status: :created, location: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /categories/1
  def update
    if @category.update(category_params)
      if params[:category][:image]
        image = params[:category][:image]
        result = Cloudinary::Uploader.upload(image.path)
        @category.update(image_data: result['secure_url'])
      end

      if params[:category][:photo_ids]
        new_photos = Photo.find(params[:category][:photo_ids])
        new_photos.each do |new_photo|
          @category.photos << new_photo unless @category.photos.include?(new_photo)
        end
      end
      render json: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # DELETE /categories/1
    # DELETE /categories/1
    def destroy
      if @category.image_data.present?
        public_id = @category.image_data.split('/').last.split('.').first
        Cloudinary::Uploader.destroy(public_id)
      end
      @category.category_photos.destroy_all
      @category.destroy!
      render json: { message: 'Category deleted successfully' }, status: :ok
      head :no_content
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name, :image)
    end
end
end
end

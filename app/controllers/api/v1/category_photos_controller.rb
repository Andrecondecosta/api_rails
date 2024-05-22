module Api
  module V1

    class CategoryPhotosController < ApplicationController

      def index
        @category_photos = CategoryPhoto.all
render json: @category_photos.as_json(include: { photo: { only: [:id, :title, :image_data] }, category: { only: [:id, :name] } })
      end

      # POST /api/v1/category_photos
      def create
        category = Category.find(params[:category_id])
        created_photos = []

        if params[:image_ids].present?
          ActiveRecord::Base.transaction do
            params[:image_ids].each do |photo_id|
              category_photo = CategoryPhoto.create!(category_id: category.id, photo_id: photo_id)
              created_photos << category_photo
            end
          end
        else
          render json: { error: 'image_ids is missing' }, status: :unprocessable_entity
          return
        end

        render json: {
  id: created_photos.first.category_id,
  category_photos: created_photos.map do |cp|
    {
      id: cp.id,
      photo: {
        id: cp.photo_id,
        created_at: cp.created_at,
        updated_at: cp.updated_at
      }
    }
  end
}, status: :created

      rescue ActiveRecord::RecordInvalid => e
        render json: { error: e.message }, status: :unprocessable_entity
      end
      # DELETE /api/v1/category_photos/1
      def destroy
        begin
          @category_photo = CategoryPhoto.find(params[:id])

          if @category_photo.destroy
            head :no_content
          else
            render json: { error: 'Failed to delete category photo' }, status: :internal_server_error
          end
        rescue ActiveRecord::RecordNotFound
          render json: { error: 'CategoryPhoto not found' }, status: :not_found
        end
      end

      private

      def category_photo_params
  params.require(:category_photo).permit(:category_id, photo_ids: [])
end
    end

  end
end

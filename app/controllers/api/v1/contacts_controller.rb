module Api
  module V1
    class ContactsController < ApplicationController
      before_action :set_contact, only: %i[show update destroy]

      # GET /contacts
      def index
        @contacts = Contact.all
        render json: @contacts.map { |contact| contact_with_photos(contact) }
      end

      # GET /contacts/1
      def show
        render json: contact_with_photos(@contact)
      end

      # POST /contacts
      def create
        @contact = Contact.new(contact_params)

        if @contact.save
          render json: contact_with_photos(@contact), status: :created
        else
          render json: @contact.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /contacts/1
      def update
        if @contact.update(contact_params)
          render json: contact_with_photos(@contact)
        else
          render json: @contact.errors, status: :unprocessable_entity
        end
      end

      # DELETE /contacts/1
      def destroy
        @contact.destroy!
        head :no_content
      end

      private

      def set_contact
        @contact = Contact.find(params[:id])
      end

      def contact_params
        params.require(:contact).permit(:first_name, :last_name, :email, :subject, :message, photo_ids: [])
      end

      def contact_with_photos(contact)
        photo_ids = contact.photo_ids.is_a?(String) ? JSON.parse(contact.photo_ids) : contact.photo_ids
        puts "Photo IDs: #{photo_ids.inspect}"
        category_photos = CategoryPhoto.where(id: photo_ids)
        puts "CategoryPhotos: #{category_photos.inspect}"
        photos = Photo.where(id: category_photos.pluck(:photo_id))
        puts "Photos: #{photos.inspect}"
        photos_data = photos.map do |photo|
          {
            id: photo.id,
            title: photo.title,
            image_data: photo.image_data
          }
        end
        puts "Photos Data: #{photos_data.inspect}"
        contact.attributes.merge(photos: photos_data)
      end
    end
  end
end

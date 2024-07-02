class AddPhotoIdsToContacts < ActiveRecord::Migration[7.1]
  def change
    add_column :contacts, :photo_ids, :text
  end
end

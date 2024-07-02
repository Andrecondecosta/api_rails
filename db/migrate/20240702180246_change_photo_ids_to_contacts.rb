class ChangePhotoIdsToContacts < ActiveRecord::Migration[6.0]
  def change
    remove_column :contacts, :photo_ids, :text
    add_column :contacts, :photo_ids, :jsonb, default: []
  end
end

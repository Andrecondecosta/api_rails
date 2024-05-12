class CreateCategoriesPhotosJoinTable < ActiveRecord::Migration[7.1]
  def change
    create_table :categories_photos, id: false do |t|
      t.bigint :category_id
      t.bigint :photo_id
    end

    add_index :categories_photos, :category_id
    add_index :categories_photos, :photo_id
  end
end

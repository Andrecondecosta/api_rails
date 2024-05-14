class DropCategoriesPhotos < ActiveRecord::Migration[7.1]
  def up
    drop_table :categories_photos
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

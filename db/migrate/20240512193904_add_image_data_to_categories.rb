class AddImageDataToCategories < ActiveRecord::Migration[7.1]
  def change
    add_column :categories, :image_data, :text
  end
end

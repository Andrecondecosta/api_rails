class DropContacts < ActiveRecord::Migration[6.0]
  def up
    if table_exists?(:contacts)
      drop_table :contacts
    end
  end

  def down
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.text :message

      t.timestamps
    end
  end
end

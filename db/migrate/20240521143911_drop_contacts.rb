class DropContacts < ActiveRecord::Migration[6.0]
  def up
    drop_table :contacts
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

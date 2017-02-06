class DropTicketsExtendedAttributes < ActiveRecord::Migration[5.0]
  def up
    remove_column :tickets, :extended_attributes if column_exists?(:tickets, :extended_attributes)
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

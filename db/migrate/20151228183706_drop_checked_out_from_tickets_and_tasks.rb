class DropCheckedOutFromTicketsAndTasks < ActiveRecord::Migration
  def up
    remove_column :tasks, :checked_out_at if column_exists?(:tasks, :checked_out_at)
    remove_column :tasks, :checked_out_by_id if column_exists?(:tasks, :checked_out_by_id)
    remove_column :tickets, :checked_out_at if column_exists?(:tickets, :checked_out_at)
    remove_column :tickets, :checked_out_by_id if column_exists?(:tickets, :checked_out_by_id)
  end

  def down
    add_column :tasks, :checked_out_at, :timestamp
    add_column :tasks, :checked_out_by_id, :integer
    add_column :tickets, :checked_out_at, :timestampd
    add_column :tickets, :checked_out_by_id, :integer
  end
end

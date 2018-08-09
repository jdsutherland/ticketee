class AddArchivedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :archived_at, :timestamp
  end
end

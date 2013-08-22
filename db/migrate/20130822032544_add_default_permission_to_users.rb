class AddDefaultPermissionToUsers < ActiveRecord::Migration
  def up
    change_column :users, :permission, :integer, :default => 0
end

def down
     change_column :users, :permission, :integer, :default => nil
end
end

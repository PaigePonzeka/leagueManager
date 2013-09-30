class AddDirectionsToPark < ActiveRecord::Migration
  def up
    add_column :parks, :directions_by_car, :text
    add_column :parks, :directions_by_transit, :text
  end

  def down
    remove_column :parks, :directions_by_car, :text
    remove_column :parks, :directions_by_transit, :text
  end
end

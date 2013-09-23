class AddDivisionToGames < ActiveRecord::Migration
   def up
    add_column :games, :division_id, :integer
  end

  def down
    remove_column :games, :division_id, :integer
  end
end

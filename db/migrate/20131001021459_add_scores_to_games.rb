class AddScoresToGames < ActiveRecord::Migration
  def up
    add_column :games, :home_team_score, :integer
    add_column :games, :visiting_team_score, :integer
  end

  def down
    remove_column :games, :home_team_score, :integer
    remove_column :games, :visiting_team_score, :integer
  end
end

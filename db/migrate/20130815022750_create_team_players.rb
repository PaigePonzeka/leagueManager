class CreateTeamPlayers < ActiveRecord::Migration
  def change
    create_table :team_players do |t|
      t.integer :user_id
      t.integer :team_id

      t.timestamps
    end
  end
end

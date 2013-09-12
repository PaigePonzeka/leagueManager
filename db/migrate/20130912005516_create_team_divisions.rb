class CreateTeamDivisions < ActiveRecord::Migration
  def change
    create_table :team_divisions do |t|
      t.integer :team_id
      t.integer :division_id

      t.timestamps
    end
  end
end

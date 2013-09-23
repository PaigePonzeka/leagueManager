class Game < ActiveRecord::Base
  attr_accessible :field_id, :home_team_id, :season_id, :start, :visiting_team_id, :division_id

  belongs_to :season
  belongs_to :field
  belongs_to :division
  belongs_to :home_team, :class_name => "Team"
  belongs_to :away_team, :class_name => "Team"

  #, :class_name => "Game", :foreign_key => 'home_team_id'
  #has_one :home_team, :class_name => "Team", :foreign_key => "id"
  #has_one :visiting_team, :class_name => "Team", :foreign_key => "id"
  #has_one :team,:class_name => "visiting_team", :foreign_key => "visiting_team_id"
end

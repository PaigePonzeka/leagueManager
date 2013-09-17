class Game < ActiveRecord::Base
  attr_accessible :field_id, :home_team_id, :season_id, :start, :visiting_team_id

  has_one :season
  has_one :field
  has_one :team, :foreign_key => "home_team_id"
  has_one :team, :foreign_key => "visiting_team_id"
end

class Game < ActiveRecord::Base
  attr_accessible :field_id, :home_team_id, :season_id, :start, :visiting_team_id, :division_id, :home_team_score, :visiting_team_score

  validates :home_team_id, presence: true
  validates :visiting_team_id, presence: true
  # TODO - need to validate that home team != visiting team
  validates :season, presence: true
  validates :division_id, presence: true

  belongs_to :season
  belongs_to :field
  belongs_to :division
  belongs_to :home_team, :class_name => "Team"
  belongs_to :visiting_team, :class_name => "Team"

end

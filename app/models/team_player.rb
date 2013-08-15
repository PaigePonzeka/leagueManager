class TeamPlayer < ActiveRecord::Base
  attr_accessible :player_id, :team_id
  belongs_to :player
  belongs_to :team
end

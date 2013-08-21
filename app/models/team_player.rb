class TeamPlayer < ActiveRecord::Base
  attr_accessible :user_id, :team_id
  belongs_to :user
  belongs_to :team
end

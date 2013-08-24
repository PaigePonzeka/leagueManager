class TeamManager < ActiveRecord::Base
  attr_accessible :team_id, :user_id

  belongs_to :user
  belongs_to :team
end

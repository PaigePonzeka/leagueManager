class TeamPlayer < ActiveRecord::Base
  attr_accessible :user_id, :team_id
  belongs_to :user
  belongs_to :team

  validates_uniqueness_of :team_id, :scope => :user_id
end

class Team < ActiveRecord::Base
  attr_accessible :name
  has_many :users, :through => :team_players
end

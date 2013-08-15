class Player < ActiveRecord::Base
  attr_accessible :name
  has_one :team
  has_many :teams, :through => :team_players

end

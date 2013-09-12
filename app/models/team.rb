class Team < ActiveRecord::Base
  attr_accessible :name, :user_ids

  has_many :team_players
  has_many :team_managers
  has_many :team_divisions
  has_many :users, :through => :team_players
  has_many :users, :through => :team_managers
  has_many :divisions, :through => :team_divisions

  


end

class Division < ActiveRecord::Base
  attr_accessible :name, :team_ids

  has_many :team_divisions
  has_many :teams, :through => :team_divisions
end

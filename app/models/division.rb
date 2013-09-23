class Division < ActiveRecord::Base
  attr_accessible :name, :team_ids

  has_many :team_divisions
  has_many :teams, :through => :team_divisions

  has_many :division_reps
  has_many :users, :through => :division_reps

  has_one :game
end

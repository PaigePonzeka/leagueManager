class Season < ActiveRecord::Base
  attr_accessible :end, :name, :start
  has_one :game

  validates :start, presence: true
  validates :end, presence: true
  validates :name, presence: true
end

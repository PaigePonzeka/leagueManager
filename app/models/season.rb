class Season < ActiveRecord::Base
  attr_accessible :end_date, :name, :start_date
  has_one :game

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :name, presence: true
end

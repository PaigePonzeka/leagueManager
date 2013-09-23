class Season < ActiveRecord::Base
  attr_accessible :end, :name, :start
  has_one :game
end

class Park < ActiveRecord::Base
  attr_accessible :name, :url, :directions_by_transit, :directions_by_car

  has_one :field
end

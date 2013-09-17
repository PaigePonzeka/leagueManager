class Park < ActiveRecord::Base
  attr_accessible :name, :url

  has_one :field
end

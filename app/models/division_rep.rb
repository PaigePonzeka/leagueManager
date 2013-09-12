class DivisionRep < ActiveRecord::Base
  attr_accessible :division_id, :user_id

  belongs_to :user
  belongs_to :division
end

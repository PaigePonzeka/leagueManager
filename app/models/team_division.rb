class TeamDivision < ActiveRecord::Base
  attr_accessible :division_id, :team_id

  belongs_to :team
  belongs_to :division

end

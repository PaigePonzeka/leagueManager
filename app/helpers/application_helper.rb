module ApplicationHelper
    def name(user)
      "#{user.first_name} #{user.last_name}"
    end

    def user_is_team_manager(team)
      teams = TeamManager.where(:user_id => current_user.id, :team_id => team.id)
      teams.length > 0
  end

  def get_team_by_id(team_id)
    team = Team.where(:id => team_id).first
    team
  end

  def format_date(date)
    if date
      date.strftime("%-m/%-d/%y %l:%M %p")
    else
      "TBA"
    end
  end

def active_season
  get_active_season
end
  
end

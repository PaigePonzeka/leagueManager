module ApplicationHelper
    def name(user)
      "#{user.first_name} #{user.last_name}"
    end

    def user_is_team_manager(team)
      teams = TeamManager.where(:user_id => current_user.id, :team_id => team.id)
      teams.length > 0
  end
end

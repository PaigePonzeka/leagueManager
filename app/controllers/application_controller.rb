class ApplicationController < ActionController::Base
   protect_from_forgery with: :exception
  include SessionsHelper


  def require_login
     unless signed_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to signin_path
    end
  end

  def require_admin
     unless is_admin?
      flash[:error] = "Access Denied"
      redirect_to root_path
    end
  end

  def require_admin_or_user
    unless is_admin?
      flash[:error] = "Access Denied"
      redirect_to root_path
    end
  end

  def require_admin_or_division_rep
    unless is_admin? || is_division_rep?
      flash[:error] = "Access Denied"
      redirect_to root_path
    end
  end

  
  def get_team_games(team_id)
    Game.where("home_team_id = ? OR visiting_team_id = ?", team_id, team_id).order('start ASC').all
  end

  def get_division_games(division_id)
    Game.where("division_id = ?", division_id).order('start ASC').all
  end

  def get_teams_by_division(division_id)
     team_divisions = TeamDivision.where(:division_id => division_id)
     team_divisions
  end

  
end

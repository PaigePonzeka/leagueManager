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
    games = Game.where("home_team_id = ? OR visiting_team_id = ?", team_id, team_id).order('start ASC')
    puts "Get_team_games" 
    puts games
    return games
  end

  def get_team_game_by_season(team_id, season_id)
    games = get_team_games(team_id).where('season_id = ?', season_id).order('start ASC')
    return games
  end

  def get_future_team_games(team_id, season_id)
    games = get_team_games(team_id).where("start >= ?", Date.today).limit(10)
    return games
  end

  def get_division_games(division_id)
    Game.where("division_id = ?", division_id).order('start ASC').all
  end

  def get_teams_by_division(division_id)
     team_divisions = TeamDivision.where(:division_id => division_id)
     team_divisions
  end

    # returns the season the league is currently in
  # active = season which start / end date falls between current date
  # if no season is "active" then the active season is the upcoming season (within one weeks)
  # otherwise the "active" Season was the past season
  def get_active_season
    today = Date.today
    season = Season.where('start_date < ? AND end_date > ?', today, today).first
    if season.nil?
      season = Season.where('start_date > ? AND start_date < ?', today, (today + 7.days)).first
      if season.nil?
        season = Season.where('end_date > ?', today).last
      end  
    end
    return season
  end
end

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

   def get_future_division_games(division_id)
    games = Game.where("start >= ? AND division_id = ?", Date.today, division_id).order("start ASC").limit(10)
    return games
  end

  def get_games_by_season(season_id)
    Game.where("season_id = ?", season_id).order('start ASC').all
  end

  def get_division_games(division_id)
    Game.where("division_id = ?", division_id).order('start ASC').all
  end

  def get_teams_by_division(division_id)
     team_divisions = TeamDivision.where(:division_id => division_id)
     team_divisions
  end

  def get_games_by_division_by_season(division_id, season: get_active_season)
    Game.where("division_id = ? AND season_id = ?", division_id, season.id).order('start ASC').all
  end

  # renders standings from a set of games
  def get_standings(games)
    teams = Hash.new
    games.each do |game|
      division_id = game.division_id
      home_team = game.home_team
      away_team = game.visiting_team
      if(teams[home_team.name].nil?)
        teams[home_team.name] = {:win => 0, :loss => 0, :tie => 0, :point=> 0}
      end

      if(teams[away_team.name].nil?)
         teams[away_team.name] = {:win => 0, :loss => 0, :tie => 0, :point => 0}
      end
      if(game.home_team_score && game.visiting_team_score)
        if(game.home_team_score > game.visiting_team_score)
          # home team won
          teams[home_team.name][:win] += 1
          teams[home_team.name][:point] += 5
          # visiting team loss
          teams[away_team.name][:loss] += 1
        elsif(game.home_team_score < game.visiting_team_score)
          # home team loss
          teams[home_team.name][:loss] += 1
          #visiting team won
          teams[away_team.name][:win] += 1
          teams[away_team.name][:point] += 5
        else
          # tie game
          teams[home_team.name][:tie] += 1
          teams[home_team.name][:point] += 1
          teams[away_team.name][:tie] += 1
          teams[away_team.name][:point] += 1
        end
      end
    end
    teams.each do |team, value|
      puts team
      total_games = value[:win] + value[:loss] + value[:tie]
      win_percentage = value[:win]/total_games.to_f
      value[:percentage] = win_percentage
    end
    teams_sorted = teams.sort_by{ |k, v| v[:point]}.reverse
    return teams_sorted
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

class StaticPagesController < ApplicationController
  def home
    @active_season = get_active_season
    division_id = 1
    @standings_by_division = Array.new
    if signed_in? && !is_admin?
        # show only team games or manager games
        teamPlayer = TeamPlayer.where(user_id: current_user.id).first
        teamManager = TeamManager.where(user_id: current_user.id).first
        divisionRep =  DivisionRep.where(user_id: current_user.id).first

        if divisionRep
          @games =  get_future_division_games(divisionRep.division_id)
           division = divisionRep.division
        elsif teamPlayer
          @games = get_team_games(teamPlayer.team_id)
          # TODO(this is going to break later)
          teamDivision = TeamDivision.where(team_id: teamPlayer.team_id).first()
          division = teamDivision.division
        elsif teamManager
          @games = get_future_team_games(teamManager.team_id, get_active_season.id)
          # TODO(this is going to break later)
          teamDivision = TeamDivision.where(team_id: teamManager.team_id).first()
          division = teamDivision.division
        @standings_by_division.push({:division => {:name => division.name},:teams => get_standings(get_games_by_division_by_season(division.id))})
      end
    else # user isn't signed in
       @standings_by_division = get_all_division_standings
               # show all games
        @games = Game.where("start >= ?",Date.today).order("start ASC").limit(10).all

    end
      @season = get_active_season
      
  end

  def get_all_division_standings
    standings_by_division = Array.new
    divisions = Division.all
    divisions.each do |division|
      standings_by_division.push({:division => {:name => division.name},:teams => get_standings(get_games_by_division_by_season(division.id))})
    end
    standings_by_division
  end

  def help
  end
end

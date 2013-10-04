class StaticPagesController < ApplicationController
  def home
    @active_season = get_active_season
    if signed_in?

      if is_admin?
        # show all games
        #Date.today.day
        @games = Game.where("start >= ?",Date.today).order("start ASC").limit(10).all
      else
        # show only team games or manager games
        teamPlayer = TeamPlayer.where(user_id: current_user.id).first
        teamManager = TeamManager.where(user_id: current_user.id).first
        divisionRep =  DivisionRep.where(user_id: current_user.id).first
        if divisionRep
          @games = get_division_games(divisionRep.division_id)
        elsif teamPlayer
          @games = get_team_games(teamPlayer.team_id)
        elsif teamManager
          @games = get_future_team_games(teamManager.team_id, get_active_season.id)
        end  
      end
    end

  end

  def help
  end
end

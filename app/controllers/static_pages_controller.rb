class StaticPagesController < ApplicationController
  def home
    if signed_in?
      if is_admin?
        # show all games
        @games = Game.order("start ASC").limit(10).all
      else
        # show only team games or manager games
        teamPlayer = TeamPlayer.where(user_id: current_user.id).first
        teamManager = TeamManager.where(user_id: current_user.id).first
        puts teamPlayer.inspect
        puts teamManager.inspect
        puts "Falallalala"
        if teamPlayer
          @games = Game..where("home_team_id = ? OR visiting_team_id = ?", teamPlayer.team_id, teamPlayer.id).all
        elsif teamManager
          @games = Game.where("home_team_id = ? OR visiting_team_id = ?", teamManager.team_id, teamManager.id).all
        end  
      end
    end

  end

  def help
  end
end

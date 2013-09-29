class TeamsController < ApplicationController
  before_filter :require_admin_or_correct_manager, :only => [:edit, :update]
  before_filter :require_login, :only => [ :show]
  before_filter :require_admin, :only  => [:new, :destroy]
  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @teams }
    end
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    @team = Team.find(params[:id])
    @players = TeamPlayer.where(:team_id => params[:id])
    @games = get_team_games(@team.id)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @team }
    end
  end

  # GET /teams/new
  # GET /teams/new.json
  def new
    @team = Team.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @team }
    end
  end

  # GET /teams/1/edit
  def edit
    @team = Team.find(params[:id])
    @players = TeamPlayer.where(:team_id => params[:id])
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(params[:team])

    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render json: @team, status: :created, location: @team }
      else
        format.html { render action: "new" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /teams/1
  # PUT /teams/1.json
  def update
    @team = Team.find(params[:id])

    respond_to do |format|
      if @team.update_attributes(params[:team])
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team = Team.find(params[:id])
    @team.destroy

    respond_to do |format|
      format.html { redirect_to teams_url }
      format.json { head :no_content }
    end
  end

  def get_teams_by_division
    team_divisions = TeamDivision.where(:division_id => params[:division_id])
    puts "Test"
    teams = []

    team_divisions.each do |t|
      teams.push(t.team)
    end
    puts teams.inspect
    respond_to do |format|
          format.json { render json: teams.to_json}
      end
  end

   def require_admin_or_correct_manager
      @team = Team.find(params[:id])
       redirect_to(root_url) unless  (user_is_team_manager(@team) || is_admin?)
     end

      def user_is_team_manager(team)
      teams = TeamManager.where(:user_id => current_user.id, :team_id => team.id)
      teams.length > 0
  end
end

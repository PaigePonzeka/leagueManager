class TeamPlayersController < ApplicationController
  # GET /team_players
  # GET /team_players.json
  def index
    @team_players = TeamPlayer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @team_players }
    end
  end

  # GET /team_players/1
  # GET /team_players/1.json
  def show
    @team_player = TeamPlayer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @team_player }
    end
  end

  # GET /team_players/new
  # GET /team_players/new.json
  def new
    @team_player = TeamPlayer.new
    @players = User.all
    @teams = Team.all
    respond_to do |format|
      format.html # new.html.erb
      format.js   {redirect_to :back}
      format.json { render json: @team_player }
    end
  end

  # GET /team_players/1/edit
  def edit
    @team_player = TeamPlayer.find(params[:id])
  end

  # POST /team_players
  # POST /team_players.json
  def create
    @team_player = TeamPlayer.new(params[:team_player])

    respond_to do |format|
      if @team_player.save
        flash[:notice] = "Player Created" 
        format.html { redirect_to @team_player, notice: 'Team player was successfully created.' }
        format.js { render :layout=>false }
        format.json {redirect_to :back}
        #format.json { render json: @team_player, status: :created, location: @team_player }
        
      else
       format.html { render action: "new" }
       format.json { render json: @team_player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /team_players/1
  # PUT /team_players/1.json
  def update
    @team_player = TeamPlayer.find(params[:id])

    respond_to do |format|
      if @team_player.update_attributes(params[:team_player])
        format.html { redirect_to @team_player, notice: 'Team player was successfully updated.' }
        format.js   {redirect_to :back}
        format.json { head :no_content}
      else
        format.html { render action: "edit" }
        format.json { render json: @team_player.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /team_players/1
  # DELETE /team_players/1.json
  def destroy
    @team_player = TeamPlayer.find(params[:id])
    @team_player.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end
end

class GamesController < ApplicationController
  before_filter :require_admin, :only  => [:new, :destroy, :edit, :update]
  # GET /games
  # GET /games.json
  def index
    @games = Game.order('division_id DESC').all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @games }
    end
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @game = Game.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @game }
    end
  end

  # GET /games/new
  # GET /games/new.json
  def new
    @game = Game.new
    @divisions = Division.find(:all)
    @fields = Field.find(:all)
    @seasons = Season.find(:all)
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @game }
    end
  end

  def schedule
    @team = Team.find_by_id(params[:team_id])
    @games = get_team_games(@team.id)
    respond_to do |format|
      format.html
    end
  end

  # GET /games/1/edit
  def edit
    @game = Game.find(params[:id])
    @divisions = Division.find(:all)
    @fields = Field.find(:all)
    @seasons = Season.find(:all)
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(params[:game])
     @divisions = Division.find(:all)
    @fields = Field.find(:all)
    @seasons = Season.find(:all)
    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render json: @game, status: :created, location: @game }
      else
        format.html { render action: "new" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /games/1
  # PUT /games/1.json
  def update
    @game = Game.find(params[:id])

    respond_to do |format|
      if @game.update_attributes(params[:game])
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    respond_to do |format|
      format.html { redirect_to games_url }
      format.json { head :no_content }
    end
  end
end

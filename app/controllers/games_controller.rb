class GamesController < ApplicationController
  before_filter :require_admin_or_division_rep, :only  => [:new, :destroy, :edit, :update]
  # GET /games
  # GET /games.json
  def index
    @games = Game.order('division_id DESC').order('start ASC').all

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
    @fields = Field.find(:all)
    @seasons = Season.find(:all)
    
    if is_division_rep?
      puts "divison rep"
      division = get_reps_division.first
      #puts division.division_id
      @divisions = Division.where( :id =>division.division_id) 
      @current_division_id = division.division_id
    else
      @divisions = Division.find(:all)
      @current_division_id = @game.division_id
    end
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
    @current_division = @game.division_id
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

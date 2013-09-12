class TeamDivisionsController < ApplicationController
  # GET /team_divisions
  # GET /team_divisions.json
  def index
    @team_divisions = TeamDivision.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @team_divisions }
    end
  end

  # GET /team_divisions/1
  # GET /team_divisions/1.json
  def show
    @team_division = TeamDivision.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @team_division }
    end
  end

  # GET /team_divisions/new
  # GET /team_divisions/new.json
  def new
    @team_division = TeamDivision.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @team_division }
    end
  end

  # GET /team_divisions/1/edit
  def edit
    @team_division = TeamDivision.find(params[:id])
  end

  # POST /team_divisions
  # POST /team_divisions.json
  def create
    @team_division = TeamDivision.new(params[:team_division])

    respond_to do |format|
      if @team_division.save
        format.html { redirect_to @team_division, notice: 'Team division was successfully created.' }
        format.js { render :layout=>false }
        format.json { render json: @team_division, status: :created, location: @team_division }
      else
        format.html { render action: "new" }
        format.json { render json: @team_division.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /team_divisions/1
  # PUT /team_divisions/1.json
  def update
    @team_division = TeamDivision.find(params[:id])
    respond_to do |format|
      if @team_division.update_attributes(params[:team_division])
        format.html { redirect_to @team_division, notice: 'Team division was successfully updated.' }
        format.js   {redirect_to :back}
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @team_division.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /team_divisions/1
  # DELETE /team_divisions/1.json
  def destroy
    @team_division = TeamDivision.find(params[:id])
    @team_division.destroy

    respond_to do |format|
      format.html { redirect_to team_divisions_url }
      format.json { head :no_content }
    end
  end
end

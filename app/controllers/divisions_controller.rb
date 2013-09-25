class DivisionsController < ApplicationController
  before_filter :require_admin, :only  => [:new, :destroy, :edit, :update]
  # GET /divisions
  # GET /divisions.json
  def index
    @divisions = Division.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @divisions }
    end
  end

  # GET /divisions/1
  # GET /divisions/1.json
  def show
    @division = Division.find(params[:id])
    @representatives = DivisionRep.where(:division_id => params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @division }
    end
  end

  # GET /divisions/new
  # GET /divisions/new.json
  def new
    @division = Division.new
    @dteams =  TeamDivision.where(:division_id => params[:id])
    @teams_array = Team.order('name ASC').all.map { |team| [team.name, team.id]} 
    @representatives = DivisionRep.where(:division_id => params[:id])
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @division }
    end
  end

  # GET /divisions/1/edit
  def edit
    @division = Division.find(params[:id])
    @dteams =  TeamDivision.where(:division_id => params[:id])
    @teams_array = Team.order('name ASC').all.map { |team| [team.name, team.id] }
    @representatives = DivisionRep.where(:division_id => params[:id])
  end

  # POST /divisions
  # POST /divisions.json
  def create
    @division = Division.new(params[:division])

    respond_to do |format|
      if @division.save
        format.html { redirect_to @division, notice: 'Division was successfully created.' }
        format.json { render json: @division, status: :created, location: @division }
      else
        format.html { render action: "new" }
        format.json { render json: @division.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /divisions/1
  # PUT /divisions/1.json
  def update
    @division = Division.find(params[:id])

    respond_to do |format|
      if @division.update_attributes(params[:division])
        format.html { redirect_to @division, notice: 'Division was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @division.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /divisions/1
  # DELETE /divisions/1.json
  def destroy
    @division = Division.find(params[:id])
    @division.destroy

    respond_to do |format|
      format.html { redirect_to divisions_url }
      format.json { head :no_content }
    end
  end
end

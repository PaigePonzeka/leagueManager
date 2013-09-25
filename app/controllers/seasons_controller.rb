class SeasonsController < ApplicationController
  before_filter :require_admin, :only  => [:new, :destroy, :edit, :update]
  # GET /seasons
  # GET /seasons.json
  def index
    @seasons = Season.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @seasons }
    end
  end

  # GET /seasons/1
  # GET /seasons/1.json
  def show
    @season = Season.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @season }
    end
  end

  # GET /seasons/new
  # GET /seasons/new.json
  def new
    @season = Season.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @season }
    end
  end

  # GET /seasons/1/edit
  def edit
    @season = Season.find(params[:id])
  end

  # POST /seasons
  # POST /seasons.json
  def create
    @season = Season.new(params[:season])

    respond_to do |format|
      if @season.save
        format.html { redirect_to seasons_path, notice: 'Season was successfully created.' }
        format.json { render json: @season, status: :created, location: @season }
      else
        format.html { render action: "new" }
        format.json { render json: @season.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /seasons/1
  # PUT /seasons/1.json
  def update
    @season = Season.find(params[:id])

    respond_to do |format|
      if @season.update_attributes(params[:season])
        format.html { redirect_to @season, notice: 'Season was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @season.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /seasons/1
  # DELETE /seasons/1.json
  def destroy
    @season = Season.find(params[:id])
    @season.destroy

    respond_to do |format|
      format.html { redirect_to seasons_url }
      format.json { head :no_content }
    end
  end
end

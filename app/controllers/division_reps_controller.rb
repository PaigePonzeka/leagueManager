class DivisionRepsController < ApplicationController
  # GET /division_reps
  # GET /division_reps.json
  def index
    @division_reps = DivisionRep.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @division_reps }
    end
  end

  # GET /division_reps/1
  # GET /division_reps/1.json
  def show
    @division_rep = DivisionRep.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @division_rep }
    end
  end

  # GET /division_reps/new
  # GET /division_reps/new.json
  def new
    @division_rep = DivisionRep.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @division_rep }
    end
  end

  # GET /division_reps/1/edit
  def edit
    @division_rep = DivisionRep.find(params[:id])
  end

  # POST /division_reps
  # POST /division_reps.json
  def create
    @division_rep = DivisionRep.new(params[:division_rep])

    respond_to do |format|
      if @division_rep.save
        format.html { redirect_to @division_rep, notice: 'Division rep was successfully created.' }
        format.json { render json: @division_rep, status: :created, location: @division_rep }
      else
        format.html { render action: "new" }
        format.json { render json: @division_rep.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /division_reps/1
  # PUT /division_reps/1.json
  def update
    @division_rep = DivisionRep.find(params[:id])

    respond_to do |format|
      if @division_rep.update_attributes(params[:division_rep])
        format.html { redirect_to @division_rep, notice: 'Division rep was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @division_rep.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /division_reps/1
  # DELETE /division_reps/1.json
  def destroy
    @division_rep = DivisionRep.find(params[:id])
    @division_rep.destroy

    respond_to do |format|
      format.html { redirect_to division_reps_url }
      format.json { head :no_content }
    end
  end
end

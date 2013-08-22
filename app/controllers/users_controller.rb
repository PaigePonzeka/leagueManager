class UsersController < ApplicationController
  # GET /players
  # GET /players.json
  def index
    @users= User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /players/1
  # GET /players/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  
  # GET /players/new
  # GET /players/new.json
  def new
    @user = User.new
    if @user.save
      flash[:success] = "Welcome to the BASL!"
      redirect_to @user
    end
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /players/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /players
  # POST /players.json
  def create
    @user = User.new(params[:user])
    #set default permission level
    @user.permission = 0

    respond_to do |format|
      if @user.save
        sign_in @user
        flash[:success] = "Welcome to the Sample App!"
        redirect_to @user
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /players/1
  # PUT /players/1.json
  def update
    @user= User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:player])
        format.html { redirect_to @player, notice: 'Userwas successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end

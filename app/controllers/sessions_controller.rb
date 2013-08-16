class SessionsController < ApplicationController
  def new
  end

  def create
    player= Player.find_by_email(params[:session][:email].downcase)
    if player && player.authenticate(params[:session][:password])
      # Sign the user in and redirect to the user's show page.
      sign_in player
      redirect_to player
    else
      flash[:error] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
  end

  def destroy
  end
end

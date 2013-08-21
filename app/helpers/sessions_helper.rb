module SessionsHelper

  def sign_in(player)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    player.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_player = player
  end

  def current_player=(player)
    @current_player =player
  end

   def current_player
    remember_token = User.encrypt(cookies[:remember_token])
    @current_player ||= User.find_by_remember_token(remember_token)
  end

  def signed_in?
    !current_player.nil?
  end
end

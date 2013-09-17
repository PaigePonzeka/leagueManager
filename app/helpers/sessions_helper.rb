module SessionsHelper

  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end

  def current_user=(user)
    @current_user =user
  end

   def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by_remember_token(remember_token)
  end

  def signed_in?
    !current_user.nil?
  end

  def is_admin?
    signed_in? && current_user.permission == 2
  end

  def is_manager?
    teamsManaged.size > 0
  end

  def is_division_rep(division)
    puts "searching for division rep #{division.name}"
    puts self.current_user.inspect
    divisionRep = DivisionRep.where(  :user_id => self.current_user.id)
    #divisionRep.size > 0
  end

  def teamsManaged
    teams =  TeamManager.where(:user_id => current_user.id)
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by_remember_token(remember_token)
  end

  def current_user?(user)
    user == current_user
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end

  def username
    "#{current_user.first_name} #{current_user.last_name}"
  end


end

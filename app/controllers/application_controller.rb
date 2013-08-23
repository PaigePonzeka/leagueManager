class ApplicationController < ActionController::Base
   protect_from_forgery with: :exception
  include SessionsHelper


  def require_login
     unless signed_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to signin_path
    end
  end

  def require_admin
     unless is_admin?
      flash[:error] = "Access Denied"
      redirect_to root_path
    end
  end
  def require_admin_or_user
    unless is_admin?
      flash[:error] = "Access Denied"
      redirect_to root_path
    end
  end
end

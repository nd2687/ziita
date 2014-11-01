class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def current_admin
    if session[:current_admin_id]
      @current_admin = Administrator.find_by_id(session[:current_admin_id])
      session.delete(:current_admin_id) unless @current_admin
    end
    @current_admin
  end
  helper_method :current_admin

  def authenticate_administrator
    unless current_admin
      redirect_to [ :new, :admin, :session ]
    end
  end
end

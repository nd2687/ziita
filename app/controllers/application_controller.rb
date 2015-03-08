class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :presence_check_account

  layout 'user'

  rescue_from ActiveRecord::RecordNotFound, with: :rescue404
  rescue_from ActionController::RoutingError, with: :rescue404

  private
  def rescue404(e)
    @exception = e
    render 'errors/not_found', status: 404
  end

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

  def current_user
    if current_user_id = cookies.signed[:current_user_id] || session[:current_user_id]
      @current_user = Account.find_by(id: current_user_id)
      session.delete(:current_user_id) unless @current_user
    end
    @current_user
  end
  helper_method :current_user

  def authenticate_account
    unless current_user
      redirect_to [ :new, :session ]
    end
  end

  def presence_check_account
    if params[:identify_name]
      account = Account.find_by(identify_name: params[:identify_name])
      if account == nil
        raise ActionController::RoutingError,
          "No route matches #{request.path.inspect}"
      end
      if account != current_user
        @another_user = account
      end
      @another_user
    end
  end

  def actual_user
    if @another_user.present?
      @actual_user = @another_user
    else
      @actual_user = current_user
    end
    @actual_user
  end
  helper_method :actual_user

  def article_user?
    return false unless params[:access_token]
    @article = Article.find_by_access_token(params[:access_token])
    @article.account == current_user ? true : false
  end
  helper_method :article_user?
end

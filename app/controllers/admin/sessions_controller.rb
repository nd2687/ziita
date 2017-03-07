class Admin::SessionsController < Admin::Base
  skip_before_action :authenticate_administrator
  skip_before_action :presence_check_account

  layout 'admin_session'

  def new
  end

  def create
    if admin = AdminPasswordAuthenticator.verify(params[:login_name], params[:password])
      session[:current_admin_id] = admin.id
      flash.notice = 'ログインしました'
      redirect_to :admin_root
    else
      flash.now[:alert] = 'ログインに失敗しました'
      render action: 'new'
    end
  end

  def destroy
    session.delete(:current_admin_id)
    flash.notice = 'ログアウトしました'
    redirect_to :admin_root
  end
end

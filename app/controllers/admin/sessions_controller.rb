class Admin::SessionsController < Admin::Base
  skip_before_filter :authenticate_administrator

  def new
  end

  def create
    if admin = AdminPasswordAuthenticator.verify(params[:login_name], params[:password])
      session[:current_admin_id] = admin.id
      redirect_to :admin_root
    else
      render action: 'new'
    end
  end

  def destroy
    session.delete(:current_admin_id)
    redirect_to :admin_root
  end
end

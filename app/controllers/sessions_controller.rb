class SessionsController < ApplicationController
  skip_before_action :presence_check_account

  def new
  end

  def create
    if user = UserPasswordAuthenticator.verify(params[:identify_name], params[:password])
      session[:current_user_id] = user.id
      flash.notice = 'ログインしました'
      redirect_to :root
    else
      flash.now[:alert] = 'ログインに失敗しました'
      render action: 'new'
    end
  end

  def destroy
    session.delete(:current_user_id)
    flash.notice = 'ログアウトしました'
    redirect_to :root
  end
end

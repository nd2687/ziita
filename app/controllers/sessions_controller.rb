class SessionsController < ApplicationController
  skip_before_action :presence_check_account

  def new
    if current_user
      redirect_to user_root_path(identify_name: current_user.identify_name)
    end
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

  def callback
    if request.env['omniauth.auth']
      account_identity = OmniAuthAuthenticator.verify(env['omniauth.auth'])
      if account_identity == false
        flash.alert = "認証したいサイトのメールアドレスの設定を行ってください。"
        render "failure"
      else
        if account_identity.new_record?
          session[:omniauth_provider] = account_identity.provider
          session[:omniauth_uid] = account_identity.uid
          session[:omniauth_email] = account_identity.email
          session[:omniauth_nickname] = account_identity.nickname if account_identity.nickname.present?
          @account = account_identity
          render :callback
        else
          session[:current_user_id] = account_identity.account.id
          flash.notice = "ログインしました"
          render :callback
        end
      end
    else
      flash.alert = "エラーが発生したため認証ができませんでした。"
      render "failure"
    end
  end

  def failure
  end
end

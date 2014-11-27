class AccountIdentitiesController < ApplicationController
  skip_before_action :presence_check_account

  def new
    @account = Account.new
    @account.identify_name = session[:omniauth_nickname]
  end

  def create
    @account = Account.new(new_account_params)
    create_omniauth_password @account
    if @account.save
      ai = AccountIdentity.create!(
        :account => @account,
        :provider => session[:omniauth_provider],
        :uid => session[:omniauth_uid],
        :email => session[:omniauth_email],
        :nickname => session[:omniauth_nickname]
      )
      session.delete(:omniauth_provider)
      session.delete(:omniauth_uid)
      session.delete(:omniauth_email)
      session.delete(:omniauth_nickname)
      session[:current_user_id] = ai.account_id
      flash.notice = "アカウント登録完了しました"
      redirect_to user_root_path(identify_name: @account.identify_name)
    else
      flash.now[:alert] = "アカウント登録に失敗しました"
      render action: 'new'
    end
  end

  private
  def new_account_params
    params.require(:account).permit(
      :identify_name, :email
    )
  end

  def create_omniauth_password(account)
    password = SecureRandom.base64
    account.password = password
    account.password_confirmation = password
    account.setting_password = true
  end
end

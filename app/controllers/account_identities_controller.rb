class AccountIdentitiesController < ApplicationController
  skip_before_action :presence_check_account

  def new
    @account = Account.new
  end

  def create
    @account = Account.new(new_account_params)
    @account.setting_password = true
    if @account.save
      ai = AccountIdentity.create!(
        :account => @account,
        :provider => session[:omniauth_provider],
        :uid => session[:omniauth_uid],
        :info => session[:omniauth_info]
      )
      ai.account.email = params[:account][:email]
      session.delete(:omniauth_provider)
      session.delete(:omniauth_uid)
      session.delete(:omniauth_info)
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
      :identify_name, :email,
      :password, :password_confirmation
    )
  end
end

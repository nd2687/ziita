class AccountsController < ApplicationController
  def new
    @account = Account.new
  end

  def create
    @account = Account.new(new_account_params)
    @account.setting_password = true
    if @account.save
      flash.notice = "新規登録しました"
      session[:current_user_id] = @account.id
      redirect_to :root
    else
      flash.now[:alert] = "新規登録に失敗しました"
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


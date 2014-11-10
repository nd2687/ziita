class User::AccountsController < User::Base
  skip_before_filter :authenticate_account

  def show
    @account = Account.find(params[:id])
  end

  def new
    @account = Account.new
  end

  def create
    @account = Account.new(account_params)
    @account.setting_password = true
    @account.save
  end

  private
  def account_params
    params.require(:account).permit(
      :identify_name, :password, :password_confirmation
    )
  end
end

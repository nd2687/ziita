class User::AccountsController < User::Base
  skip_before_action :authenticate_account
  before_action :check_current_user, only: [ :edit, :update ]

  def show
    @account = Account.find(params[:id])
    if @account != actual_user
      redirect_to user_account_path(identify_name: @account.identify_name, id: @account)
    end
  end

  def new
    @account = Account.new
  end

  def create
    @account = Account.new(new_account_params)
    @account.setting_password = true
    @account.save
  end

  def edit
  end

  def update
    @account.assign_attributes(edit_account_params)
    if @account.save
      flash.notice = "アカウント情報を更新しました。"
      redirect_to user_account_path(identify_name: current_user.identify_name, id: @account.id)
    else
      flash.now[:alert] = "アカウント情報の更新に失敗しました。"
      render action: 'edit'
    end
  end

  private
  def new_account_params
    params.require(:account).permit(
      :identify_name, :password, :password_confirmation
    )
  end

  def edit_account_params
    params.require(:account).permit(
      :email_publication, :self_introduction, :sites,
      :company, :residence
    )
  end

  def check_current_user
    @account = Account.find_by(identify_name: params[:identify_name])
    if @account != current_user
      flash.alert = "他ユーザーの情報編集はできません。"
      redirect_to :root
    end
  end
end

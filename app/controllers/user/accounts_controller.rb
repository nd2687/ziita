class User::AccountsController < User::Base
  skip_before_action :authenticate_account

  def new
    @account = Account.new
  end

  def create
    @account = Account.new(new_account_params)
    @account.setting_password = true
    @account.save
  end

  def edit
    @account = Account.find_by_account_token(params[:account_token])
    @account.build_image unless @account.image
  end

  def update
    @account = Account.find_by_account_token(params[:account_token])
    @account.assign_attributes(edit_account_params)
    if @account.save
      flash.notice = "アカウント情報を更新しました。"
      redirect_to user_root_path(identify_name: current_user.identify_name)
    else
      flash.now[:alert] = "アカウント情報の更新に失敗しました。"
      render action: 'edit'
    end
  end

  def edit_password
    @change_password_form = ChangePasswordForm.new(object: current_user)
  end

  def update_password
    @change_password_form = ChangePasswordForm.new(password_params)
    @change_password_form.object = current_user
    if @change_password_form.save
      flash.notice = "パスワードを変更しました。"
      redirect_to settings_user_account_path(
        identify_name: current_user.identify_name, account_token: current_user.account_token)
    else
      flash.now[:alert] = "パスワードの変更に失敗しました。"
      render action: 'edit_password'
    end
  end

  def settings
  end

  private
  def new_account_params
    params.require(:account).permit(
      :identify_name, :password, :password_confirmation
    )
  end

  def edit_account_params
    if params[:account][:image_attributes].present?
      if params[:account][:image_attributes][:uploaded_image].present?
        @account.build_image if @account.image.nil?
        @account.image.content_type = convert_content_type(
          params[:account][:image_attributes][:uploaded_image].content_type)
        @account.image.data = params[:account][:image_attributes][:uploaded_image].read
      end
    end
    params.require(:account).permit(
      :email_publication, :self_introduction, :sites,
      :company, :residence,
      image_attributes: [ :id, :_destroy ]
    )
  end

  def convert_content_type(ctype)
    cytpe = ctype.rstrip.downcase
    case ctype
    when "image/pjpeg" then "image/jpeg"
    when "image/jpg" then "image/jpeg"
    when "image/x-png" then "image/png"
    else ctype
    end
  end

  def password_params
    params.require(:change_password_form).permit(
      :new_password, :new_password_confirmation
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

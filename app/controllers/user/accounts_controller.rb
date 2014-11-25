class User::AccountsController < User::Base
  skip_before_action :authenticate_account
  before_action :check_current_user, except: [ :show ]

  def show
    @account = Account.find(params[:id])
    if params[:format].in?(["jpg", "png", "gif"])
      send_image
    else
      if @account != actual_user
        redirect_to user_account_path(
          identify_name: @account.identify_name, id: @account)
      end
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
    @account = Account.find(params[:id])
    @account.build_image unless @account.image
  end

  def update
    @account = Account.find(params[:id])
    @account.assign_attributes(edit_account_params)
    if @account.save
      flash.notice = "アカウント情報を更新しました。"
      redirect_to user_account_path(identify_name: current_user.identify_name, id: @account.id)
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
        identify_name: current_user.identify_name, id: current_user)
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
    if params[:account][:image_attributes][:uploaded_image].present?
      @account.build_image if @account.image.nil?
      @account.image.content_type = convert_content_type(
        params[:account][:image_attributes][:uploaded_image].content_type)
      @account.image.data = params[:account][:image_attributes][:uploaded_image].read
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

  def send_image
    if @account.image.present?
      send_data @account.image.data,
        type: @account.image.content_type, disposition: "inline"
    else
      raise NotFound
    end
  end
end

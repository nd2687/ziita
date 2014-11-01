class Admin::AdministratorsController < Admin::Base
  def new
    @administrator = Administrator.new
  end

  def create
    @administrator = Administrator.new(administrator_params)
    @administrator.setting_password = true
    @administrator.save
  end

  private
  def administrator_params
    params.require(:administrator).permit({
      :login_name, :password, :password_confirmation
    })
  end
end

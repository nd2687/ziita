administrator = Administrator.new(login_name: 'rubyko', password: 'password', password_confirmation: 'password')
administrator.setting_password = true
administrator.save!

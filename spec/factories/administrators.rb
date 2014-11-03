FactoryGirl.define do
  factory :administrator do
    login_name 'test_user'
    password 'password'
    setting_password true
  end
end

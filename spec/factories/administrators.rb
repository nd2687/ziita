# == Schema Information
#
# Table name: administrators
#
#  id              :integer          not null, primary key
#  login_name      :string(255)      not null
#  password_digest :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#

FactoryGirl.define do
  factory :administrator do
    login_name 'test_user'
    password 'password'
    setting_password true
  end
end

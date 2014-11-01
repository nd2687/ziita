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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :administrator do
  end
end

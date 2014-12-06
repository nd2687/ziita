# == Schema Information
#
# Table name: accounts
#
#  id                :integer          not null, primary key
#  identify_name     :string(255)      not null
#  email             :string(255)      not null
#  email_for_index   :string(255)      not null
#  email_publication :boolean          default(FALSE), not null
#  password_digest   :string(255)      not null
#  self_introduction :text
#  sites             :string(255)
#  company           :string(255)
#  residence         :string(255)
#  account_token     :string(20)       not null
#  created_at        :datetime
#  updated_at        :datetime
#
# Indexes
#
#  index_accounts_on_account_token                      (account_token) UNIQUE
#  index_accounts_on_identify_name_and_email_for_index  (identify_name,email_for_index) UNIQUE
#

FactoryGirl.define do
  factory :account do
    identify_name 'taro'
    password 'password'
    email 'taro@example.com'
    self_introduction 'テストです'
    setting_password true
  end
end

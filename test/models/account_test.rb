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
#  self_introduction :string(255)      not null
#  sites             :string(255)
#  company           :string(255)
#  residence         :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#
# Indexes
#
#  index_accounts_on_identify_name_and_email_for_index  (identify_name,email_for_index) UNIQUE
#

require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

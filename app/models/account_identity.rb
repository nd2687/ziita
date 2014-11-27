# == Schema Information
#
# Table name: account_identities
#
#  id         :integer          not null, primary key
#  account_id :integer          not null
#  provider   :string(255)      not null
#  uid        :string(255)      not null
#  info       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_account_identities_on_provider_and_uid_and_info  (provider,uid,info) UNIQUE
#

class AccountIdentity < ActiveRecord::Base
  belongs_to :account
end

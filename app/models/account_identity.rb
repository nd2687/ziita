# == Schema Information
#
# Table name: account_identities
#
#  id         :integer          not null, primary key
#  account_id :integer          not null
#  provider   :string(255)      not null
#  uid        :string(255)      not null
#  email      :string(255)      not null
#  nickname   :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  fk_rails_273a77a371                                        (account_id)
#  index_account_identities_on_provider_and_uid_and_email     (provider,uid,email) UNIQUE
#  index_account_identities_on_provider_and_uid_and_nickname  (provider,uid,nickname) UNIQUE
#

class AccountIdentity < ActiveRecord::Base
  belongs_to :account
end

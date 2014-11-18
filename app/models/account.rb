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

class Account < ActiveRecord::Base
  has_many :articles, dependent: :destroy

  attr_accessor :password, :password_confirmation, :setting_password
  alias_method :setting_password?, :setting_password

  validates :self_introduction, presence: true
  validates :sites, format: { with: /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix,
                              allow_blank: true }
  validates :company, length: { maximum: 32, allow_blank: true }
  validates :residence, length: { maximum: 32, allow_blank: true }

  before_validation do
    self.email_for_index = email.downcase if email
  end

  before_save do
    if setting_password?
      self.password_digest = BCrypt::Password.create(password)
    end
  end

  def authenticate(raw_password)
    if password_digest && BCrypt::Password.new(password_digest) == raw_password
      self
    else
      false
    end
  end
end

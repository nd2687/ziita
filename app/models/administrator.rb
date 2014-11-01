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

class Administrator < ActiveRecord::Base
  attr_accessor :password, :password_confirmation, :setting_password
  alias_method :setting_password?, :setting_password

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

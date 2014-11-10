class UserPasswordAuthenticator
  class << self
    def verify(identify_name, password)
      return false unless identify_name.present? && password.present?
      account = Account.find_by_identify_name(identify_name)
      account && account.authenticate(password)
    end
  end
end

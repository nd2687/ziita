class AdminPasswordAuthenticator
  class << self
    def verify(login_name, password)
      return false unless login_name.present? && password.present?
      admin = Administrator.find_by_login_name(login_name)
      admin && admin.authenticate(password)
    end
  end
end

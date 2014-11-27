class OmniAuthAuthenticator
  class << self
    def verify(auth)
      return false unless auth.kind_of?(Hash)
      return false if auth['provider'].blank?
      return false if auth['uid'].blank?
      return false if auth['info']['email'].blank?
      if account_identity = AccountIdentity.where(
        provider: auth['provider'], uid: auth['uid'], info: auth['info']['email']).first
        account_identity
      else
        AccountIdentity.new(provider: auth['provider'], uid: auth['uid'], info: auth['info']['email'])
      end
    end
  end
end

class OmniAuthAuthenticator
  class << self
    def verify(auth)
      return false unless auth.kind_of?(Hash)
      return false if auth['provider'].blank?
      return false if auth['uid'].blank?
      return false if auth['info']['nickname'].blank?
      # twitter-OAuthはemailを取得しない
      if auth['provider'] == "twitter"
        auth['info']['email'] = Account.create_unique_email
        if account_identity = AccountIdentity.where(provider: auth['provider'],
             uid: auth['uid'], nickname: auth['info']['nickname']).first
          account_identity
        else
          registered_name = Account.all.map(&:identify_name)
          if registered_name.include?(auth['info']['nickname'])
            AccountIdentity.new(provider: auth['provider'], uid: auth['uid'],
              email: auth['info']['email'], nickname: "")
          else
            AccountIdentity.new(provider: auth['provider'], uid: auth['uid'],
              email: auth['info']['email'], nickname: auth['info']['nickname'])
          end
        end
      else
        return false if auth['info']['email'].blank?
        if account_identity = AccountIdentity.where(provider: auth['provider'],
             uid: auth['uid'], email: auth['info']['email'], nickname: auth['info']['nickname']).first
          account_identity
        else
          registered_name = Account.all.map(&:identify_name)
          if  registered_name.include?(auth['info']['nickname'])
            AccountIdentity.new(provider: auth['provider'], uid: auth['uid'],
              email: auth['info']['email'], nickname: "")
          else
            AccountIdentity.new(provider: auth['provider'], uid: auth['uid'],
              email: auth['info']['email'], nickname: auth['info']['nickname'])
          end
        end
      end
    end
  end
end

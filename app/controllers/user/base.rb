class User::Base < ApplicationController
  before_filter :authenticate_account
  layout 'user'
end

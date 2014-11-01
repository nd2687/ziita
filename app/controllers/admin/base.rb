class Admin::Base < ApplicationController
  before_filter :authenticate_administrator
  layout 'admin'
end

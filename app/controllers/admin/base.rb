class Admin::Base < ApplicationController
  before_action :authenticate_administrator
  layout 'admin'
end

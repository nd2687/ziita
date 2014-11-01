class Admin::Base < ApplicationController
  before_filter :authenticate_administrator
end

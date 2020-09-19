class Admin::SalesController < ApplicationController

  before_filter :authenticate

  def index
    @sales = Sale.all
  end

  def new
  end

  protected
  
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['ADMIN_USERNAME'] && password == ENV['ADMIN_PASSWORD']
    end
  end
  
end

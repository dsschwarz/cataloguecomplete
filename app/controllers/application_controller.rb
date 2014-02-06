class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  before_filter :session_exists
  
	def session_exists
    if !signed_in?
      puts "NO SESSION EXISTS"
      redirect_to "/signin"
    end
  end
end
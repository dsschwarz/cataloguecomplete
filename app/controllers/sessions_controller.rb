class SessionsController < ApplicationController
  skip_before_filter :session_exists
  def new
   if signed_in?
    redirect_to '/'
    flash.alert = "You are already signed in"
   end
  end

  def create
    puts "----------------------------------------"
    puts "----------------------------------------"
    puts "----------------------------------------"
    puts "----------------------------------------"
    puts params
    user = User.find_by_username(params[:session][:username].downcase)
    if user
      puts "1"
      if user.authenticate(params[:session][:password])
      puts "11"
        sign_in user
        redirect_to '/'
      else
      puts "12"
        flash.now[:danger] = 'Incorrect Password' 
        render 'new' && return
      end
    else
      puts "2"
      flash.now[:danger] = 'Username does not exist' 
      render 'new'
    end
  end

  def destroy
    self.current_user = nil
    cookies.delete(:remember_token)
    puts "REMEMBER TOKEN -----------------------------"
    puts cookies[:remember_token]
    redirect_to '/'
  end
end
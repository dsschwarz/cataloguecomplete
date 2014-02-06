class UsersController < ApplicationController
	skip_before_filter :session_exists
	def new
		@user = User.new
	end

	def create
		@user = User.new(params[:user])    # Not the final implementation!
		if @user.save
			sign_in @user
		  redirect_to articles_path
		else
			render 'new'
		end
	end
	def show
		@user = User.find(params[:id])
	end

	def index
		@users = User.all
	end
end

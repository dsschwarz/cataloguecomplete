class ArticlesController < ApplicationController
	skip_before_filter :session_exists, only: :index
	def new
		@article = Article.new
	end
	def create
		@article = Article.new(params[:article])
		@article.user_id = current_user.id
		if @article.save
			tags = params[:tags].split(" ")
			tags.each do |t|
				@article.tags.create({name: t})
			end
			redirect_to articles_url
		else
			flash.now[:danger] = "Invalid Upload - check picture is valid"
			render 'new'
		end
	end

	def index
		@articles = Article.all

		if (params[:tags] && params[:tags] != "")
			# Filter based on number of matching tags
			@matches = {}
			tags = params[:tags].split(" ")
			@articles.each do |a|
				num_matches = 0
				a.tags.each do |t|
					if (tags.include? t.name)
						num_matches += 1
					end
				end

				# If article matched search, add it
				if (num_matches > 0)

					# Create the array if it does not exist
					if (!@matches[num_matches])
						@matches[num_matches] = []
					end
					@matches[num_matches].push a
				end
			end
		end

		render 'index'

	end
end

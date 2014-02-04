class ArticlesController < ApplicationController
	def new
		@article = Article.new
	end
	def create
		@article = Article.new(params[:article])
		if @article.save
			# handle it
		else
			render 'new'
		end
	end

	def index
		@articles = Article.all

		if (params[:tags])
			# Filter based on number of matching tags
			@matches = {}
			tags = params[:tags].split(" ")
			@articles.each do |a|
				num_matches = rand(10)
				a.tags.each do |t|
					if (tags.include? t.name)
						num_matches += 1
					end
				end

				# If article matched search, add it
				if (num_matches >= 0)

					# Create the array if it does not exist
					if (!@matches[num_matches])
						@matches[num_matches] = []
					end
					@matches[num_matches].push a
				end
			end
			@matches.keys.sort
			puts @matches.keys
		end

		render 'index'

	end
end

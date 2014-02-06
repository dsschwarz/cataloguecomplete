class Article < ActiveRecord::Base
	belongs_to :user
  attr_accessible :picture
  has_and_belongs_to_many :tags, uniq: true
  before_save :remote_file_exists

	def remote_file_exists
		begin
	    url = URI.parse(self.picture)
	    Net::HTTP.start(url.host, url.port) do |http|
	      return http.head(url.request_uri)['Content-Type'].start_with? 'image'
	    end
	  rescue
	  	return false
	  end
	end
end

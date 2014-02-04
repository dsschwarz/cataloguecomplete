class Article < ActiveRecord::Base
	belongs_to :user
  attr_accessible :picture
  has_and_belongs_to_many :tags, uniq: true
end

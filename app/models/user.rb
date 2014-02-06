class User < ActiveRecord::Base
  attr_accessible :username, :password, :password_confirmation
  has_secure_password
  validates :password, length: { minimum: 2 }

  
  before_save :create_remember_token

  before_save do
		self.username = self.username.downcase
	end

  validates :remember_token, uniqueness: true
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
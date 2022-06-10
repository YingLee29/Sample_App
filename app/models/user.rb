class User < ApplicationRecord
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
 
	before_save :downcase_email
 
	validates :email, presence: true, length: {minium: 20, maximum: 255},
  	format: {with: VALID_EMAIL_REGEX},
  	uniqueness: { case_sensitive: false }
 
	validates :name, presence: true, length: { maximum: 10 }
	validates :password, presence: true, length: { minimum: 6 }, if: :password
 	has_secure_password
	private
 
	def downcase_email
   self.email.downcase!
	end

end
	
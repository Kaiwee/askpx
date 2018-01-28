class User < ApplicationRecord
	has_secure_password
	before_create { generate_token(:auth_token) }
	attr_accessor :remember_me

	enum verification: { Unverified: 0, Verified: 1 }
	enum role: { User: 'User', Pharmacist: 'Pharmacist', Admin: 'admin' }

	validates :email, uniqueness: true

	has_many :authentications, :dependent => :destroy

	def self.create_with_auth_and_hash(authentication,auth_hash)
		user = self.create! do |u|
			u.password = SecureRandom.hex(10)
			u.email = auth_hash["extra"]["raw_info"]["email"]
		end
		user.authentications << authentication
		return user
	end

	def fb_token
	  	x = self.authentications.where(:provider => :facebook).first
	  	return x.token unless x.nil?
  	end

  	def generate_token(column)
  		begin
  			self[column] = SecureRandom.urlsafe_base64
  		end while User.exists?(column => self[column])
  	end
end

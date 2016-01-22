class User < ActiveRecord::Base
  
  before_create :generate_url_token, :generate_authentication_token

  has_secure_password

  private

	  def generate_url_token
			begin
				self.url_token = SecureRandom.hex(12).upcase
			end while self.class.exists?(url_token: url_token)
		end  

		def generate_authentication_token
			begin
				self.authentication_token = SecureRandom.hex(20)
			end while self.class.exists?(authentication_token: authentication_token)
    end

end

class User < ActiveRecord::Base
	before_save   :downcase_email
	before_create :add_token

	has_secure_password
	## What does this Rails method add?
	# - Ability to save a secure, hashed password_digest
	# - A pair of virtual attributes password and password_confirmation, and a validation checking that they match
	# - An authenticate method that returns the user when the password is correct (false otherwise)



	private

		def downcase_email
			self.email = email.downcase
		end

		def add_token
			begin
        self.token = SecureRandom.urlsafe_base64.upcase
      end while self.class.exists?(token: token)
		end
end

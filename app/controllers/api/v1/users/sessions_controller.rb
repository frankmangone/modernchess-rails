module Api
	module V1
		module Users
			class Api::V1::Users::SessionsController < BaseApiController

				def create
					info = session_params
					user = User.find_by_email info[:email]
					if user && user.authenticate(info[:password])
						data = {
							token: user.authentication_token,
        			email: user.email
						}
						render json: { user: user }, status: 201#:ok
					else
						render json: { error: "Invalid username or password" }, status: :unprocessable_entity
					end
				end
				
				private

					def session_params
						params.require(:user).permit(:email, :password)
					end
			end
		end
	end
end

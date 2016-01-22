module Api
	module V1
		module Users	
			class Api::V1::Users::UsersController < BaseApiController
				respond_to :json

				def index
					users = User.all
					render json: users, root: 'users', status: :ok	
				end

				def show
					user = User.find_by_token params[:token]
					render json: user, root: 'user', status: :ok
				end

				def create
					user = User.new(user_params)
					if user.save
						render json: user, root: 'user', status: :ok
					else
						puts user.errors
						render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
					end
				end

				def destroy
					
				end


				

				private

					def user_params
						params.require(:user).permit(:name, :email, :password, :password_confirmation)
					end
			end
		end
	end
end

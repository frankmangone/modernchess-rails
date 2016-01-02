module Api
	module V1
		module Modernchess
			class Api::V1::Modernchess::Rooms::ModernchessRoomsController < BaseApiController
				respond_to :json

				#skip_before_filter :verify_authenticity_token

				def index
					@rooms = Room.where(game_type: 'modernchess')
					render json: @rooms, root: 'modernchess/rooms'
				end

				def show
					# For the "find" requests performed for Ember Data
					token = params[:token]
					@room = Room.find_by_token token
					render json: @room, root: "modernchess/room", status: :ok
				end

				def create
					@room = Room.new(room_params)
					if @room.save
						render json: @room, root: "modernchess/room", status: :ok
					else
						render json: @room, room: "modernchess/room", status: :unprocessable_entity
					end
				end

				def destroy
					token = params[:token]
					@room = Room.find_by_token token
					if @room.destroy
						render json: @room, root: "modernchess/room", status: :ok
					else
						render json: @room, root: "modernchess/room", status: :unprocessable_entity
					end
				end


				private

					def room_params
						params.require("modernchess/room").permit(:game_type, :turn)
					end
			end
		end
	end
end
module Api
	module V1
		module Chess
			class Api::V1::Chess::Rooms::ChessRoomsController < ApplicationController
				respond_to :json
				
				def index
					@rooms = Room.where(game_type: 'chess')
					render json: @rooms, root: 'data'
				end

				def show
					@room = Room.find_by_token(params[:token])
					render json: @room, root: 'data'
				end
			end
		end
	end
end
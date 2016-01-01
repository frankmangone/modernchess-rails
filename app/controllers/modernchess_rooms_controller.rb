require "action_controller"
require "action_controller/serialization"
require "#{Rails.root}/app/serializers/room_serializer.rb"

require "#{Rails.root}/app/objects/modernchess_move_calculator.rb"
require "#{Rails.root}/app/objects/move_maker.rb"

class ModernchessRoomsController < WebsocketRails::BaseController

	def load_room
		token = message["id"]
		room = Room.find_by_token token
		room = RoomSerializer.new(room, root: 'room')
		send_message :load_room_response, room
	end

	def calculate_moves
		piece = message
		room = Room.find_by_token message["id"]
		calculator = ModernchessMoveCalculator.new(room.board, piece, room.turn)
		response = { moves: calculator.calculate_moves }
		send_message :moves_response, response
	end

	def make_move
		token = message["id"]
		room = Room.find_by_token token
		move_maker = MoveMaker.new(room.board, message)
		room.board = move_maker.calculate_new_state

		if room.save
			response = message
			# Maybe send new board state?
			WebsocketRails[token].trigger 'move_done', response
			# room.switch_turn
		else
			# Handle error but there shouldn't be any.
		end
	end

end

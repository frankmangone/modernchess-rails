class MoveMaker

	## This class receives a board, and an action returned by the client
	#  The idea is that it processes any kind of action and returns the new state of the board.

	def initialize(board, message)
		@board    = board
		@row_size = board[0]
		@source   = message["source"]
		@target   = message["target"]
	end

	def calculate_new_state
		action = @target["action"]
		source_index = find_index_in_board @source["row"], @source["column"]
		target_index = find_index_in_board @target["row"], @target["column"]

		case action
			when "MOVE", "TAKE"
				@board[target_index] = @board[source_index]
				@board[source_index] = "o"
		end

		@board
	end

	private

		def find_index_in_board(row, column)
			((row-1)*@row_size + column)
		end

end
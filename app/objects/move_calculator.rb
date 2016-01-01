class MoveCalculator
	## The idea here is to include methods to calculate possible moves for a given piece.
	#  Note that the different move patterns may include moves possible from other patterns,
	#  so it's important not to call two methods that would produce the same outcome.

	# Example: do not call king type move, when you need to call rook type move afterwards.

	#

	## Each game features two classes of pieces, which will be passed as arguments to the initialize method,
	#  depending on the game type

	@@class_1 = []
	@@class_2 = []

	def initialize (board, piece, class_1, class_2)
		# piece is an object containing: name, type, row, column.
		@board    = board
		@row_size = board[0]
		@type     = piece["type"]
		@row      = piece["row"]
		@column   = piece["column"]

		@@class_1 = class_1
		@@class_2 = class_2
	end

	#

	def straight_move(direction)
		moves = calculate_single_move(@row+direction, @column)
		moves
	end

	#

	def pawn_moves(direction)
		moves = calculate_single_move(@row+direction, @column)
		moves = moves.concat( calculate_single_take(@row+direction, @column+1) )
		moves = moves.concat( calculate_single_take(@row+direction, @column-1) )
	end

	#

	def cross_moves
		moves = calculate_single_move(@row+1, @column)
		moves = moves.concat( calculate_single_move(@row-1, @column) )
		moves = moves.concat( calculate_single_move(@row, @column+1) )
		moves = moves.concat( calculate_single_move(@row, @column-1) )
		moves
	end

	#

	def x_moves
		moves = calculate_single_move(@row+1, @column+1)
		moves = moves.concat( calculate_single_move(@row-1, @column+1) )
		moves = moves.concat( calculate_single_move(@row+1, @column-1) )
		moves = moves.concat( calculate_single_move(@row-1, @column-1) )
		moves
	end
	#

	def king_moves
		cross_moves.concat( x_moves )
	end

	#

	def horse_moves
		moves = calculate_single_move(@row+2, @column+1)
		moves = moves.concat( calculate_single_move(@row+2, @column-1) )
		moves = moves.concat( calculate_single_move(@row-2, @column+1) )
		moves = moves.concat( calculate_single_move(@row-2, @column-1) )
		moves = moves.concat( calculate_single_move(@row+1, @column+2) )
		moves = moves.concat( calculate_single_move(@row+1, @column-2) )
		moves = moves.concat( calculate_single_move(@row-1, @column+2) )
		moves = moves.concat( calculate_single_move(@row-1, @column-2) )
	end

	#

	def rook_moves
		moves = loop_in_direction(1, 0)
		moves = moves.concat( loop_in_direction(-1, 0) )
		moves = moves.concat( loop_in_direction(0,  1) )
		moves = moves.concat( loop_in_direction(0, -1) )
		moves
	end

	#

	def bishop_moves
		moves = loop_in_direction(1, 1)
		moves = moves.concat( loop_in_direction(1, -1) )
		moves = moves.concat( loop_in_direction(-1, -1))
		moves = moves.concat( loop_in_direction(-1, 1) )
		moves
	end

	#

	def queen_moves
		rook_moves.concat( bishop_moves )
	end

	# -----------


	protected

		def loop_in_direction(vertical, horizontal)
			# 1 is top or right, 0 is no loop in direction, -1 opposite of first.
			row = @row + vertical
			column = @column + horizontal
			moves  = []

			while inside_board?(row, column) && tile_empty?(row, column) do
				moves << [row, column, "MOVE"]
				row += vertical
				column += horizontal
			end

			# Finally, check if the last tile where the condition is not met in the while, corresponds to an enemy piece
			if inside_board?(row, column)
				if enemy_piece?(row, column)
					moves << [row, column, "TAKE"]
				end
			end

			moves
		end

		#

		def calculate_single_move(row, column)
			move = []

			if inside_board?(row, column)
				if enemy_piece?(row, column)
					move << [row, column, "TAKE"]
				elsif tile_empty?(row, column)
					move << [row, column, "MOVE"]
				end
			end

			move
		end

		#

		def calculate_single_take(row, column)
			move = []

			if inside_board?(row, column)
				if enemy_piece?(row, column)
					move << [row, column, "TAKE"]
				end
			end

			move
		end

		# -----------

		def inside_board?(r, c)
			(r > 0 && r < @row_size+1 && c > 0 && c < @row_size+1)
		end

		def tile_empty?(r, c)
			index = index_in_board(r, c)
			return (@board[index] == "o")
		end

		def enemy_piece?(r, c)
			## Expects a tile in board!
			#  Values in the method scope correspond to the piece to evaluate, not the
			# *clicked* piece
			index = index_in_board(r, c)
			name  = @board[index]
			type  = name[0..2]

			if @@class_1.include? @type
				if @@class_2.include? type
					true
				else
					false
				end
			else
				if @@class_1.include? type
					true
				else
					false
				end
			end
		end

		#

		def index_in_board(r, c)
			return ( (r - 1)*@row_size + c )
		end
end
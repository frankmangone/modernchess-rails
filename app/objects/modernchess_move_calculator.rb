require "#{Rails.root}/app/objects/move_calculator.rb"

class ModernchessMoveCalculator < MoveCalculator

	@@communists   = ["bur", "hst", "peo", "thk"]
	@@capitalists  = ["wrk", "bgs", "tel", "mln", "pol", "eco"]

	def initialize (board, piece, turn)
		@turn = turn
		super(board, piece, @@communists, @@capitalists)
	end

	def calculate_moves
		case @turn
			when "COM"
				case @type 
					when "hst"
						hst_moves
					when "bur"
						bur_moves
					when "peo"
						peo_moves
					when "thk"
						thk_moves
					else
						# Return nothing when not on turn
						[]
				end
			when "CAP"
				case @type
					when "eco"
						eco_moves
					when "mln"
						mln_moves
					when "pol"
						pol_moves
					when "bgs"
						bgs_moves
					when "tel"
						tel_moves
					when "wrk"
						wrk_moves
					else
						# Return nothing when not on turn
						[]
				end
		end
	end


	# Moves for all the piece types (special, complex moves as private methods down below).


	def peo_moves
		adjacent = adjacent_peo
		## direction = 1
		if adjacent == 0
			pawn_moves(1)
		elsif adjacent == 1
			moves = cross_moves
			moves = moves.concat( calculate_single_take(@row+1, @column+1) )
			moves = moves.concat( calculate_single_take(@row+1, @column-1) )
		else
			king_moves
		end
	end

	def bur_moves
		moves = diamond_moves
		if piece_adjacent?("thk")
			moves.concat( rook_moves )
		end

		if piece_adjacent?("hst")
			moves.concat( bishop_moves )
		end

		moves
	end

	def thk_moves
		horse_moves
	end

	def hst_moves
		king_moves
	end

	def eco_moves
		king_moves
	end

	def mln_moves
		wrk_amount = count_wrk

		if bgs_present?
			moves = loop_in_direction_with_limit(1, 0, wrk_amount)
			moves.concat( loop_in_direction_with_limit(-1, 0,  wrk_amount) )
			moves.concat( loop_in_direction_with_limit(0,  1,  wrk_amount) )
			moves.concat( loop_in_direction_with_limit(0, -1,  wrk_amount) )
			moves.concat( loop_in_direction_with_limit(1,  1,  wrk_amount) )
			moves.concat( loop_in_direction_with_limit(1, -1,  wrk_amount) )
			moves.concat( loop_in_direction_with_limit(-1, 1,  wrk_amount) )
			moves.concat( loop_in_direction_with_limit(-1, -1, wrk_amount) )
			moves
		else
			moves = king_moves
			moves
		end
	end

	def bgs_moves
		bishop_moves.concat( cross_moves )
	end

	def pol_moves
		moves = loop_in_direction(1, 0)
		moves.concat( loop_in_direction(-1, 0) )
		moves.concat( horse_moves )
		moves
	end

	def wrk_moves
		pawn_moves(-1)
	end



	private

		def adjacent_peo
			counter = 0
			rows    = (@row-1)..(@row+1)
			columns = (@column-1)..(@column+1)
			rows.each do |r|
				columns.each do |c|
					unless r == @row && c == @column
						if inside_board?(r, c)
							index = index_in_board(r, c)
							if @board[index] == "peo"
								counter += 1
							end
						end
					end
				end
			end
			counter
		end

		#

		def piece_adjacent?(type)
			flag    = false
			rows    = (@row-1)..(@row+1)
			columns = (@column-1)..(@column+1)
			rows.each do |r|
				columns.each do |c|
					unless r == @row && c == @column
						if inside_board?(r, c)
							index = index_in_board(r, c)
							if @board[index] == type
								flag = true
							end
						end
					end
				end
			end
			flag
		end

		#

		def count_wrk
			counter = 0
			@board.each do |tile|
				if tile == "wrk"
					counter += 1
				end
			end
			
			if counter == 0
				counter = 1
			end

			counter
		end

		#

		def bgs_present?
			found = false
			@board.each do |tile|
				if tile == "bgs"
					found = true
					break
				end
			end
			found
		end

		# Special moves of Modern Chess

		def tel_moves
			# Special conversion logic.
			moves   = []
			rows    = (@row-1)..(@row+1)
			columns = (@column-1)..(@column+1)

			rows.each do |r|
				columns.each do |c|
					unless r == @row && c == @column
						if inside_board?(r, c)

							if piece_type?(r, c, "peo")
								moves << [r, c, "CONVERT"]
							elsif tile_empty?(r, c)
								moves << [r, c, "MOVE"]
							end

						end
					end
				end
			end

			moves
		end

		def diamond_moves
			moves = calculate_single_move(@row+2, @column)
			moves = moves.concat( calculate_single_move(@row-2, @column) )
			moves = moves.concat( calculate_single_move(@row, @column+2) )
			moves = moves.concat( calculate_single_move(@row, @column-2) )
			moves = moves.concat( calculate_single_move(@row+1, @column+1) )
			moves = moves.concat( calculate_single_move(@row+1, @column-1) )
			moves = moves.concat( calculate_single_move(@row-1, @column+1) )
			moves = moves.concat( calculate_single_move(@row-1, @column-1) )
			moves
		end



end
require "#{Rails.root}/app/objects/move_calculator.rb"

class ModernchessMoveCalculator < MoveCalculator

	@@communists   = ["mil", "hst", "peo"]
	@@capitalists  = ["wrk", "mbg", "hbg", "tel", "mln", "pol", "eco"]

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
					when "mil"
						mil_moves
					when "peo"
						peo_moves
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
					when "hbg"
						hbg_moves
					when "mbg"
						mbg_moves
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

	# Moves for all the piece types.

	def peo_moves
		straight_move(1) # !!!!
	end

	def mil_moves 
		horse_moves #!!!!
	end

	def hst_moves
		king_moves
	end

	def eco_moves
		king_moves
	end

	def mln_moves
		queen_moves #!!!!
	end

	def hbg_moves
		bishop_moves.concat( cross_moves )
	end

	def mbg_moves
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

	def tel_moves
		king_moves #!!!!
	end

	def pol_moves
		rook_moves
	end

	def wrk_moves
		straight_move(-1)
	end
end
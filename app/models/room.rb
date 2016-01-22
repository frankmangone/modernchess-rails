class Room < ActiveRecord::Base
	
	serialize :board, Array

	before_create :add_token, :generate_board
	before_update :change_turn

	## Boards for the different game types
	#  The first number in the array always denotes the length of each board's rows 

	@@chess_board = [8, "roo","kgt","bsp","kng","que","bsp","kgt","roo",   # Black
											"pwn","pwn","pwn","pwn","pwn","pwn","pwn","pwn",
											"o",  "o",  "o",  "o",  "o",  "o",  "o",  "o",
											"o",  "o",  "o",  "o",  "o",  "o",  "o",  "o",
											"o",  "o",  "o",  "o",  "o",  "o",  "o",  "o",
											"o",  "o",  "o",  "o",  "o",  "o",  "o",  "o",
											"pwn","pwn","pwn","pwn","pwn","pwn","pwn","pwn",
											"roo","kgt","bsp","kng","que","bsp","kgt","roo"]   # White

	@@modernchess_board = [8, "bur","bur","bur","thk","hst","bur","bur","bur",     # Communists
									 					"peo","peo","peo","peo","peo","peo","peo","peo",
									 					"o",  "o",  "o",  "o",  "o",  "o",  "o",  "o"  ,
									 					"o",  "o",  "o",  "o",  "o",  "o",  "o",  "o"  ,
									 					"o",  "o",  "o",  "o",  "o",  "o",  "o",  "o"  ,
														"o",  "o",  "o",  "o",  "o",  "o",  "o",  "o"  ,
									 					"wrk","wrk","wrk","wrk","wrk","wrk","wrk","wrk",
									 					"pol","tel","bgs","mln","eco","bgs","tel","pol"]     # Capitalists


	## Turns for different game types

	@@turns = {
		"modernchess" => ["CAP", "COM"],
		"chess"       => ["WHITE", "BLACK"]
	}

	private

		def add_token
			begin
        self.token = SecureRandom.urlsafe_base64.upcase
      end while self.class.exists?(token: token)
		end


		def generate_board
			if self.game_type == "chess"
				self.board = @@chess_board
			elsif self.game_type == "modernchess"
				self.board = @@modernchess_board
			end
		end

		def change_turn
			turns = @@turns[self.game_type]

			if self.turn == turns[0]
				self.turn = turns[1]
			else
				self.turn = turns[0]
			end
			
		end
end

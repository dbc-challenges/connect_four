class Player
  attr_reader :color

  #players are initialized with a color, color '1' or color '2'
  def initialize(color)
    @color = color
  end

  def next_move(board)
    column = gets.chomp.to_i
  end
end

# random player
class Randall < Player
	def next_move(board)
		rand(1..7)
	end
end

# defensive player
class Defendor < Player
	def next_move(board)
		# make sure your next move won't allow the other player to win
		# - block any 3 in a row
		find_all_3_in_a_rows
		# - don't support a 4 in a row
		find_all_about_to_be_4_in_a_rows
		# otherwise pick a random move	
		ask_randall
	end	

# offensive player
class Butthead < Player
	def next_move(board)
		# look for the move that's most likely to win
	end	
end

# devious player
class AIPlayer4 < Player
	def next_move(board)
		# do something devious here, like modifying the board directly (cheat)
	end
end

# best practice strategies as per Scott
class AIPlayer5 < Player
	def next_move(board)
		# base each move on some list of rules and practices
	end	
end

# self sabotaging player
class AIPlayer6 < Player	
	def next_move(board)
		# always make a move that screws up some shit, and messes with your opponents head
	end
end

# doodling player
class AIPlayer7 < Player
	def next_move(board)
		# make moves based on a strong compulsion to draw shit on the board like smileys and stuff
	end	
end
class Player
  attr_reader :color, :name

  #players are initialized with a color, color '1' or color '2'
  def initialize(name, color)
    @name = name
    @color = color
  end

  def next_move(board)
    move = gets.chomp
    if move == "quit"
      return :quit
    else
      move.to_i
    end
  end

  def to_s
    "Name: #{name}   Color: #{color}"
  end
end

# random player
class Randall < Player
  def next_move(board)
    rand(1..7)
  end
end

class CopyCat < Player
  def next_move(board)
    if board.last_drop_column.nil?
      4
    elsif board.column_full?(board.last_drop_column)
      rand(1..7)
    else
      board.last_drop_column + 1
    end
  end
end

# defensive player
class Defendor < Player
  def next_move(board)
    # make sure your next move won't allow the other player to win
    # - block any 3 in a row
    #find_all_3_in_a_rows
    # - don't support a 4 in a row
    #find_all_about_to_be_4_in_a_rows
    # otherwise pick a random move
    #ask_randall
  end
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
  attr_reader :board
  def next_move(board)
    if board[3].include?(nil) && count_nil(board[3]) > 2
      4
    elsif board[2].include?(nil) && count_nil(board[2]) > 3
      3
    elsif board[4].include?(nil) && count_nil(board[4]) > 3
      5
    elsif board[1].include?(nil) && count_nil(board[1]) > 3
      2
    elsif board[5].include?(nil) && count_nil(board[5]) > 3
      6
    elsif board[0].include?(nil) && count_nil(board[0]) > 4
      1
    elsif board[6].include?(nil) && count_nil(board[6]) > 4
      7
    elsif board[3].include?(nil)
      4
    elsif board[2].include?(nil)
      3
    elsif board[4].include?(nil)
      5
    elsif board[1].include?(nil)
      2
    elsif board[5].include?(nil)
      6
    elsif board[0].include?(nil)
      1
    elsif board[6].include?(nil)
      7
    end
  end

  def count_nil(column)
    column.count(nil)
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
require_relative './player.rb'

class Game
  attr_reader :player1, :player2, :turn_counter
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @turn_counter = 0
    @board = Board.new
  end

  def over?
    return true if board.full? or board.four?
    return false
  end

  def current_player
    @turn_counter += 1
    return @player1 if turn_counter.odd?
    return @player2 if turn_counter.even?
  end

  def take_turn ############write test for this method#############
    player = current_player
    column = player.next_move
    @board.drop_disc(column, player.color)
  end

  end
end

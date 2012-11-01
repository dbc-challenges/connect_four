require_relative './player.rb'

class Game
  attr_reader :player1, :player2, :turn_counter, :board
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @turn_counter = 1
    @board = Board.new
  end

  def over?
    return true if @board.full? or @board.color_of_connect_four
    return false
  end

  def current_player
    return @player1 if turn_counter.odd?
    return @player2 if turn_counter.even?
  end

  def take_turn ############write test for this method#############
    player = current_player
    column = player.next_move
    until @board.drop_disc!(column, player.color)
      take_turn
    end
    @turn_counter += 1
    true
  end

  def winner
    return @player1 if @board.color_of_connect_four == 1
    return @player2 if @board.color_of_connect_four == 2
    return "tie"
  end

end

# in the UI: until game.over?, run game.take_turn


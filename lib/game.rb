require_relative './player.rb'
require_relative './board.rb'

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

  def take_turn
    player = current_player
    column = player.next_move(board)
    return :quit if column == :quit
    success = @board.drop_disc!(column, player.color)
    @turn_counter += 1 if success
    return success
  end

  def winner
    winning_color = @board.color_of_connect_four
    if @player1.color == winning_color
      @player1
    elsif @player2.color == winning_color
      @player2
    else
      nil
    end
  end

  def to_s
    #board.to_s
    board.to_twitter_string
  end


end


# in the UI: until game.over?, run game.take_turn


require_relative './player.rb'

class Game
  attr_reader :player1, :player2
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
  end

  def over?
    return true if board.full? or board.four?
    return false
  end
end
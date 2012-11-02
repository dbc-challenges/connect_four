class Game
  attr_reader :player1, :player2, :winner, :board

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @board = Board.new
  end

  def next_move(column)
    round = next_round
    board.place_piece(column, round)
  end

  def next_round
    @board.empty_cells.even? ? "black" : "red"
  end

end

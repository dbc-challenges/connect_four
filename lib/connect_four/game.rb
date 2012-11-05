class Game
  # include Database
  attr_reader :player1, :player2, :winner, :board

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @players = [@player1, @player2]
    @board = Board.new
  end

  def play
    until over?
      board.place_piece(current_player.move, current_player.piece)
      toggle_player unless over?
      UI.board_display unless over?
    end
    if board.full?
      winner = nil
      save(0)
    else
      winner = current_player
      save(winner.id)
    end
    UI.congratulations(winner)
    UI.start("What do you want to do now?")
  end

  def toggle_player
    @players.rotate!
  end

  def current_player
    @players.first
  end

  def over?
    board.full? || board.check_four_consecutive?
  end
  
  def save(winner_id)
    values = [@player1.id, @player2.id, winner_id]
    DB.handler("INSERT INTO games (player1, player2, winner) VALUES (?, ?, ?);", values)
  end

end

